package com.ibk.msg.web.smssendlist;

import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;

import com.google.common.base.Preconditions;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.ibk.msg.common.dto.PaginationResponse;
import com.ibk.msg.web.confirmlist.ConfirmListDao;
import com.ibk.msg.web.confirmlist.ConfirmListSearchCondition;
import com.ibk.msg.web.manage.Code;
import com.ibk.msg.web.manage.ManageDao;
import com.ibk.msg.web.message.MessageService;
import com.ibk.msg.web.smsreq.SmsReqData;
import com.ibk.msg.web.smsreq.SmsReqService;
import com.ibk.msg.web.smsreq.T30Data;
import com.ibk.msg.web.smsreq.T32Data;

@Component
@PropertySources({
	@PropertySource("classpath:local.properties")
	, @PropertySource(value="classpath:${spring.profiles.active}.properties", ignoreResourceNotFound=true)
})
public class SmsSendListService {

	private static final Logger logger = LoggerFactory.getLogger(MessageService.class);

	@Autowired
	private SmsReqService smsReqService;

	@Autowired
	private SmsSendListDao dao;

	@Autowired
	private ConfirmListDao confirmListDao;

	@Autowired
	private ManageDao manageDao;

	public PaginationResponse findByPagination(SmsSendListSearchCondition searchCondition)
			throws Exception {
		Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
		Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");

		String tranId = "CC" + searchCondition.getBoCode() + "_" + searchCondition.getEmplId(); 

		searchCondition.setBoCode(tranId);

		int totalCount = dao.findTotalCount(searchCondition);
		List<SmsSendList> users = dao.findSmsSendList(searchCondition);

		return new PaginationResponse(searchCondition, totalCount, users);
	}
	
