package com.ibk.msg.web.sendStatus;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.base.Preconditions;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.ibk.msg.common.dto.PaginationResponse;
import com.ibk.msg.web.confirmlist.ConfirmListDao;
import com.ibk.msg.web.manage.Code;
import com.ibk.msg.web.manage.ManageDao;
import com.ibk.msg.web.smsreq.SmsReqDao;
import com.ibk.msg.web.smssendlist.SendHistory;
import com.ibk.msg.web.smssendlist.SendHistorySearchCondition;
import com.ibk.msg.web.smssendlist.SmsSendList;
import com.ibk.msg.web.smssendlist.SmsSendListDao;

@Component
@PropertySources({
	@PropertySource("classpath:local.properties")
	, @PropertySource(value="classpath:${spring.profiles.active}.properties", ignoreResourceNotFound=true)
})
public class SendStatusService {

	@Autowired
	private SmsReqDao smsReqDao;
	
	@Autowired
	private SendStatusDao sendStatusDao;
	
	@Autowired
	private ConfirmListDao confirmListDao;
	
	@Autowired
	private SmsSendListDao smsSendListDao;
	
	@Autowired
	private ManageDao manageDao;
	
	
	/**
	 * 발송현황 상세 > 기본정보 조회
	 * @param smssendlistId
	 * @return
	 */
	public Map<String, Object> findDetailAjax(int smssendlistId){
		Map<String, Object> sendStatusDetailMap = new HashMap<String, Object>();
		SmsSendList smssendlist = smsSendListDao.findDetail(smssendlistId);
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

		sendStatusDetailMap.put("smssendlist", smssendlist);
		
		//###### 치환변수 key, maxSize 정보
		int cntReplaceVal = -1;
		List<String> replaceNmList = new LinkedList<String>();			//치환변수명
		List<String> replaceNmMaxList = new LinkedList<String>();		//치환변수 최대 Size

		String replaceVariableVal = smssendlist.getReplaceVariableVal();
		if(replaceVariableVal != null){
			sendStatusDetailMap.put("replaceVariableVal", replaceVariableVal);
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

		sendStatusDetailMap.put("cntReplaceVal", cntReplaceVal);
		sendStatusDetailMap.put("replaceNmList", replaceNmList);
		sendStatusDetailMap.put("replaceNmMaxList", replaceNmMaxList);
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

		sendStatusDetailMap.put("targetReplaceVal", targetReplaceVal); 
		sendStatusDetailMap.put("cntTarget", cntTargetList);           
		sendStatusDetailMap.put("tableHeader", tableAllHeader);        
		sendStatusDetailMap.put("tableAddHeader", tableAddHeader);     
		sendStatusDetailMap.put("targetDataList", targetDataList);     
		//END__###### 대상자 정보 셋팅

		//START__###### 발송 단가 정보 조회
		List<Code> sendPriceLsit = manageDao.selectSendPrice();
		for(Code sendPrice : sendPriceLsit){
			sendStatusDetailMap.put(sendPrice.getDsplyNm(), sendPrice.getCdValue());
		}
		//END__###### 발송 단가 정보 조회

		return sendStatusDetailMap; 
	}
	
	/**
	 * 발송현황 상세 > 발송 내역 조회
	 * @param searchCondition
	 * @return
	 * @throws Exception
	 */
	public PaginationResponse sendHistoryByPagination(SendHistorySearchCondition searchCondition)
			throws Exception { 
		Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
		Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");

		List<SendHistory> sendHistoryList = new ArrayList<>();
		
		SmsSendList smssendlist = smsSendListDao.findDetail(searchCondition.getGroupUniqNo());
		int totalCount = 0;
		
		if(smssendlist.getSendExpireYms() != null) {
			if("SM".equals(smssendlist.getMsgDstic())) {
				searchCondition.setHistoryTableNm("DACOM_DIST.DIST_LOG_"+ smssendlist.getSendExpireYms().substring(0,6));
				totalCount = sendStatusDao.smsSendHistoryTotalCount(searchCondition);
				sendHistoryList = sendStatusDao.selectSmsSendHistoryList(searchCondition);
			} else {
				searchCondition.setHistoryTableNm("DACOM_DIST.DIST_MMS_LOG_"+ smssendlist.getSendExpireYms().substring(0,6));
				totalCount = sendStatusDao.mmsSendHistoryTotalCount(searchCondition);
				sendHistoryList = sendStatusDao.selectMmsSendHistoryList(searchCondition);
			}
		}
		
		return new PaginationResponse(searchCondition, totalCount, sendHistoryList);
	}
	
	/**
	 * 발송현황 > 기본정보 > 예약일시, 시작일시 조회
	 * @param requestData
	 * @return
	 */
	public HashMap<String, Object> getDateSaveCnt2(Map<String, Object> requestData) {
		// 예약일시 조회
		List<String> pengagList = smsReqDao.getSaveDateList2(requestData);
		// 시작일시 조회
		ArrayList<Map<String, Object>> startDsticList = sendStatusDao.selectStartDsticList(requestData);
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("startDsticList", startDsticList);
		
		if(pengagList.size() > 0){
			List<String> timeList = new ArrayList<String>();
			for(String yms : pengagList){
				timeList.add(yms.substring(8,12));
			}
			
			//2. 조회된 일자별 시간별 건수 조회
			for(String date : pengagList){
				HashMap<String, Object> pram = new HashMap<String, Object>();
				pram.put("date", date.substring(0, 8));
				pram.put("timeList", timeList);
				pram.put("groupUniqNo", requestData.get("groupUniqNo"));
				pram.put("selectType", "save");
				
				HashMap <String, Object> selectMap = smsReqDao.getDateTotalCnt(pram);
				
				selectMap.put("timeList", timeList);
				selectMap.put("pengagYmd", date.substring(0, 8));
				resultMap.put("pengagData", selectMap);
			}
		}
		return resultMap;
	}

	/**
	 * 발송현황 > 삭제
	 * @param smssendlistId
	 * @return
	 */
	@Transactional(transactionManager = "ibkSmsTxManager")
	public Map<String, Object> deleteSendStatus(int smssendlistId) {
		Map<String, Object> sendStatusResultMap = new HashMap<String, Object>();
		Map<String, Object> paramMap = new HashMap<String, Object>();
		String result = "FAIL"; 
		paramMap.put("smssendlistId", smssendlistId);
		
		sendStatusDao.deleteSendStatusDRF002M(paramMap);	// t21
		sendStatusDao.deleteSendStatusDRF002D(paramMap);	// t22
		sendStatusDao.deleteSendStatusDRF004M(paramMap);	// t30
		sendStatusDao.deleteSendStatusDRF001M(paramMap);	// 그룹발송승인
		sendStatusDao.deleteSendStatusDRF003M(paramMap);	// t26
		sendStatusDao.deleteSendStatusDRF003D(paramMap);	// t28
		
		result = "SUCCESS";
		
		sendStatusResultMap.put("result", result);
		return sendStatusResultMap;
	}
	
	/**
	 * 발송현황 > 상태값변경
	 * @param requestData
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> updateSendStatus(Map<String, Object> requestData) throws Exception {
		Map<String, Object> sendStatusResultMap = new HashMap<String, Object>();
		String result = "FAIL"; 
		sendStatusDao.updateSendStatus(requestData);
		result = "SUCCESS";
		sendStatusResultMap.put("result", result);
		return sendStatusResultMap;
	}
}
