package com.ibk.msg.web.eventsend;

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
import org.springframework.ui.Model;

import com.ibk.msg.web.message.MessageService;
import com.ibk.msg.web.message.model.MessageDto;
import com.ibk.msg.web.message.model.MsgSend;
import com.ibk.msg.web.message.model.MsgSendInfo;


@Component
public class EventSendService {

	@Autowired
	private EventSendDao dao;
	
	@Autowired
	private MessageService messageService;
	
	private static final Logger logger = LoggerFactory.getLogger(EventSendService.class);

	/**
	 * 경조사보내기 로그인
	 * 
	 * @param event_id
	 * @param event_pw
	 * @param model 
	 * @return
	 */
	public String login(String event_id, String event_pw, Model model){
		//1. login 시도 성공 여부 체크
		//2. 로그인 성공 시
		//2-1. 직급 리스트 조회
		//2-2. 직위 리스트 조회
		//2-3. 경조사 보내기 화면 이동
		//3. 로그인 실패 시
		//3-1. 로그인 페이지로 이동
		
		//1. login 시도 성공 여부 체크
		String result = checkLogin(event_id, event_pw);
		
		logger.info(" 경조사 메시지 보내기 로그인 결과 : " + result);
		
		if (result.equals("LOGIN_OK")) {//2. 로그인 성공 시
			//2-1. 직급 리스트 조회
			List<PartInfo> classList = dao.getClassList();
			model.addAttribute("classList", classList);
			logger.info("ClassList : "+classList.toString());

			//2-2. 직위 리스트 조회
			List<PartInfo> positionList = dao.getPositionList();
			model.addAttribute("positionList", positionList);
			logger.info("PositionList : "+positionList.toString());
			
			//2-3. 경조사 보내기 화면 이동
			return "eventSend/send-event";
			
		} else if ( result.equals("PWD_DISCORD")) {
			model.addAttribute("errorMsg", "비밀번호 불일치");
			
		} else if ( result.equals("USER_DISCORD")) {
			model.addAttribute("errorMsg", "사용자 아이디 불일치");
			
		} else if ( result.equals("INFO_NOT_FOUND")) {
			model.addAttribute("errorMsg", "접근 정보 없음");
			
		} else {
			model.addAttribute("errorMsg", "오류가 발생했습니다.");
		}
		//3-1. 로그인 페이지로 이동
		return "eventSend/login";
	}

	
	public String checkLogin(String event_id, String event_pw) {
        String CON_ID = null;
        String CON_PWD = null;
        String rslt = null;
		
		// 로그인 가능 계정 정보 조회
		List<HashMap<String, String>> loginInfo = dao.checkLogin();
		
		if(loginInfo.size() < 1){ // 로그인 가능 계정 정보 없음
			logger.error(" 로그인 가능 계정 정보 없음 ");
			rslt = "INFO_NOT_FOUND";
		}
		
		for(HashMap<String, String> hash : loginInfo){
			CON_ID = hash.get("CON_ID") == null ? "" : hash.get("CON_ID");
			CON_PWD = hash.get("CON_PWD") == null ? "" : hash.get("CON_PWD");
			
            if (CON_ID.equals(event_id)) {
                if (CON_PWD.equals(event_pw)) {
                    rslt = "LOGIN_OK"; 
                } else {
                    rslt = "PWD_DISCORD"; 
                }

            } else {
                rslt = "USER_DISCORD";
            }
		}

		return rslt;
	}


	/**
	 * 경조사보내기 수신인 검색
	 * 
	 * @param type
	 * @param boCode
	 * @return 
	 */
	public List<PartInfo> search(String type, String boCode) {
		
		PartInfo request_partinfo = new PartInfo();
		List<PartInfo> resultList = null;
		
		// 영업점소속
		if(type.equals("code")) {
			request_partinfo.setBoCode(boCode);
			resultList = dao.getUserListDCon(request_partinfo);
		// 지역소속직원			
		} else if(type.equals("area")) {
			request_partinfo.setPartGrcd(boCode); //PART_GRCD
			resultList = dao.getPartList(request_partinfo) ;
		}
		return resultList;
	}