	public ModelAndView findDetail(int smssendlistId){
		ModelAndView mav = new ModelAndView();

		SmsSendList smssendlist = dao.findDetail(smssendlistId);

		if(smssendlist.getPrcssStusDstic().equals("C") || smssendlist.getPrcssStusDstic().equals("N")){
			mav.setViewName("smssendlist/smssendlist-detail");
		}else if(smssendlist.getPrcssStusDstic().equals("A") || smssendlist.getPrcssStusDstic().equals("B")){
			mav.setViewName("smssendlist/smssendlist-detail-three");
		}else {
			mav.setViewName("smssendlist/smssendlist-detail-view");
		}

		String sndrTelno = smssendlist.getSndrTelno();

		if(sndrTelno != null){
			if (sndrTelno.length() == 8) {
				sndrTelno = sndrTelno.replaceFirst("^([0-9]{4})([0-9]{4})$", "$1-$2");
				smssendlist.setSndrTelno(sndrTelno);
			} else if (sndrTelno.length() == 12) {
				sndrTelno = sndrTelno.replaceFirst("(^[0-9]{4})([0-9]{4})([0-9]{4})$", "$1-$2-$3");
				smssendlist.setSndrTelno(sndrTelno);
			}
			sndrTelno = sndrTelno.replaceFirst("(^02|[0-9]{3})([0-9]{3,4})([0-9]{4})$", "$1-$2-$3");
			smssendlist.setSndrTelno(sndrTelno);
		}else {
			sndrTelno = null;
		}

		mav.addObject("smssendlist", smssendlist);



		//###### 치환변수 key, maxSize 정보
		int cntReplaceVal = -1;
		List<String> replaceNmList = new LinkedList<String>();			//치환변수명
		List<String> replaceNmMaxList = new LinkedList<String>();		//치환변수 최대 Size

		String replaceVariableVal = smssendlist.getReplaceVariableVal();
		if(replaceVariableVal != null){
			mav.addObject("replaceVariableVal", replaceVariableVal);
			JsonParser jsonParser = new JsonParser();
			JsonObject jsonReplaceVariableVal = (JsonObject) jsonParser.parse(replaceVariableVal);

			Iterator<String> keys = jsonReplaceVariableVal.keySet().iterator();


			while (keys.hasNext()) {
				String key = keys.next();

				replaceNmList.add(key);
				replaceNmMaxList.add((jsonReplaceVariableVal.get(key)+"").replace("\"", ""));

				cntReplaceVal++;
			}
		}

		mav.addObject("cntReplaceVal", cntReplaceVal);
		mav.addObject("replaceNmList", replaceNmList);
		mav.addObject("replaceNmMaxList", replaceNmMaxList);
		//END__###### 치환변수 key, maxSize 정보

		//###### 대상자 정보 셋팅
		HashMap<String, String> pram = new HashMap<String, String>();
		pram.put("groupUniqNo", smssendlistId + "");

		int cntTargetList = confirmListDao.countT28TargetList(pram);
		List<String> targetList = confirmListDao.selectT28TargetList(pram);

		String[] defaultHeader = {"고객번호", "고객명", "휴대폰번호"};
		//대상자 테이블 헤더 정보
		List<String> tableAllHeader = new LinkedList<String>();
		tableAllHeader.addAll(Arrays.asList(defaultHeader));
		List<String> tableAddHeader = new LinkedList<String>();

		String targetReplaceVal="";
		//대상자 정보
		List<HashMap<String, String>> targetDataList = new LinkedList<>();
		for(int i=0; i < targetList.size(); i++){
			String targetData = targetList.get(i);

			JsonParser jsonParser = new JsonParser();
			JsonObject jsonTargetDataVal = (JsonObject) jsonParser.parse(targetData);
			if(i==0)targetReplaceVal=jsonTargetDataVal.toString();
			Iterator<String> keys = jsonTargetDataVal.keySet().iterator();

			HashMap<String, String> target = new HashMap<String, String>();
			while (keys.hasNext()) {
				String key = keys.next();

				// 대상자 테이블 헤더 추가 (치환변수 존재 시)
				if(i==0 && jsonTargetDataVal.keySet().size() > 3){
					//					if(!key.startsWith("치환변수값")){ //치환변수 값 제거 ( 실제 치환변수 X : (치환변수값1, 치환변수값2, ...)
					if(!tableAllHeader.contains(key)){
						tableAllHeader.add(key);
						tableAddHeader.add(key);
					}
					//					}
				}

				target.put(key, (jsonTargetDataVal.get(key)+"").replace("\"", ""));

			}
			targetDataList.add(target);
		}

		mav.addObject("targetReplaceVal", targetReplaceVal);
		mav.addObject("cntTarget", cntTargetList);
		mav.addObject("tableHeader", tableAllHeader);
		mav.addObject("tableAddHeader", tableAddHeader);
		mav.addObject("targetDataList", targetDataList);
		//END__###### 대상자 정보 셋팅

		//START__###### 발송 단가 정보 조회
		List<Code> sendPriceLsit = manageDao.selectSendPrice();
		for(Code sendPrice : sendPriceLsit){
			mav.addObject(sendPrice.getDsplyNm(), sendPrice.getCdValue());
		}
		//END__###### 발송 단가 정보 조회


		return mav; 
	}

	/**
	 * 취소
	 * @param groupUniqNo
	 * @return
	 */
	@Transactional(transactionManager = "ibkSmsTxManager")
	public int remove(int groupUniqNo){
		int result = 0;
		dao.remove(groupUniqNo);
		dao.removeT21_INFO(groupUniqNo);
		dao.removeT30(groupUniqNo);
		dao.removeT32(groupUniqNo);
		return result;
	}

	@Transactional(transactionManager = "ibkSmsTxManager")
	public int cancel(int groupUniqNo){ 
		int result = dao.cancel(groupUniqNo);
		return result;
	}
	
