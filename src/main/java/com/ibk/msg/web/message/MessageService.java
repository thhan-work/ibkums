package com.ibk.msg.web.message;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.ibk.msg.common.dto.AsisFileDataForm;
import com.ibk.msg.utils.AsisFileHandler;
import com.ibk.msg.web.loglist.LogListDao;
import com.ibk.msg.web.message.model.MessageDto;
import com.ibk.msg.web.message.model.MsgSend;
import com.ibk.msg.web.message.model.MsgSendInfo;


@Component
public class MessageService {

	@Autowired
	private MessageDao dao;
	
	@Autowired
	private LogListDao logDao;
	
	
	private static final Logger logger = LoggerFactory.getLogger(MessageService.class);

	@Transactional(transactionManager = "ibkSmsTxManager")
	public Object sendMsg(HttpSession session, MessageDto messageDto){
		// Step 1 메시지 한도 체크 (2018.10.21 한도체크 X)
		
		// Step 2 메시지 정보 체크
        int all_count = 0;
        int send_count = 0;
        int cut_count = 0;
        int exceed_count = 0;
        int unit_discord_count = 0;
        int etc_count = 0;
		
		
		MsgSendInfo request_msgsendinfo = new MsgSendInfo();
		request_msgsendinfo.setDesCode(session.getAttribute("EMPL_BOCODE").toString());
		request_msgsendinfo.setUnitCode("CC");
		request_msgsendinfo.setEmplId(session.getAttribute("EMPL_ID").toString());
		request_msgsendinfo.setIsAD(messageDto.getIsAd());
		request_msgsendinfo.setPartName("");//부서명 @@@@@@@@@@@@@@@@@@@ 추가필요
		request_msgsendinfo.setTranCallback(messageDto.getSender().replaceAll("-", ""));
		request_msgsendinfo.setTranMsg(messageDto.getMessage());
		
		if ((messageDto.getReserveDate()) == null || (messageDto.getReserveDate().trim().equals("")) || messageDto.getReserveDate().trim().length() == 0) {
			request_msgsendinfo.setTranDate("SYSDATE");
		} else {
			request_msgsendinfo.setTranDate(messageDto.getReserveDate());
		}
		
		if(messageDto.getSendType().toUpperCase().equals("SMS")){
			request_msgsendinfo.setUserAD(messageDto.getUserAd());
		}else if(messageDto.getSendType().toUpperCase().equals("MMS")){
			request_msgsendinfo.setUserAD(messageDto.getUserAd());
			request_msgsendinfo.setFileCt("0");
		}
		
		// Step 3 개별 메시지 처리
		Hashtable<String, MsgSendInfo> ht = new Hashtable<String, MsgSendInfo>();
		List<MsgSendInfo> rcvSendList = new ArrayList<MsgSendInfo>();
		List<MsgSendInfo> rcvLogList = new ArrayList<MsgSendInfo>();
		
		String[] receivers = messageDto.getReceivers().split("[|]");
		
		MsgSend msgSend = new MsgSend();
		
		for (String receiver : receivers) {
			String split[] = receiver.split("[:]");

			MsgSendInfo request_msgsendrcv = new MsgSendInfo();
			request_msgsendrcv.setMsgSendInfo(request_msgsendinfo);
			request_msgsendrcv.setRcvName(split[0].trim());
			request_msgsendrcv.setRcvPhone(split[1].trim());
			
			if(messageDto.getSendType().toUpperCase().equals("MMS")){
				request_msgsendrcv.setRcvSubject(messageDto.getTitle());
				request_msgsendrcv.setRcvMsg(request_msgsendinfo.getTranMsg());
			}
			
			if (logger.isDebugEnabled())
				logger.debug(request_msgsendrcv.getRcvPhone() + " = " +  request_msgsendrcv.getRcvName());

			if(ht.get(request_msgsendrcv.getRcvPhone()) == null)
			{
				ht.put(request_msgsendrcv.getRcvPhone(), request_msgsendrcv);
				
				String rslt = sendValidation(request_msgsendrcv);
				
				//20190718 by yoosin 수신거부 체크 여부 확인
				if(request_msgsendrcv.getUserAD() != null && request_msgsendrcv.getUserAD().equals("1")){
					msgSend.setCheckUnsubscribe(false);
				}else{
					msgSend.setCheckUnsubscribe(true);
				}
				
				if (rslt.equals("0")) {//정상 발송 데이터
					String sendType = messageDto.getSendType().toUpperCase();
					request_msgsendrcv.setTranStatus(sendType.equals("SMS") ? "1":"0");
					request_msgsendrcv.setTranRslt(null);
						
					rcvSendList.add(request_msgsendrcv);
					send_count++;
				} else if (rslt.equals("X")) { // 발송 X 로그 O 데이터
					request_msgsendrcv.setTranStatus("3");
					request_msgsendrcv.setTranRslt("X");
					
					rcvLogList.add(request_msgsendrcv);
					cut_count++;
				} else { // 그외 오류처리
					etc_count++;
				}
			}
		} // end for
		
		if(logger.isDebugEnabled()) {
			logger.debug("실건수:" + receivers.length + ", 중복제거 후 건수:" + ht.size());
		}
		
		if(logger.isDebugEnabled()) {
			MsgSendInfo msr = null;
			Enumeration<MsgSendInfo> enu = ht.elements();
			while(enu.hasMoreElements()) {
				msr = enu.nextElement();
					logger.debug(msr.getRcvPhone() + " = " +  msr.getRcvName());
			}
		}
		
		//-------------발송을 위한 데이터 처리 
		
		// tranId 업무코드 생성 ( UNITCODE + 부서코드 + '_' + 회원ID )
		String tranId = request_msgsendinfo.getUnitCode() + request_msgsendinfo.getDesCode() +"_"+ request_msgsendinfo.getEmplId();
		msgSend.setTranId(tranId);
		msgSend.setSendType(messageDto.getSendType().toUpperCase());
		
		msgSend.setMsgSendList(rcvSendList);
		msgSend.setMsgLogList(rcvLogList);
		
		// Send
		int cutCnt = sendMsgList(msgSend);

		//수신거부 체크 시 처리된 수신거부 건수 합산 
		if(cutCnt >= 0 && msgSend.isCheckUnsubscribe()){
			cut_count = cut_count + cutCnt;
			send_count = send_count - cut_count;
		}
		
        all_count = send_count + cut_count + exceed_count + unit_discord_count + etc_count;

        Hashtable<String, Integer> h = new Hashtable<String, Integer>();
        h.put("ALL_COUNT", new Integer(all_count));
        h.put("SEND_COUNT", new Integer(send_count));
        h.put("CUT_COUNT", new Integer(cut_count));
        h.put("EXCEED_COUNT", new Integer(exceed_count));
        h.put("UNIT_DISCORD_COUNT", new Integer(unit_discord_count));
        h.put("ETC_COUNT", new Integer(etc_count));
        h.put("DUP_COUNT", msgSend.getMsgSendList().size() + msgSend.getMsgLogList().size());
        
        
        // 이벤트 로그 작성
		HashMap<String, String> pram = new HashMap<String, String>();
		String logMsg = "[발송]";
		if ((messageDto.getReserveDate()) == null || (messageDto.getReserveDate().trim().equals("")) || messageDto.getReserveDate().trim().length() == 0) {
			logMsg = "[예약발송(" + messageDto.getReserveDate()+ ")]";
		}
		logMsg = logMsg + messageDto.getSendType().toUpperCase() + " 문자 " + send_count + "건 발송";
		
		pram.put("emplId", request_msgsendinfo.getEmplId());
		pram.put("category", "등록");
		pram.put("menu", "일반보내기");
		pram.put("content", logMsg);
//		logDao.recordLog(pram);
    
        return h;
	}
  
	
	