	/**
	 * 경조사보내기 메시지 발송
	 * 
	 * @param session
	 * @param messageDto
	 * @return
	 * @throws Exception 
	 */
	@Transactional(transactionManager = "ibkSmsTxManager")
	public Object sendMsg(String type, HttpSession session, MessageDto messageDto) throws Exception {
		boolean success = true;
		
		// Step 2 메시지 정보 체크
		MsgSendInfo request_msgsendinfo = new MsgSendInfo();
		request_msgsendinfo.setPartName("");//부서명 @@@@@@@@@@@@@@@@@@@ 추가필요
		request_msgsendinfo.setTranCallback(messageDto.getSender().replaceAll("-", ""));
		request_msgsendinfo.setTranMsg(messageDto.getMessage());
		request_msgsendinfo.setUnitCode("CC");
		
		// 발송시간 셋팅 (경조사 보내기는 예약발송 사용 X .혹시모르는 상황으로 추가해놓음)
		if ((messageDto.getReserveDate()) == null || (messageDto.getReserveDate().trim().equals("")) || messageDto.getReserveDate().trim().length() == 0) {
			request_msgsendinfo.setTranDate("SYSDATE");
		} else {
			request_msgsendinfo.setTranDate(messageDto.getReserveDate());
		}

		logger.debug("##경조사보내기 발송 데이터 정보 TYPE="+type+"\n"+request_msgsendinfo.toString());

		Hashtable<String, MsgSendInfo> ht = new Hashtable<String, MsgSendInfo>();
		List<MsgSendInfo> rcvSendList = new ArrayList<MsgSendInfo>();
		List<MsgSendInfo> rcvLogList = new ArrayList<MsgSendInfo>();
		
		if (type.toUpperCase().equals("ALL")){			// 전체 경조사 보내기
			request_msgsendinfo.setEmplClass("ALL");
			request_msgsendinfo.setEmplPositionName("ALL");

			List<MsgSendInfo> rcvTargetList = dao.getTargetAllList(request_msgsendinfo);
			
			for(MsgSendInfo request_msgsendrcv : rcvTargetList){
				request_msgsendrcv.setMsgSendInfo(request_msgsendinfo);
				
				logger.debug(request_msgsendrcv.getRcvPhone() + " = " +  request_msgsendrcv.getRcvName());

				if(ht.get(request_msgsendrcv.getRcvPhone()) == null){//전화번호 중복체크
					ht.put(request_msgsendrcv.getRcvPhone(), request_msgsendrcv);
					
					String rslt = sendValidation(request_msgsendrcv);
					
					if (rslt.equals("0")) {//정상 발송 데이터
						String sendType = messageDto.getSendType().toUpperCase();
						request_msgsendrcv.setTranStatus(sendType.equals("SMS") ? "1":"0");
						request_msgsendrcv.setTranRslt(null);
							
						rcvSendList.add(request_msgsendrcv);
					} else if (rslt.equals("X")) { // 발송 X 로그 O 데이터
						request_msgsendrcv.setTranStatus("3");
						request_msgsendrcv.setTranRslt("X");
						
						rcvLogList.add(request_msgsendrcv);
					} 
				}
			}
			
		} else if (type.toUpperCase().equals("CODE")) {			// 영업점 직원 발송
			request_msgsendinfo.setEmplClass("ALL");
			request_msgsendinfo.setEmplPositionName("ALL");
			
			String[] receivers = messageDto.getReceivers().split("[|]");
			
			//수신번호 파싱
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

				if(ht.get(request_msgsendrcv.getRcvPhone()) == null){//전화번호 중복체크
					ht.put(request_msgsendrcv.getRcvPhone(), request_msgsendrcv);
					
					String rslt = sendValidation(request_msgsendrcv);
					
					if (rslt.equals("0")) {//정상 발송 데이터
						String sendType = messageDto.getSendType().toUpperCase();
						request_msgsendrcv.setTranStatus(sendType.equals("SMS") ? "1":"0");
						request_msgsendrcv.setTranRslt(null);
							
						rcvSendList.add(request_msgsendrcv);
					} else if (rslt.equals("X")) { // 발송 X 로그 O 데이터
						request_msgsendrcv.setTranStatus("3");
						request_msgsendrcv.setTranRslt("X");
						
						rcvLogList.add(request_msgsendrcv);
					} 
				}
				
			} // end for
		
		// bo_code 파라미터로 받아와 string 자른다음에 값을 입력함.
		} else if (type.toUpperCase().equals("AREA")){			// 지역소속직원 발송
			
			request_msgsendinfo.setEmplClass(messageDto.getEmplClass());
			request_msgsendinfo.setEmplPositionName(messageDto.getEmplPositionName());

			PartInfo request_partinfo = new PartInfo();
			request_partinfo.setClassCode(request_msgsendinfo.getEmplClass());
			request_partinfo.setPositionCallname(request_msgsendinfo.getEmplPositionName());
			
			String[] receivers = messageDto.getReceivers().split("[|]");
			
			for (String receiver : receivers) {
				String split[] = receiver.split("[:]");
				String boCode = (request_partinfo.getBoCode()==null?"":request_partinfo.getBoCode()) + ", '" + split[0]+"'";
				request_partinfo.setBoCode(boCode);
			}
			request_partinfo.setBoCode(request_partinfo.getBoCode().substring(1));
			
			//지역소속직원 정보 리스트 조회
			List<MsgSendInfo> rcvTargetList = dao.getTargetAreaList(request_partinfo);
			
			for(MsgSendInfo request_msgsendrcv : rcvTargetList){
				request_msgsendrcv.setMsgSendInfo(request_msgsendinfo);
				
				logger.debug(request_msgsendrcv.getRcvPhone() + " = " +  request_msgsendrcv.getRcvName());

				if(ht.get(request_msgsendrcv.getRcvPhone()) == null){//전화번호 중복체크
					ht.put(request_msgsendrcv.getRcvPhone(), request_msgsendrcv);
					
					String rslt = sendValidation(request_msgsendrcv);
					
					if (rslt.equals("0")) {//정상 발송 데이터
						String sendType = messageDto.getSendType().toUpperCase();
						request_msgsendrcv.setTranStatus(sendType.equals("SMS") ? "1":"0");
						request_msgsendrcv.setTranRslt(null);
							
						rcvSendList.add(request_msgsendrcv);
					} else if (rslt.equals("X")) { // 발송 X 로그 O 데이터
						request_msgsendrcv.setTranStatus("3");
						request_msgsendrcv.setTranRslt("X");
						
						rcvLogList.add(request_msgsendrcv);
					} 
				}
			}
		}
		