	/**
	 * 
	 * 임시저장, 결재올리기
	 * @param smssendlist, httpSession
	 * @throws FileNotFoundException 
	 * 
	 */
	@Transactional(transactionManager = "ibkSmsTxManager")
	public Object tmpSave(SmsSendList smssendlist, HttpSession httpSession) throws FileNotFoundException {

		//1.DB 형식에 맞게 값 변경
		String tranId = "CC" + smssendlist.getBoCode() + "_" + smssendlist.getEmplId(); 
		String sndrTelno = smssendlist.getSndrTelno();
		sndrTelno = sndrTelno.replace("-", "");

		smssendlist.setSndrTelno(sndrTelno); //발신번호 (-)제거 
		smssendlist.setBzwkIdnfr(tranId);	//기업은행 코드에 맞게 커스터마이징 후 넣기
		smssendlist.setMsgDstic(smssendlist.getMsgDstic().toUpperCase().substring(0, 2)); //메시지구분 대문자 2자만 넣기
		smssendlist.setScheduleDstic("W"); 	//채널과 웹 구분자(D: 채널, W: 웹)

		if(!smssendlist.getTempSave().equals("tempSave")){	//임시저장인지, 결재 올리기 인지 체크
			//	    	smssendlist.setPrcssStusDstic("A");
			smssendlist.setPrcssStusDstic("B"); //발송승인대기(B)
		}

		//1. T21 값 Update
		Object dao2 = dao.saveT21(smssendlist); 

		//2.T21_info update
		dao2 =dao.saveInfo(smssendlist);

		//################################################ 파일 처리 로직 추가 @jys 20181227
		//0. 신규 파일 존재 여부 확인 @@@@@@@@@@@@@@@@@@@@@@@@개발 필요
		boolean newFile = false;
		if(smssendlist.getTargetFilePath() != null && !smssendlist.getTargetFilePath().equals("")){ //대상자 파일
			newFile = true;
		}
		if(smssendlist.getImagePath1() != null && !smssendlist.getImagePath1().equals("")){	// 이미지파일1
			newFile = true;
		}
		if(smssendlist.getImagePath2() != null && !smssendlist.getImagePath2().equals("")){	// 이미지파일2
			newFile = true;
		}
		if(smssendlist.getImagePath3() != null && !smssendlist.getImagePath3().equals("")){	// 이미지파일3
			newFile = true;
		}
		logger.info("######신규 파일 : " + newFile + " / 헤더변경 여부 : " + smssendlist.getChangeHeadDataYn());

		//데이터 매핑
		SmsReqData smsReqData = new SmsReqData().SmsSendListToSmsReqData(smssendlist);

		//0-1. 신규 파일 존재 시 파일 이전
		if(newFile){
			smsReqService.targetFileHandler(smsReqData);
		}

		//0-3. 신규 파일 존재하지 않고 T21 기안 내용 수정시 T28 헤더 정보 수정 (T28 헤더에 해당 되는 내용 변경 시)
		if(!newFile && smssendlist.getChangeHeadDataYn().equals("Y")){
			smsReqService.updateT28InputOrigin(smsReqData);
		}
		//################################################ 파일 처리 로직 추가 @jys 20181227


		//3.T30 발송희망일 시간 별 건수 추가
		List<T30Data> t30List = smssendlist.getSendDateInfo();
		logger.debug(":::T30DataList SIZE =" + t30List.size());
		if(t30List.size() > 0){
			for(T30Data data : t30List){
				data.setGroupUniqNo(smssendlist.getGroupUniqNo());
				data.setBzwkIdnfr(smssendlist.getBzwkIdnfr());
				data.setGroupCoCd("IBK");
				data.setScheduleTagtDstic("W");
				data.setSendStusDstic("Y");
				data.setScheduleDstic("W");
				data.setAlarmPeriodNumber("1000");
				data.setIntervalTime("60");
			}
			int selectT30 = dao.selectT30(smssendlist);

			if(selectT30 > 0){
				dao.removeT30(smssendlist);
			}
			dao2 = dao.saveT30(smssendlist);
		}

		//4. T32 결재선 승인자 추가
		List<T32Data> t32List = smssendlist.getConfirmEmp();
		logger.debug(":::T32DataList SIZE =" + t32List.size());
		if(t32List.size() > 0){
			for(T32Data data : t32List){
				data.setGroupUniqNo(smssendlist.getGroupUniqNo());
				data.setDrafterNm(smssendlist.getEmplId());
				data.setAgreeStatus("I"); // 승인상태(진행중 (I), 완료(G))
				smssendlist.setAgreeType(data.getAgreeType());
			}

			dao.removeT32(smssendlist);

			//발송승인직원에 본인 추가
			dao2 = dao.inT32(smssendlist);
			//발송승인직원 목록에 있는 직원 전부 추가
			dao2 = dao.saveT32(smssendlist);
		}
		return  dao2; 
	}


