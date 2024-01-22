package com.ibk.msg.web.confirmlist;

import java.io.FileNotFoundException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;

import com.google.common.base.Preconditions;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.ibk.msg.common.dto.PaginationResponse;
import com.ibk.msg.web.manage.Code;
import com.ibk.msg.web.manage.ManageDao;
import com.ibk.msg.web.smsreq.SmsReqDao;
import com.ibk.msg.web.smsreq.SmsReqData;
import com.ibk.msg.web.smsreq.SmsReqService;
import com.ibk.msg.web.smsreq.T32Data;
import com.ibk.msg.web.user.UserInfo;

@Component
public class ConfirmListService {
	
  private static final Logger logger = LoggerFactory.getLogger(ConfirmListService.class);

  @Autowired
  private ConfirmListDao dao;
  
  @Autowired
  private SmsReqDao smsReqDao;
  
  @Autowired
  private SmsReqService smsReqService;
  
  @Autowired
  private ManageDao manageDao;

  public PaginationResponse findByPagination(ConfirmListSearchCondition searchCondition)
      throws Exception {
    Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
    Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");
    
    logger.debug("----------------------------------");
    logger.debug("----searchCondition.setSearchStartDt:-" + searchCondition.toString());
    logger.debug("----------------------------------");
    
	searchCondition.setSearchStartDt(searchCondition.getSearchStartDt());
	searchCondition.setSearchEndDt(searchCondition.getSearchEndDt());
	
    String boCode = searchCondition.getBoCode();
    String emplId = searchCondition.getEmplId();
    String tranId = "CC" + boCode + "_" + emplId; 
    
    searchCondition.setBoCode(tranId);

    logger.debug("=======================================================" );
    logger.debug("servie searchCondition : " + searchCondition.toString());
    logger.debug("=======================================================" );
    int totalCount = dao.findTotalCount(searchCondition);
    List<ConfirmList> users = dao.findConfirmList(searchCondition);
    
    
    return new PaginationResponse(searchCondition, totalCount, users);
  }
  
  
  