		if(logger.isDebugEnabled()) {
			logger.debug("실건수:" +(rcvSendList.size()+rcvLogList.size()) + ", 중복제거 후 건수:" + ht.size());
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
		MsgSend msgSend = new MsgSend();
		
		// tranId 업무코드 생성 ( UNITCODE + 부서코드 + '_' + 회원ID )
		String tranId = "ET004";
		msgSend.setTranId(tranId);
		msgSend.setSendType(messageDto.getSendType().toUpperCase());
		
		msgSend.setMsgSendList(rcvSendList);
		msgSend.setMsgLogList(rcvLogList);
		msgSend.setCheckUnsubscribe(false);
		
		// Send
		messageService.sendMsgList(msgSend);
		
		return success;
	}


	
	/**
	 * 경조사보내기 발송 관련 체크
	 * 
	 * @param request_msgsendrcv
	 * @return
	 */
	private String sendValidation(MsgSendInfo request_msgsendrcv) {
		
		String tranId = "ET004";
		
		//'YYYYMMDDHH24MISS'
		String tranDate = request_msgsendrcv.getTranDate();
		if(tranDate == null || tranDate.equals("") || tranDate.toUpperCase().equals("SYSDATE")){
			SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyyMMddHHmmss", Locale.KOREA );
			Date currentTime = new Date ();
			tranDate = mSimpleDateFormat.format ( currentTime );
			
			request_msgsendrcv.setTranDate(tranDate);
		}
		
		//전화번호 벨리데이션
		String phone = request_msgsendrcv.getRcvPhone();
		if (phone == null){
			logger.error("sendValidation !!! phone Is Null !!!");
			return "2";
		}
		
		phone = phone.replaceAll("[^0-9]", "");
		request_msgsendrcv.setRcvPhone(phone);
		
		String gcode = tranId.substring(0, 2);
		String scode = tranId.substring(3, 5);
		
		//	OPT-IN 체크 추가 (2005-03-21)
		int optin = messageService.optInCheck(request_msgsendrcv);
		if(optin == 1){
			logger.error("sendValidation !!! OPT-IN !!!");
			return "X";
		}
		
		request_msgsendrcv.setUnitCode(gcode);
		
		// 수신거부 체크
//		int resultMsgCheck = messageService.messageCheck(request_msgsendrcv);
//		
//		if(resultMsgCheck == 1 && !gcode.equals("HT") && !scode.equals("038")){
//			logger.error("sendValidation !!! messageCheck !!!");
//			return "X";
//		}
		
		return "0";
				
	}
}