	@Transactional(transactionManager = "ibkSmsTxManager")
	public Object save(SmsSendList smssendlist, HttpSession httpSession) throws FileNotFoundException {

		String tranId = "CC" + smssendlist.getBoCode() + "_" + smssendlist.getEmplId(); 

		Object dao2 = null;
		smssendlist.setBzwkIdnfr(tranId);
		smssendlist.setGroupCoCd("IBK");

		//1.T21 update(대상자 파일명, 문자타입)
		smssendlist.setMsgDstic(smssendlist.getMsgDstic().toUpperCase().substring(0, 2)); //메시지구분 대문자 2자만 넣기
		dao.saveInst(smssendlist);

		//2.T21_infor update
		dao2 =dao.saveInfo(smssendlist);

		//################################################ 파일 처리 로직 추가 @jys 20181227
		//0. 신규 파일 존재 여부 확인 @@@@@@@@@@@@@@@@@@@@@@@@개발 필요
		boolean newFile = false;
		if(smssendlist.getTargetFilePath() != null && !smssendlist.getTargetFilePath().equals("")){ //대상자 파일
			newFile = true;
		}
		if(smssendlist.getImagePath1() != null && !smssendlist.getImagePath1().equals("")){	// 이미지파일1
			newFile = true;
		}
		if(smssendlist.getImagePath2() != null && !smssendlist.getImagePath2().equals("")){	// 이미지파일2
			newFile = true;
		}
		if(smssendlist.getImagePath3() != null && !smssendlist.getImagePath3().equals("")){	// 이미지파일3
			newFile = true;
		}
		logger.info("######신규 파일 : " + newFile + " / 헤더변경 여부 : " + smssendlist.getChangeHeadDataYn());

		//데이터 매핑
		SmsReqData smsReqData = new SmsReqData().SmsSendListToSmsReqData(smssendlist);

		//0-1. 신규 파일 존재 시 파일 이전
		if(newFile){
			smsReqService.targetFileHandler(smsReqData);
		}

		//0-3. 신규 파일 존재하지 않고 T21 기안 내용 수정시 T28 헤더 정보 수정 (T28 헤더에 해당 되는 내용 변경 시)
		if(!newFile && smssendlist.getChangeHeadDataYn().equals("Y")){
			smsReqService.updateT28InputOrigin(smsReqData);
		}
		//################################################ 파일 처리 로직 추가 @jys 20181227


		//3.T30 발송희망일 시간 별 건수 추가
		List<T30Data> t30List = smssendlist.getSendDateInfo();
		logger.debug(":::T30DataList SIZE =" + t30List.size());
		if(t30List.size() > 0){
			for(T30Data data : t30List){
				data.setGroupUniqNo(smssendlist.getGroupUniqNo());
				data.setBzwkIdnfr(smssendlist.getBzwkIdnfr());
				data.setGroupCoCd("IBK");
				data.setScheduleTagtDstic("W");
				data.setSendStusDstic("Y");
				data.setScheduleDstic("W");
				data.setAlarmPeriodNumber("1000");
				data.setIntervalTime("60");
			}
			int selectT30 = dao.selectT30(smssendlist);

			if(selectT30 > 0){
				dao.removeT30(smssendlist);
			}
			dao2 = dao.saveT30(smssendlist);
		}

		//3. T32 발송 승인 직원 등록
		List<T32Data> t32List = smssendlist.getSendConfirmEmp();
		if(t32List.size() > 0){
			for(T32Data data : t32List){
				data.setGroupUniqNo(smssendlist.getGroupUniqNo());
				data.setDrafterNm(smssendlist.getEmplId());
				data.setAgreeStatus("I"); // 승인상태(진행중 (I), 완료(G))
				smssendlist.setAgreeType(data.getAgreeType());

				int selectT32 = dao.selectT32(data);

				if(selectT32 > 0){
					dao2= dao.deleteT32(smssendlist);
				}
			}
			dao2 = dao.insertT32(smssendlist);

		}
		return  dao2; 
	}