	/**
	 * 메시지 발송 및 로그처리
	 *
	 * @param request_msgsendinfo
	 * @return
	 */
	public int sendMsgList(MsgSend request_msgsendinfo){

		int result = -1;

		//로그테이블 
		SimpleDateFormat yyyymm = new SimpleDateFormat("yyyyMM");
		request_msgsendinfo.setLogDate(yyyymm.format(new Date()));
		
		logger.info("#####SEND MSG TYPE :" + request_msgsendinfo.getSendType());
		logger.info("#####SEND DATA LIST :" + request_msgsendinfo.getMsgSendList().size());
		logger.info("#####LOG DATA LIST :" + request_msgsendinfo.getMsgLogList().size());
		
		if(request_msgsendinfo.getSendType().equals("SMS")) // SMS 발송 및 로그(미발송건) 처리 
		{
			if(request_msgsendinfo.getMsgSendList().size() > 0) // 발송
			{
				if(request_msgsendinfo.isCheckUnsubscribe()){	// 수신거부 처리 O
					String pollingkey = dao.getSeq();	// 수신거부 건수를 확인을 위한 KEY
					request_msgsendinfo.setPollingkey(pollingkey);
					
					//500건씩 나눠서 INSERT
					List<MsgSendInfo> targetList = request_msgsendinfo.getMsgSendList();
					List<MsgSendInfo> copyList =  new ArrayList<MsgSendInfo>();
					int insertCnt = 500;
					for(int i= 0; i <= targetList.size()/insertCnt; i++){
						if(i == targetList.size()/insertCnt){
							copyList = targetList.subList(i*insertCnt, targetList.size());
						}else{
							copyList = targetList.subList(i*insertCnt, ((i+1)*insertCnt));
						}
						
						request_msgsendinfo.setMsgSendList(copyList);
						int sendSMS = dao.sendSMS(request_msgsendinfo);
						logger.info("sendSMS : {}", sendSMS);
					}
					
					// 건수 처리를 위한 List 재배치
					request_msgsendinfo.setMsgSendList(targetList);
					// 수신거부 처리 건수 
					result = dao.getSMSUnsubscribeCount(request_msgsendinfo);
				}else{
					//500건씩 나눠서 INSERT
					List<MsgSendInfo> targetList = request_msgsendinfo.getMsgSendList();
					List<MsgSendInfo> copyList =  new ArrayList<MsgSendInfo>();
					int insertCnt = 500;
					for(int i= 0; i <= targetList.size()/insertCnt; i++){
						if(i == targetList.size()/insertCnt){
							copyList = targetList.subList(i*insertCnt, targetList.size());
						}else{
							copyList = targetList.subList(i*insertCnt, ((i+1)*insertCnt));
						}
						
						request_msgsendinfo.setMsgSendList(copyList);
						result = dao.sendSMSWithoutUnsubscribe(request_msgsendinfo);
					}
				}
			}
			
			if(request_msgsendinfo.getMsgLogList().size() > 0) // 로그(미발송 에러건)
			{
				result = dao.logSMS(request_msgsendinfo);
			}
		}
		
		
		if(request_msgsendinfo.getSendType().equals("MMS")) // MMS 발송 및 로그(미발송건) 처리 
		{
			if(request_msgsendinfo.getMsgSendList().size() > 0) // 발송
			{
				if(request_msgsendinfo.isCheckUnsubscribe()){
					String pollingkey = dao.getSeq();	// 수신거부 건수를 확인을 위한 KEY
					request_msgsendinfo.setPollingkey(pollingkey);
					
					//500건씩 나눠서 INSERT
					List<MsgSendInfo> targetList = request_msgsendinfo.getMsgSendList();
					List<MsgSendInfo> copyList =  new ArrayList<MsgSendInfo>();
					int insertCnt = 500;
					for(int i= 0; i <= targetList.size()/insertCnt; i++){
						if(i == targetList.size()/insertCnt){
							copyList = targetList.subList(i*insertCnt, targetList.size());
						}else{
							copyList = targetList.subList(i*insertCnt, ((i+1)*insertCnt));
						}
						
						request_msgsendinfo.setMsgSendList(copyList);
						dao.sendMMS(request_msgsendinfo);
					}
					
					// 건수 처리를 위한 List 재배치
					request_msgsendinfo.setMsgSendList(targetList);
					
					// 수신거부 처리 건수 				
					result = dao.getMMSUnsubscribeCount(request_msgsendinfo);
				}else{
					
					//500건씩 나눠서 INSERT
					List<MsgSendInfo> targetList = request_msgsendinfo.getMsgSendList();
					List<MsgSendInfo> copyList =  new ArrayList<MsgSendInfo>();
					int insertCnt = 500;
					for(int i= 0; i <= targetList.size()/insertCnt; i++){
						if(i == targetList.size()/insertCnt){
							copyList = targetList.subList(i*insertCnt, targetList.size());
						}else{
							copyList = targetList.subList(i*insertCnt, ((i+1)*insertCnt));
						}
						
						request_msgsendinfo.setMsgSendList(copyList);
						result = dao.sendMMSWithoutUnsubscribe(request_msgsendinfo);
					}
				}
			}
			
			if(request_msgsendinfo.getMsgLogList().size() > 0) // 로그(미발송 에러건)
			{
				result = dao.logMMS(request_msgsendinfo);
			}
		}
		
		
		
		return result;
	}
	
	
	/**
	 * 발송여부 벨리데이션
	 * 
	 * @param request_msgsendrcv
	 * @return
	 */
	public String sendValidation(MsgSendInfo request_msgsendrcv){
		
		// 부점코드 4자리
		if(request_msgsendrcv.getDesCode().length() > 4)
		{
//			f_des_code := ltrim(to_char(to_number(descode),'0999'));
//			IF SUBSTR(f_des_code,1,1) = '0' THEN
//				f_des_code := substr(f_des_code, 2);
//			END IF;
		}
		
		//'YYYYMMDDHH24MISS'
		String tranDate = request_msgsendrcv.getTranDate();
		if(tranDate == null || tranDate.equals("") || tranDate.toUpperCase().equals("SYSDATE")){
			SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyyMMddHHmmss", Locale.KOREA );
			Date currentTime = new Date ();
			tranDate = mSimpleDateFormat.format ( currentTime );
			
			request_msgsendrcv.setTranDate(tranDate);
		}
		
		//userAD 서비스 품질보증서 신청고객 여부(미신청자: 0, 신청자: 1) or MMS
		if(request_msgsendrcv.getUserAD() == null || request_msgsendrcv.getUserAD().equals("0")){
			// 발신번호에 대한 세칙준수를 위해 추가(2015.10.08)
			String callback = "15662566";
			if(request_msgsendrcv.getTranCallback() != null || !request_msgsendrcv.getTranCallback().equals("")){
				callback = request_msgsendrcv.getTranCallback().trim().replaceAll("[^0-9]", "").replaceAll("0215662566", "15662566");
			}
			request_msgsendrcv.setTranCallback(callback);
		}

		if(request_msgsendrcv.getTranCallback().length() < 8 ){
			logger.error("sendValidation !!! getTranCallback().length() < 8 !!!      getTranCallback().length() :" + request_msgsendrcv.getTranCallback().length());
			return "2";
		}

		
//		-- 메시지 라인 구분자 변환
//		tranmsg := replace(msg, '{n}', chr(10));

		//전화번호 벨리데이션
		String phone = request_msgsendrcv.getRcvPhone();
		if (phone == null){
			logger.error("sendValidation !!! phone Is Null !!!");
			return "2";
		}
		
		phone = phone.replaceAll("[^0-9]", "");
		
		if(phone.length() < 10){ 
			logger.error("sendValidation !!! phone.length() < 10 !!!         phone.length() : " + phone.length());
			return "2";
		}
		if(!phone.substring(0, 2).equals("01")){ 
			logger.error("sendValidation !!! !phone.substring(0, 2).equals('01') !!!         phone.substring(0, 2) : " + phone.substring(0, 2));
			return "2";
		}
		if(phone.substring(3, 9).equals("11111111") || phone.substring(3, 9).equals("00000000")){ 
			logger.error("sendValidation !!! phone.substring(3, 9).equals('11111111') || phone.substring(3, 9).equals('00000000') !!!         phone.substring(3, 9) : " + phone.substring(3, 9));
			return "2";
		}

		request_msgsendrcv.setRcvPhone(phone);
		
		
//		-- OPT-IN 체크 추가 (2005-03-21)
		if(!request_msgsendrcv.getEmplId().equals("60739"))
		{
			int optin = optInCheck(request_msgsendrcv);
			if(optin == 1){
				logger.error("sendValidation !!! OPT-IN !!!");
				return "X";
			}
		}
		
		// messageCheck (수신거부여부)
//		if(request_msgsendrcv.getUserAD() == null || request_msgsendrcv.getUserAD().equals("0")){
//			if(messageCheck(request_msgsendrcv) == 1){
//				logger.error("sendValidation !!! messageCheck(수신거부) !!!");
//				return "X";
//			}
//		}
		
		
		return "0";
	}
	