  /**
   * 상세 페이지 조회
 * @param agreeId 
   * 
 * @param confirmlistId
 * @return
 */
public ModelAndView findDetail(String groupUniqNo, String agreeType, String agreeStatus, String agreeId, HttpSession session){
	ModelAndView mav = new ModelAndView();
	
	//0. 접근 승인자 확인 (URL 수정으로 인한 권한 접근 방지)
	HashMap<String, String> pram = new HashMap<String, String>();
	pram.put("groupUniqNo", groupUniqNo);
	pram.put("agreeType", agreeType);
	pram.put("emplId", (String)session.getAttribute("EMPL_ID"));
	
	String userClass = (String)session.getAttribute("USER_CLASS");
	
	T32Data agreeTarget = dao.selectAgreeTarget(pram);
	if(userClass != "A" && (agreeTarget == null || !agreeType.equals(agreeTarget.getAgreeType()) ||  !agreeStatus.equals(agreeTarget.getAgreeStatus()))){
		mav.addObject("errorMsg", "잘못된 접근 방식입니다.<br><br>URL변작");
		mav.setViewName("confirmlist/confirmlist-list");
		return mav;
	}
	
	//1. 기안 정보 조회
	SmsReqData smsReqData = new SmsReqData();
	smsReqData.setGroupUniqNo(groupUniqNo);
	smsReqData = smsReqDao.selectT21(smsReqData);
	
	//2. 타입별 조회 및 수정 화면 이동 구분 
	/**
	 *  1. 승인자 등급 및 승인상태 별 구분
	 *  	----------------------------------------------------
	 *  				|	I(승인대기)	|	G(승인완료)	|	N(반려)		|
	 *  	----------------------------------------------------
	 *  	1차 승인자 |	조회(승인O)	|	조회(승인X)	|	조회(승인X)	|
	 *  	----------------------------------------------------
	 *  	2차 승인자 |	수정(승인O)	|	조회(승인X)	|	조회(승인X)	|
	 *  	----------------------------------------------------
	 *  	3차 승인자 |	수정(승인O)	|	조회(승인X)	|	조회(승인X)	|
	 *  	----------------------------------------------------
	 * 
	 * */
	String viewType = "view"; 	// view, update
	String eventType = "non";		// non, agree, all
	
	if(agreeStatus.equals("I")){	//승인대기 상태일 경우
	 // 1차 승인자일 경우
	 if(agreeType.equals("1")){	 
		 viewType = "view";
		 eventType = "agree";
	 }
	 // 2,3차 승인자일 경우
	 if(agreeType.equals("2") || agreeType.equals("3")){
		 viewType = "update";
		 eventType = "all";
	 }
	}
	
	// 기안이 반려처리되었을 경우 view만 가능하게 처리
	if(smsReqData.getPrcssStusDstic().equals("N")){
		viewType = "view";
		eventType = "non";
	}
	
	//3. 조회 데이터 매핑 후 리턴
	mav.addObject("smsReqData", smsReqData);	// 기안 정보
	mav.addObject("viewType", viewType);			// view 타입 (view(조회), update(수정)) - 디폴트 : view	
	mav.addObject("eventType", eventType);		// event 타입 (non(저장 및 승인기능 X), agree(승인기능 O), all(저장 및 승인기능 O) - 디폴트 : non
	
	mav.addObject("agreeType", agreeType);			// 승인 등급 (1, 2, 3, 4)
	mav.addObject("agreeStatus", agreeStatus);	// 승인 상태 (I(승인대기), G(승인완료), N(반려))

	mav.addObject("agreeId", agreeId);	// 승인자 ID
	
	
	//###### 치환변수 key, maxSize 정보
	int cntReplaceVal = -1;
	List<String> replaceNmList = new LinkedList<String>();			//치환변수명
	List<String> replaceNmMaxList = new LinkedList<String>();		//치환변수 최대 Size
	
	String replaceVariableVal = smsReqData.getReplaceVariableVal();
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
	int cntTargetList = dao.countT28TargetList(pram);
	List<String> targetList = dao.selectT28TargetList(pram);
	
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
//				if(!key.startsWith("치환변수값")){ //치환변수 값 제거 ( 실제 치환변수 X : (치환변수값1, 치환변수값2, ...)
					if(!tableAllHeader.contains(key)){
						tableAllHeader.add(key);
						tableAddHeader.add(key);
					}
//				}
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
	
	if(viewType.equals("view")){
	 mav.setViewName("confirmlist/confirmlist-detail-view");
	}else if(viewType.equals("update")){
	 mav.setViewName("confirmlist/confirmlist-detail-update");
	}
  
	return mav;
  }



public Object findAgreeList(String groupUniqNo) {
	SmsReqData smsReqData = new SmsReqData();
	smsReqData.setGroupUniqNo(groupUniqNo);
	
	String agreeExistenceYn = null; 
	//T32에 2차 3차 존재 여부확인 (2, 3 : 모두없음 , 2 : 3차만 존재, 3 : 2차만존재, null : 다존재)
	List<T32Data> t32CheckList =  smsReqDao.checkT32AgreeList(smsReqData);
	
	if(t32CheckList.size() == 0){
		agreeExistenceYn = "2, 3";
	}else if(t32CheckList.size() == 1){
		if(t32CheckList.get(0).getAgreeType().equals("2")){
			agreeExistenceYn = "3";
		}else if(t32CheckList.get(0).getAgreeType().equals("3")){
			agreeExistenceYn = "2";
		}
	}
	
	smsReqData.setAgreeExistenceYn(agreeExistenceYn);
	List<T32Data> t32List = smsReqDao.selectT32(smsReqData);
	return t32List;
}


/**
 * 기안 승인
 * 
 * 	2-1. 1차일 경우
 *	2-1-1.  기안 승인 완료 여부 확인 : 0(모두 승인 상태) 그외(승인 중 및 반려)
 *	2-1-2.  기안 승인 완료 시 2차 승인자 T32에 등록  : USER_INFO -> T32
 *
 *	2-2. 2차일 경우
 *	2-2-1.  기안 승인 완료 여부 확인 : 0(모두 승인 상태) 그외(승인 중 및 반려)
 *	2-2-2.  기안 승인 완료 시 3차 승인자 T32에 등록  : USER_INFO -> T32
 *
 *	2-3. 3차일 경우
 *	2-3-1.  기안 승인 완료 여부 확인 : 0(모두 승인 상태) 그외(승인 중 및 반려)
 *	2-3-2.  기안 승인 완료 시 T21 상태값 변경 : 결재진행중(A) -> 발송승인대기(B) 수정
 *
 *
 * @param condition
 * @throws Exception 
 */
@Transactional(transactionManager = "ibkSmsTxManager")
public void accept(ConfirmListSearchCondition condition){
	//1. 승인자 상태 승인 처리
	condition.setEmplId(condition.getAgreeId());  //승인자 ID 셋팅
	condition.setAgreeStatus("G");	 // 승인완료(G)
	int result = dao.updateT32Accept(condition);
	logger.debug("[DEBUG INFO] #############  기안 승인 처리 :"+result);
	if(result < 0){
		new Exception("ERROR : 기안 승인 처리 오류 발생");
	}
	
	
	if(condition.getAgreeType().equals("1")){ //2-1. 1차일 경우
		//2-1-1.  기안 승인 완료 여부 확인 : 0(모두 승인 상태) 그외(승인 중 및 반려)
		result = dao.checkAgreeAccept(condition);
		logger.debug("1차 [DEBUG INFO] #############  기안 승인 완료 여부 확인 :"+result);
		//2-1-2.  기안 승인 완료 시 2차 승인자 T32에 등록  : USER_INFO -> T32
		if(result == 0){
			condition.setAgreeType("2");
			String target = selectAgreeList(condition.getAgreeType());
			result = dao.insertT32AgreeTarget(condition.getGroupUniqNo(), condition.getAgreeType() ,target);
			logger.debug("1차 [DEBUG INFO] #############  기안 다음 차 승인자 T32에 등록 :"+result);
		}
	}else if(condition.getAgreeType().equals("2")){ //2-2. 2차일 경우
		//2-2-1.  기안 승인 완료 여부 확인 : 0(모두 승인 상태) 그외(승인 중 및 반려)
		result = dao.checkAgreeAccept(condition);
		logger.debug("2차 [DEBUG INFO] #############  기안 승인 완료 여부 확인 :"+result);
		//2-2-2.  기안 승인 완료 시 3차 승인자 T32에 등록  : USER_INFO -> T32
		if(result == 0){
			condition.setAgreeType("3");
			String target = selectAgreeList(condition.getAgreeType());
			result = dao.insertT32AgreeTarget(condition.getGroupUniqNo(), condition.getAgreeType(), target);
			logger.debug("2차 [DEBUG INFO] #############  기안 다음 차 승인자 T32에 등록 :"+result);
		}
	}else if(condition.getAgreeType().equals("3")){ //2-3. 3차일 경우
		//2-3-1.  기안 승인 완료 여부 확인 : 0(모두 승인 상태) 그외(승인 중 및 반려)
		result = dao.checkAgreeAccept(condition);
		logger.debug("3차 [DEBUG INFO] #############  기안 승인 완료 여부 확인 :"+result);
		//2-3-2.  기안 승인 완료 시 T21 상태값 변경 : 결재진행중(A) -> 발송승인대기(B) 수정
		if(result == 0){
			condition.setPrcssStusDstic("B");
			result = dao.updateT21Agree(condition);
			logger.debug("2차 [DEBUG INFO] #############  T21 상태값 변경 :"+result);
		}
	}
}


/**
 * 대직자 리스트 조회
 * 
 * @param groupUniqNo
 * @param agreeType
 * @return
 */
public String selectAgreeList(String agreeType){
	
	List<UserInfo> agreeTarget = dao.selectAgreeTargetList(agreeType);
	
	String resultEmplId = "";
	for(UserInfo t32 : agreeTarget){
		if(agreeTarget.indexOf(t32) != 0){
			resultEmplId = resultEmplId+ ",";
		}
		resultEmplId = resultEmplId + "'" + choiceApprover(t32.getEmplId(), 0) + "'";
	}
	
	logger.debug("[DEBUG] #############  selectAgreeList :"+resultEmplId);
	return resultEmplId;
}

/**
 * 대직자 조회 로직
 * 1. empl_id로 대직자 테이블 조회
 * 2. 조회 데이터 없을 경우 
 * 2-1. return;
 * 3. 조회 데이터 있을 경우
 * 3-1. 시작일자 와 종료일자 사이에 현재일자가 있을 경우
 * 3-1-1. 대직자 empl_id로 대직자 조회로직 재호출 (재귀함수) 최대 3번까지 호출
 * 3-1-2. return;
 * 3-2. 시작일자 와 종료일자 사이에 현재일자가 없을 경우
 * 3-2-1. return;
 * 
 * @param empl_id
 * @return
 */
public String choiceApprover(String empl_id, int count){
	int today = Integer.parseInt(new SimpleDateFormat("YYYYMMDD").format(new Date()));
	int checkCnt = ++count;
	String result = empl_id;
	logger.debug("[DEBUG] #############  checkCnt / empl_id :"+checkCnt + "/" + empl_id);
	
	if(checkCnt > 3){	//재귀함수 3번 초과 호출 불가
		return empl_id;
	}
	
	//대직자
	String t54param1 = empl_id;
	if(empl_id.length() < 6){
		for(int i=0; i<(6-empl_id.length());i++){
			t54param1 = "0" + t54param1;
		}
	}
	
	List<T54DData> t54List = dao.selectT54D(t54param1);
	
	if(t54List.size() == 0){
		logger.debug("[DEBUG] #############  result :"+result);
		return result;
	}
	
	for(T54DData t54 : t54List){
		if(!t54.getWrpxEmn().equals("000000")){
			int startDay = Integer.parseInt(t54.getSttgYmd());
			int endDay = Integer.parseInt(t54.getFnshYmd());
			
			if(startDay <= today && today<= endDay){
				logger.debug("[DEBUG] #############  대직자 정보 :"+substrWrpxEmn(t54.getWrpxEmn()));
				return choiceApprover(substrWrpxEmn(t54.getWrpxEmn()), checkCnt);
			}
		}
	}
	
	logger.debug("[DEBUG] #############  result :"+result);
	return result;
	
}


public String substrWrpxEmn(String wrpxEmn){
	int subIdx = 0;
	for (int i = 0; i < wrpxEmn.length(); i++) {
		if(wrpxEmn.charAt(i) == '0'){
			subIdx++;
		}else{
			break;
		}
	}
	return wrpxEmn.substring(subIdx);
}


/**
 * 기안 반려
 * 
 * @param condition
 */
@Transactional(transactionManager = "ibkSmsTxManager")
public void reject(ConfirmListSearchCondition condition) {
	//1. 승인자 상태 반려 처리
	condition.setEmplId(condition.getAgreeId());  //승인자 ID 셋팅
	condition.setAgreeStatus("N");
	int result = dao.updateT32Accept(condition);
	logger.debug("[DEBUG INFO] #############  승인자 상태 반려 처리 :"+result);
	if(result < 0){
		new Exception("ERROR : 기안 승인 처리 오류 발생");
	}
	
	//2. 기안 반려 상태 처리 : 결재진행중(A) -> 반려(N)
	condition.setPrcssStusDstic("N");
	result = dao.updateT21Agree(condition);
	logger.debug("[DEBUG INFO] #############  기안 반려 상태 처리 : 결재진행중(A) -> 반려(N) :"+result);
	
	//3. 기안 반려 사유 처리
	result = dao.updateReason_T21_INFO(condition);
	logger.debug("[DEBUG INFO] #############  기안 반려 사유 처리 :"+result);
}



/**
 * 기안 저장 후 승인
 * 
 * @param smsReqData
 * @param agreeType 
 * @param agreeId 
 * @throws FileNotFoundException 
 */
@Transactional(transactionManager = "ibkSmsTxManager")
public void saveAccept(SmsReqData smsReqData, String agreeType, String agreeId) throws FileNotFoundException {
	/**
	 * 1. T21 기안 내용 수정
	 * 2. 신규 파일 존재 여부 확인 (신규 판단 여부는 각 path 변수 null 여부로 체크 : null(신규X), not null(신규O))
	 * 2-1. 신규 파일 존재할 경우 파일 디렉토리에 파일 옮김
	 * 2-2. 신규 파일 없을 경우 무시
	 * 2-3. 신규 파일 존재하지 않고 T21 기안 내용 수정시 T28 헤더 정보 수정 (T28 헤더에 해당 되는 내용 변경 시)
	 * 4. 기안 승인 처리
	 */
	
	//1. T21 기안 내용 수정
	smsReqService.updateSmsReq(smsReqData); //updateSmsReq
	
	//2. 신규 파일 존재 여부 확인 @@@@@@@@@@@@@@@@@@@@@@@@개발 필요
	boolean newFile = false;
	if(smsReqData.getTargetFilePath() != null && !smsReqData.getTargetFilePath().equals("")){ //대상자 파일
		newFile = true;
	}
	if(smsReqData.getImagePath1() != null && !smsReqData.getImagePath1().equals("")){	// 이미지파일1
		newFile = true;
	}
	if(smsReqData.getImagePath2() != null && !smsReqData.getImagePath2().equals("")){	// 이미지파일2
		newFile = true;
	}
	if(smsReqData.getImagePath3() != null && !smsReqData.getImagePath3().equals("")){	// 이미지파일3
		newFile = true;
	}
	logger.info("######신규 파일 : " + newFile + " / 헤더변경 여부 : " + smsReqData.getChangeHeadDataYn());
	
	//2-1. 신규 파일 존재 시 파일 이전
	if(newFile){
		smsReqService.targetFileHandler(smsReqData);
	}
	
	//2-3. 신규 파일 존재하지 않고 T21 기안 내용 수정시 T28 헤더 정보 수정 (T28 헤더에 해당 되는 내용 변경 시)
	if(!newFile && smsReqData.getChangeHeadDataYn().equals("Y")){
		smsReqService.updateT28InputOrigin(smsReqData);
	}
	
	//4. 기안 승인 처리
	ConfirmListSearchCondition condition = new ConfirmListSearchCondition();
	condition.setGroupUniqNo(smsReqData.getGroupUniqNo());
	condition.setEmplId(smsReqData.getEmplId());
	condition.setAgreeType(agreeType);
	condition.setAgreeId(agreeId);
	
	accept(condition);
	
}


/**
 * 해당 사용자의 승인 총 건수
 * 
 * 조회 조건 
 * 	  1. T21 상태값 == A(결재진행중), I(발송승인중)
 *   2. T32 승인타입 != 4차
 *   3. T32 승인상태가 == I(승인대기)
 *   4. T32 승인자 == empl_id
 *   
 * @param empl_id
 * @return
 */
public int totalCntConfirm(String empl_id){
	return dao.selectTotalCntConfirm(empl_id);
}

}