	public Object agreeSelect(int groupUniqNo, HttpSession httpSession) {
		String result = "성공";

		int selectTot = dao.agreeSelect(groupUniqNo);
		if(selectTot != 0){
			result = "실패";
		}

		return result;
	}

	/***
	 * 
	 * 발송승인요청
	 * @param smssendlist
	 * @param httpSession
	 * @return
	 */
	@Transactional(transactionManager = "ibkSmsTxManager")
	public Object testSend(SmsSendList smssendlist, HttpSession httpSession){

		dao.updateT21EmplID(smssendlist);
		
		String tranId = "CC" + smssendlist.getBoCode() + "_" + smssendlist.getEmplId(); 
		//   	    smssendlist.setGroupCoCd("IBK");

		smssendlist.setBzwkIdnfr(tranId);

		if(smssendlist.getMsgDstic().equals("lms")){
			smssendlist.setMsgDstic("LM");
		}else if(smssendlist.getMsgDstic().equals("sms")){
			smssendlist.setMsgDstic("SM");
		}else if(smssendlist.getMsgDstic().equals("mms")){
			smssendlist.setMsgDstic("MM");
		}

		String sndrTelno = smssendlist.getSndrTelno();
		sndrTelno = sndrTelno.replace("-", "");
		smssendlist.setSndrTelno(sndrTelno);
		//치환 변수 존재 시 메시지 내용 치환하여 테스트 문자 발송
		if(!smssendlist.getReplaceVariableVal().equals("")) {
			String newMsgCtnt=null;
			if(smssendlist.getMsgDstic().equals("SM")) {
				newMsgCtnt=var2message(smssendlist.getMsgCtnt(), jsonToMap(smssendlist.getTargetReplaceVal())).toString();
				smssendlist.setMsgCtnt(newMsgCtnt);
			}else {
				newMsgCtnt=var2message(smssendlist.getUmsMsgCtnt(), jsonToMap(smssendlist.getTargetReplaceVal())).toString();
				smssendlist.setUmsMsgCtnt(newMsgCtnt);
			}
		}
		List<T32Data> sendConfirmEmps = smssendlist.getSendConfirmEmp();
		Object dao2 = null;
		logger.info("sendConfirmEmps {}" ,sendConfirmEmps);
		//1. 발송테이블 insert(실제 문자 발송 내역 )
		for(T32Data sendConfirmEmp : sendConfirmEmps){
			//발송승인자 전화번호 세팅
			smssendlist.setRecvNoAddress(sendConfirmEmp.getEmplHpNo());
			//1. 발송테이블 insert(실제 문자 발송 내역 )
			dao2 = dao.testSend(smssendlist);
		}

		//2. 발송테이블 insert2(기안 정보 문자 발송 및 url 전송)
		for(T32Data sendConfirmEmp : sendConfirmEmps){
			String addUrlEmplId = sendConfirmEmp.getEmplId();
			//문자 메시지 내용을 기안내용으로 변경
			smssendlist.setMsgCtnt(smssendlist.getGroupNm());
			smssendlist.setUmsMsgCtnt(smssendlist.getConfirmMessage()+addUrlEmplId);
			smssendlist.setRecvNoAddress(sendConfirmEmp.getEmplHpNo());
			logger.info("smssendlist {}" ,smssendlist);
			logger.info("sendConfirmEmp {}" ,sendConfirmEmp);
			//모든 기안내용은 LMS 이기때문에 LM으로 변경
			smssendlist.setMsgDstic("LM");
			//2. 발송테이블 insert2(기안 정보 문자 발송 및 url 전송)
			dao.testSend(smssendlist);
		}

		//3. T21테이블 상태값 변경
		smssendlist.setPrcssStusDstic("I");
		dao.updateStatus(smssendlist);

		return dao2;
	}