	/**
	 * 발송여부 벨리데이션
	 * 
	 * @param request_msgsendrcv
	 * @return
	 */
	public String sendValidationWithoutMessageCheck(MsgSendInfo request_msgsendrcv){
		
		// 부점코드 4자리
		if(request_msgsendrcv.getDesCode().length() > 4)
		{
//			f_des_code := ltrim(to_char(to_number(descode),'0999'));
//			IF SUBSTR(f_des_code,1,1) = '0' THEN
//				f_des_code := substr(f_des_code, 2);
//			END IF;
		}
		
		//'YYYYMMDDHH24MISS'
		String tranDate = request_msgsendrcv.getTranDate();
		if(tranDate == null || tranDate.equals("") || tranDate.toUpperCase().equals("SYSDATE")){
			SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyyMMddHHmmss", Locale.KOREA );
			Date currentTime = new Date ();
			tranDate = mSimpleDateFormat.format ( currentTime );
			
			request_msgsendrcv.setTranDate(tranDate);
		}
		
		//userAD 서비스 품질보증서 신청고객 여부(미신청자: 0, 신청자: 1) or MMS
		if(request_msgsendrcv.getUserAD() == null || request_msgsendrcv.getUserAD().equals("0")){
			// 발신번호에 대한 세칙준수를 위해 추가(2015.10.08)
			String callback = "15662566";
			if(request_msgsendrcv.getTranCallback() != null || !request_msgsendrcv.getTranCallback().equals("")){
				callback = request_msgsendrcv.getTranCallback().trim().replaceAll("[^0-9]", "").replaceAll("0215662566", "15662566");
			}
			request_msgsendrcv.setTranCallback(callback);
		}

		if(request_msgsendrcv.getTranCallback().length() < 8 ){
			logger.error("sendValidation !!! getTranCallback().length() < 8 !!!      getTranCallback().length() :" + request_msgsendrcv.getTranCallback().length());
			return "2";
		}

		
//		-- 메시지 라인 구분자 변환
//		tranmsg := replace(msg, '{n}', chr(10));

		//전화번호 벨리데이션
		String phone = request_msgsendrcv.getRcvPhone();
		if (phone == null){
			logger.error("sendValidation !!! phone Is Null !!!");
			return "2";
		}
		
		phone = phone.replaceAll("[^0-9]", "");
		
		if(phone.length() < 10){ 
			logger.error("sendValidation !!! phone.length() < 10 !!!         phone.length() : " + phone.length());
			return "2";
		}
		if(!phone.substring(0, 2).equals("01")){ 
			logger.error("sendValidation !!! !phone.substring(0, 2).equals('01') !!!         phone.substring(0, 2) : " + phone.substring(0, 2));
			return "2";
		}
		if(phone.substring(3, 9).equals("11111111") || phone.substring(3, 9).equals("00000000")){ 
			logger.error("sendValidation !!! phone.substring(3, 9).equals('11111111') || phone.substring(3, 9).equals('00000000') !!!         phone.substring(3, 9) : " + phone.substring(3, 9));
			return "2";
		}

		request_msgsendrcv.setRcvPhone(phone);
		
		
//		-- OPT-IN 체크 추가 (2005-03-21)
		if(!request_msgsendrcv.getEmplId().equals("60739"))
		{
			int optin = optInCheck(request_msgsendrcv);
			if(optin == 1){
				logger.error("sendValidation !!! OPT-IN !!!");
				return "X";
			}
		}
		
		return "0";
	}
	
	
	//수신거부 확인
	/**
	 * 수신거부 대상자 확인
	 * 
	 * @param request_msgsendrcv
	 * @return
	 */
	public int messageCheck(MsgSendInfo request_msgsendrcv)
	{
		String phone = request_msgsendrcv.getRcvPhone() == null ?"":request_msgsendrcv.getRcvPhone();
		String unitCode = request_msgsendrcv.getUnitCode() == null ?"":request_msgsendrcv.getUnitCode();
		String isAd = request_msgsendrcv.getIsAD() == null ?"":request_msgsendrcv.getIsAD();

		String cut_option = dao.getCutOption(phone);
		
		if(cut_option == null)
		{
			return 0;
		}
		
		char d1 = cut_option.charAt(0);
		char d2 = cut_option.charAt(1);
		char d3 = cut_option.charAt(2);
		char d4 = cut_option.charAt(3);
		
		if(d1 == '1'){
			String opt = dao.getOpt(unitCode);
			if(opt == null){
				return 1;
			}
			
			if(!opt.equals("1")){
				return 1;
			}
		}
		
		//    -- 'CA', 'YC' check
		if(d3 == '1' && unitCode.equals("CA")){
			return 1;
		}
		if(d4 == '1' && unitCode.equals("YC")){
			return 1;
		}
		
	    //   -- ad check
		if(d2 == '1' && isAd.equals("1")){
			return 1;
		}
		
		return 0;
	}
	
	
	
	
	/**
	 * 	-- OPT-IN 체크
		--     08:10:00 ~ 20:50:00시 사이 시간이면 발송한다. 2008년 1월 14이 ㄹ폐기
		--     08:00:00 ~ 22:00:00시 사이 시간이면 발송한다.
		--     07:00:00 ~ 21:59:00 사이가 아니면 OPT-IN 등록 정보를 체크한 후 발송여부를 결정한다.
		-- return_value '0':전송 '1':차단
	 * 
	 * ??????????????????????????????????? ASIS 소스 확인해보면 어느때든 항상..0(전송)을 리턴함...........
	 * @return
	 */
	public int optInCheck(MsgSendInfo request_msgsendrcv)
	{
		int result = 0;
		
		SimpleDateFormat time = new SimpleDateFormat("HHmmss");

		Date date = new Date();
		
		int reservetime = Integer.parseInt(time.format(date));
		if(reservetime >= 80000 && reservetime <= 220000){
			result = 0;
		}
		
		return result;
	}