	public Object confirmSelect(int groupUniqNo, HttpSession httpSession){ 
		return dao.confirmSelect(groupUniqNo);
	}

	public Object sendConfirmSelect(int groupUniqNo, HttpSession httpSession){ 
		return dao.sendConfirmSelect(groupUniqNo);
	}

	public Object digitalConfirmSelect(int groupUniqNo, HttpSession httpSession){
		List<SmsSendList> result = dao.digitalConfirmSelect(groupUniqNo);

		if(result.isEmpty()){
			result = dao.userInfoLevel2(groupUniqNo);
		}

		return result;
	}

	public Object cmsConfirmSelect(int groupUniqNo, HttpSession httpSession){
		List<SmsSendList> result =dao.cmsConfirmSelect(groupUniqNo);

		if(result.isEmpty()){
			result = dao.userInfoLevel3(groupUniqNo);
		}

		return result;
	}

	/***
	 * 
	 * 
	 * 승인 URL 발송승인 
	 * @param groupUniqNo
	 * @param emplId
	 * @return
	 */
	@Transactional(transactionManager = "ibkSmsTxManager")
	public String confirmUpdate(int groupUniqNo, String emplId) {
		logger.debug(":::발송승인 승인자 접근::: GROUPUNIQNO : " + groupUniqNo + "," + "승인자 EMPLID : " + emplId );

		//1. 기안 상태 확인 ( I(발송승인중) 상태값만 승인 가능)
		String confirmT21Satus = dao.confirmT21Satus(groupUniqNo);
		logger.info(":::["+groupUniqNo+"] 기안 상태 :"+confirmT21Satus);
		if(confirmT21Satus == null || confirmT21Satus.equals("") || !confirmT21Satus.equals("I")){
			return "[정보] 승인처리가 불가능한 기안 입니다.";
		}

		//2. 결재자 승인 처리
		String confirmStatus = dao.confirmSelectSatus(groupUniqNo, emplId);
		logger.info(":::["+groupUniqNo+"/"+emplId+"] 승인자 상태 :"+confirmStatus);
		//승인자 정보가 존재하지 않을 경우
		if(confirmStatus == null || confirmStatus.equals("")){
			//@@@@문자메시지 전송 및 UC알람 연동 코드 삽입
			return "[정보] 해당 기안의 승인자가 아닙니다.";
		}
		//승인자가 이미 승인한 경우
		if(confirmStatus.equals("G")){
			//@@@@문자메시지 전송 및 UC알람 연동 코드 삽입
			return "[정보] 이미 승인처리를 완료 하셨습니다.";
		}

		//승인 처리
		int resultUpdate = dao.confirmUpdate(groupUniqNo, emplId);
		if(resultUpdate > 0){

			// 4차 전체 동의 여부 확인 (0 일 경우 전체 동의)
			int cntUnCheked = dao.selectFourthDisagree(groupUniqNo);
			if(cntUnCheked == 0){
				ConfirmListSearchCondition csc = new ConfirmListSearchCondition();
				csc.setGroupUniqNo(groupUniqNo+"");

				//T26 완료 상태값
				String t26Stus = "D"; 
				//T26 상태 조회 (0일 경우 대상자 파일 처리중)ㄴ
				int doneCheck = dao.selectT26DoneCheck(groupUniqNo, t26Stus);

				if(doneCheck > 0){
					// T26 상태값이 'D'일 경우 T21 상태값 'Y'로 업데이트
					csc.setPrcssStusDstic("Y");
				}else{
					// T26 상태값이 'D'가 아닌 경우 T21 상태값 'R'로 업데이트
					csc.setPrcssStusDstic("R");
				}

				// 전체동의시 T21 상태값 수정
				confirmListDao.updateT21Agree(csc);
			}

			//@@@@문자메시지 전송 및 UC알람 연동 코드 삽입
			return "[성공] 승인이 완료 되었습니다.";
		}

		//@@@@문자메시지 전송 및 UC알람 연동 코드 삽입
		return "[실패] 승인을 실패하였습니다. ";		
	}