	/**
	 * 수신번호 : 파일 업로드 처리 
	 * 
	 * @param uploadFile
	 * @param session
	 * @return
	 */
	public List<AsisFileDataForm> handleFile(MultipartFile uploadFile, HttpSession session,String type) throws Exception {
		  //List<AsisFileDataForm> fileList=AsisFileHandler.hadleFile(uploadFile, session, type);
		  //if(fileList ==null||fileList.size()==0) return null;
		
		List<AsisFileDataForm> list = AsisFileHandler.hadleFile(uploadFile, session, type);
		
		return list;
	}
	
	@Transactional(transactionManager = "ibkSmsTxManager")
	public Object sendBulkMsg(HttpSession session, List<AsisFileDataForm> fileList,String sendDate,String callBack,String type){
		// Step 1 메시지 한도 체크 (2018.10.21 한도체크 X)
		
		// Step 2 메시지 정보 체크
        int all_count = 0;
        int sms_send_count = 0;
        int sms_cut_count = 0;
        int sms_etc_count = 0;
        
        int mms_send_count = 0;
        int mms_cut_count = 0;
        int mms_etc_count = 0;
        
        int exceed_count = 0;
        int unit_discord_count = 0;
		
		
		MsgSendInfo request_msgsendinfo = new MsgSendInfo();
		request_msgsendinfo.setDesCode(session.getAttribute("EMPL_BOCODE").toString());
		request_msgsendinfo.setUnitCode("CC");
		request_msgsendinfo.setEmplId(session.getAttribute("EMPL_ID").toString());
		request_msgsendinfo.setIsAD(null);
		request_msgsendinfo.setPartName("");//부서명 @@@@@@@@@@@@@@@@@@@ 추가필요
		request_msgsendinfo.setTranCallback(callBack.replaceAll("-", ""));
		request_msgsendinfo.setTranDate(sendDate);
		
		// Step 3 개별 메시지 처리
		Hashtable<String, MsgSendInfo> sht = new Hashtable<String, MsgSendInfo>();
		List<MsgSendInfo> srcvSendList = new ArrayList<MsgSendInfo>();
		List<MsgSendInfo> srcvLogList = new ArrayList<MsgSendInfo>();
		
		Hashtable<String, MsgSendInfo> mht = new Hashtable<String, MsgSendInfo>();
		List<MsgSendInfo> mrcvSendList = new ArrayList<MsgSendInfo>();
		List<MsgSendInfo> mrcvLogList = new ArrayList<MsgSendInfo>();
		
				
		for (AsisFileDataForm data : fileList) {
			MsgSendInfo request_msgsendrcv = new MsgSendInfo();
			request_msgsendrcv.setMsgSendInfo(request_msgsendinfo);
			request_msgsendrcv.setSendType(data.getMsg2());
			request_msgsendrcv.setRcvName("이름없음");
			request_msgsendrcv.setRcvPhone(data.getMobile());
			
			if(data.getMsg2().toUpperCase().equals("MMS")){
				if(data.getMsg3()!=null&&!data.getMsg3().equals("제목없음")) {
					request_msgsendrcv.setRcvSubject(data.getMsg3());
				}
				request_msgsendrcv.setRcvMsg(data.getMsg1());
				request_msgsendrcv.setFileCt("0");
			}else {
				request_msgsendrcv.setUserAD("0");
				request_msgsendrcv.setTranMsg(data.getMsg1());
			}
			
			if (logger.isDebugEnabled())
				logger.debug(request_msgsendrcv.getRcvPhone() + " = " +  request_msgsendrcv.getRcvName());
			if(data.getMsg2().toUpperCase().equals("SMS")) {
				if(sht.get(request_msgsendrcv.getRcvPhone()) == null) {
					
					sht.put(request_msgsendrcv.getRcvPhone(), request_msgsendrcv);
					
					String rslt = "";
					if(type.equalsIgnoreCase("bulk")) {
						rslt=sendValidation(request_msgsendrcv);
					}else {
						rslt=sendValidationWithoutMessageCheck(request_msgsendrcv);
					}
					
					
					if (rslt.equals("0")) {//정상 발송 데이터
						String sendType = request_msgsendrcv.getSendType().toUpperCase();
						request_msgsendrcv.setTranStatus(sendType.equals("SMS") ? "1":"0");
						request_msgsendrcv.setTranRslt(null);
							
						srcvSendList.add(request_msgsendrcv);
						sms_send_count++;
					} else if (rslt.equals("X")) { // 발송 X 로그 O 데이터
						request_msgsendrcv.setTranStatus("3");
						request_msgsendrcv.setTranRslt("X");
						
						srcvLogList.add(request_msgsendrcv);
						sms_cut_count++;
					} else { // 그외 오류처리
						sms_etc_count++;
					}
				}
			}else if(data.getMsg2().toUpperCase().equals("MMS")) {
				if(mht.get(request_msgsendrcv.getRcvPhone()) == null) {
					
					mht.put(request_msgsendrcv.getRcvPhone(), request_msgsendrcv);
					
					String rslt = "";
					if(type.equalsIgnoreCase("bulk")) {
						rslt=sendValidation(request_msgsendrcv);
					}else {
						rslt=sendValidationWithoutMessageCheck(request_msgsendrcv);
					}
					
					if (rslt.equals("0")) {//정상 발송 데이터
						String sendType = request_msgsendrcv.getSendType().toUpperCase();
						request_msgsendrcv.setTranStatus(sendType.equals("SMS") ? "1":"0");
						request_msgsendrcv.setTranRslt(null);
							
						mrcvSendList.add(request_msgsendrcv);
						mms_send_count++;
					} else if (rslt.equals("X")) { // 발송 X 로그 O 데이터
						request_msgsendrcv.setTranStatus("3");
						request_msgsendrcv.setTranRslt("X");
						
						mrcvLogList.add(request_msgsendrcv);
						mms_cut_count++;
					} else { // 그외 오류처리
						mms_etc_count++;
					}
				}
				
			}
		} // end for
		
		if(logger.isDebugEnabled()) {
			logger.debug("실건수:" + (fileList.size()-1) + ", 중복제거 후 건수:" + (sht.size()+mht.size()));
		}
		
		if(logger.isDebugEnabled()) {
			Enumeration<MsgSendInfo> enu = sht.elements();
			while(enu.hasMoreElements()) {
				MsgSendInfo msr = enu.nextElement();
					logger.debug(msr.getRcvPhone() + " = " +  msr.getRcvName());
			}
			Enumeration<MsgSendInfo> menu = mht.elements();
			while(enu.hasMoreElements()) {
				MsgSendInfo msr = menu.nextElement();
					logger.debug(msr.getRcvPhone() + " = " +  msr.getRcvName());
			}
		}
		
		//-------------발송을 위한 데이터 처리 
		//MsgSend msgSend = new MsgSend();
		
		// tranId 업무코드 생성 ( UNITCODE + 부서코드 + '_' + 회원ID )
		String tranId = request_msgsendinfo.getUnitCode() + request_msgsendinfo.getDesCode() +"_"+ request_msgsendinfo.getEmplId();
		MsgSend msgSend =null;
		
		if(srcvSendList.size()>0||srcvLogList.size()>0) {
			msgSend = new MsgSend();
			
			// 수신거부 체크 여부 
			if(type.equalsIgnoreCase("bulk")) {
				msgSend.setCheckUnsubscribe(true);
			}else{
				msgSend.setCheckUnsubscribe(false);
			}
			
			msgSend.setTranId(tranId);
			msgSend.setSendType("SMS");
			
			msgSend.setMsgSendList(srcvSendList);
			msgSend.setMsgLogList(srcvLogList);
			int cutCnt = sendMsgList(msgSend);
			
			//수신거부 체크 시 처리된 수신거부 건수 합산 
			if(cutCnt >= 0 && msgSend.isCheckUnsubscribe()){
				sms_cut_count = sms_cut_count + cutCnt;
				sms_send_count = sms_send_count - sms_cut_count;
			}
		}
		
		if(mrcvSendList.size()>0||mrcvLogList.size()>0) {
			msgSend = new MsgSend();
			
			// 수신거부 체크 여부 
			if(!type.equalsIgnoreCase("bulk")) {
				msgSend.setCheckUnsubscribe(false);
			}
			
			msgSend.setTranId(tranId);
			msgSend.setSendType("MMS");
			
			msgSend.setMsgSendList(mrcvSendList);
			msgSend.setMsgLogList(mrcvLogList);
			int cutCnt = sendMsgList(msgSend);
			
			//수신거부 체크 시 처리된 수신거부 건수 합산 
			if(cutCnt >= 0 && msgSend.isCheckUnsubscribe()){
				mms_cut_count = mms_cut_count + cutCnt;
				mms_send_count = mms_send_count - mms_cut_count;
			}
		}
		
		
		
        all_count = sms_send_count + sms_cut_count + sms_etc_count+mms_send_count + mms_cut_count + mms_etc_count+exceed_count + unit_discord_count ;

        Hashtable<String, Integer> h = new Hashtable<String, Integer>();
        h.put("ALL_COUNT", new Integer(all_count));
        h.put("SEND_COUNT", new Integer(sms_send_count+mms_send_count));
        h.put("CUT_COUNT", new Integer(sms_cut_count+mms_cut_count));
        h.put("EXCEED_COUNT", new Integer(exceed_count));
        h.put("UNIT_DISCORD_COUNT", new Integer(unit_discord_count));
        h.put("ETC_COUNT", new Integer(sms_etc_count+mms_etc_count));
        //h.put("DUP_COUNT", msgSend.getMsgSendList().size() + msgSend.getMsgLogList().size());
        h.put("DUP_COUNT", srcvSendList.size() + srcvLogList.size()+mrcvSendList.size()+mrcvLogList.size());
        
        return h;
	}

}