	/**
	 * 
	 * 발송 중지
	 * 
	 * @param groupUniqNo
	 * @return
	 */
	public Object stopSend(int groupUniqNo) {
		SmsSendList smssendlist = new SmsSendList();
		smssendlist.setGroupUniqNo(Integer.toString(groupUniqNo));
		smssendlist.setPrcssStusDstic("T");

		return dao.updateStatus(smssendlist);
	}


	/**
	 * 
	 * 발송 재개
	 * 
	 * @param groupUniqNo
	 * @return
	 */
	public Object restartSend(int groupUniqNo) {
		SmsSendList smssendlist = new SmsSendList();
		smssendlist.setGroupUniqNo(Integer.toString(groupUniqNo));
		smssendlist.setPrcssStusDstic("Y");

		return dao.updateStatus(smssendlist);
	}
	/**
	 * 
	 * 치환 메시지 조립
	 * 
	 * @param msgContent, replaceValue
	 * @return replaceMsgContent
	 */
	public  StringBuffer var2message(String template , HashMap hash) 
	{
		StringBuffer retBuf = new StringBuffer(template);
		if ( retBuf == null ) return null;
		
		// 2022.05.10 Null 체크 추가
		if ( hash != null ) {
			Set cols = hash.keySet() ;
			Iterator itr = cols.iterator() ;
			// 템플릿에 변수가 남아 있는 조건을 추가하여, 불필요한 템플릿 검사 횟수를 줄임.
			while( itr.hasNext()  && retBuf.indexOf("${")!=-1   )
			{
				
				String Key = itr.next().toString();
				//			템플릿 내 $문자와의 혼동을 방지하기 위해 새로운 변수 패턴  ${변수명}을 사용한다.
				String newKey = "${" + Key + "}";				
				String Value = hash.get(Key).toString();
				//Convert VarField to VarValue
				int sbIdx = 0;
				int sbCnt = 0;
				int pos= 0; //변수값에 ${} 변수 포멧을 쓰는 경우. 무한루프가 되는 버그 패치( 2017.02.28 kbcard )
				for (int i = 0 ; (sbIdx = retBuf.indexOf(newKey,pos))!= -1 && i < 4096 ; i++)
				{
					//retBuf.replace(sbIdx, sbIdx + NAME_VAL_SIZE(6), Value);
					retBuf.replace(sbIdx, sbIdx + newKey.length(), Value);
					pos = sbIdx + Value.length();
					sbCnt++;
				}
				//if (sbCnt==0) return null;
			}
		}

		//if (retBuf.indexOf("$VAL")!=-1) return null;
		if (retBuf.indexOf("${")!=-1) return null;


		return retBuf;
	}

	public int fileDoneCheck(int groupUniqNo){
		//결과 = 1(성공), 0(대상자업로드X), -1(처리중)

		int doneCheck = dao.selectT26DoneCheck(groupUniqNo, null);

		if(doneCheck > 0){// 대상자 파일 존재할 경우
			String t26Stus = "D"; 
			doneCheck = dao.selectT26DoneCheck(groupUniqNo, t26Stus);

			if(doneCheck > 0){
				return 1;	// 완료
			}else{
				return -1;	// 처리중
			}
		}else{
			return 0; // 대상자파일 업로드 X
		}
	}

	public HashMap<String, String> jsonToMap(String json){
		HashMap<String,String> map = new HashMap<String,String>(15);
		return (HashMap<String,String>) new Gson().fromJson(json, map.getClass());
	}
}
