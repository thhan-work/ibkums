package com.ibk.msg.web.allmessage;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.google.common.base.Preconditions;
import com.ibk.msg.common.dto.PaginationResponse;
import com.ibk.msg.web.auth.EmployeeInfo;
import com.ibk.msg.web.auth.EmployeeService;
import com.ibk.msg.web.loglist.LogListDao;

@Component
@ConfigurationProperties(prefix="spring")
public class AllMessageService {

	private static final Logger logger = LoggerFactory.getLogger(AllMessageService.class);

	@Autowired
	private AllMessageDao dao;

	@Autowired
	private LogListDao logDao;

	@Autowired
	private EmployeeService employeeService;

	private String motpurl;    

	public String getMotpurl() {
		return motpurl;
	}

	public void setMotpurl(String motpurl) {
		this.motpurl = motpurl;
	}

	public PaginationResponse findByPagination(AllMessageSearchCondition searchCondition)
			throws Exception {
		Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
		Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");

		searchCondition.setSearchStartDt(searchCondition.getSearchStartDt());
		searchCondition.setSearchEndDt(searchCondition.getSearchEndDt());
		searchCondition.setRegDt(searchCondition.getSearchStartDt().substring(0, 6));

		//    String boCode = searchCondition.getBoCode();
		//    String emplId = searchCondition.getEmplId();
		//    String tranId = "CC" + boCode + "_" + emplId; 
		//    
		//    searchCondition.setBoCode(tranId);
		List<AllMessage> users = null;
		int totalCount = 0;
		String searchPhoneNumber = searchCondition.getSearchPhoneNumber();
		if (searchPhoneNumber == null || searchPhoneNumber.trim().equals("")) {
			users = new ArrayList<AllMessage>();
			return new PaginationResponse(searchCondition, totalCount, users);
		} else {

			// 직원 휴대폰번호 검증 (2021-08-12)
			int iCheckEmplHp = checkEmplHp(searchCondition);
			if(iCheckEmplHp > 0) {
				// 직원 휴대폰번호는 검색할 수 없음
				searchPhoneNumber = null;
				// Preconditions.checkArgument(false, "phone number is not equal");
				users = new ArrayList<AllMessage>();
				return new PaginationResponse(searchCondition, totalCount, users);
			} else {
				try {
					totalCount = dao.findTotalCount(searchCondition);
					users = dao.findAllMessage(searchCondition);
				} catch (Exception e) {
					totalCount = dao.findTotalCount2(searchCondition);
					users = dao.findAllMessage2(searchCondition);
				}
			}
		}

		//1.결과값 매핑
		for(AllMessage user : users){
			user.setRslt(user.getRslt() == null ? "결과대기중" : user.getRslt());
			user.setLvia(user.getUnitName());
			user.setMsg(user.getMsg() == null ? "" : user.getMsg());
		}

		HashMap<String, String> pram = new HashMap<String, String>();
		String seachValue = "[전체메시지]시작일:"+searchCondition.getSearchStartDt() + "종료일:" + searchCondition.getSearchEndDt() + "휴대폰번호:" + searchPhoneNumber;

		pram.put("emplId", searchCondition.getEmplId());
		pram.put("seachValue", seachValue);
		pram.put("ipAdr", searchCondition.getEmplIp());
		logDao.msgHistoryLog(pram);

		return new PaginationResponse(searchCondition, totalCount, users);
	}


	public int successCount(AllMessageSearchCondition searchCondition){
		int iRetVal = 0;
		String searchPhoneNumber = searchCondition.getSearchPhoneNumber();
		if (searchPhoneNumber == null || searchPhoneNumber.trim().equals("")) {
			return 0;
		} else {
			// 직원 휴대폰번호 검증 (2021-08-12)
			int iCheckEmplHp = checkEmplHp(searchCondition);
			if(iCheckEmplHp > 0) {
				// 직원 휴대폰번호는 검색할 수 없음
				return 0;
			} else {
				searchCondition.setRegDt(searchCondition.getSearchStartDt().substring(0, 6));
				iRetVal =  dao.successCount(searchCondition);
			}
		}
		return iRetVal;
	}
	
	public int checkEmplHp(AllMessageSearchCondition searchCondition) {
		int iRetVal = 0;
		String searchPhoneNumber = searchCondition.getSearchPhoneNumber();
		if (searchPhoneNumber == null || searchPhoneNumber.trim().equals("")) {
			iRetVal = -1;
		} else {
			iRetVal = employeeService.checkEmplHp(searchPhoneNumber);
		}

		return iRetVal;
	}
	
	public String login(String allmsg_id, String allmsg_pw, Model model) {
		//1. login 시도 성공 여부 체크
		//2. 로그인 성공 시
		//2-1. 전체 메시지 화면 이동
		//3. 로그인 실패 시
		//3-1. 로그인 페이지로 이동

		//1. login 시도 성공 여부 체크
		String result = checkLogin(allmsg_id, allmsg_pw);

		logger.info(" 경조사 메시지 보내기 로그인 결과 : " + result);

		if (result.equals("LOGIN_OK")) {//2. 로그인 성공 시
			//2-1. 전체 메시지 화면 이동
			return "allmessage/allmessage-list";

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
		return "allmessage/login";
	}


	public String checkLogin(String event_id, String event_pw) {
		String CON_ID = null;
		String CON_PWD = null;
		String rslt = null;

		//로그인 정보 검색 타입
		String loginInfoType = "msg_con_send";

		// 로그인 가능 계정 정보 조회
		List<HashMap<String, String>> loginInfo = dao.checkLogin(loginInfoType);

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
	
	public Object modify(AllMessage allMessage) {
		// TODO Auto-generated method stub
		return null;
	}


	@Transactional(transactionManager = "ibkSmsTxManager")
	public int unitModify(Map<String, Object> param) {

		int resultUpdate = dao.unitModify(param);

		HashMap<String, String> pramHistory = new HashMap<String, String>();
		//		[전체메시지-수정]업무부서: 채널부/ 업무담당자: 홍길동/ 담당자전화번호:8-8888
		String updateValue = "[전체메시지-수정]업무부서:" + param.get("asisRspblDvsnName") 
		+ "/ 업무담당자:" + param.get("asisRspblPsnName")
		+ "/ 담당자전화번호:" + param.get("asisRspblPsnTelno");

		pramHistory.put("emplId", (String) param.get("emplId"));
		pramHistory.put("seachValue", updateValue);
		pramHistory.put("ipAdr", (String) param.get("ip"));
		logDao.msgHistoryLog(pramHistory);

		return resultUpdate;
	}

	
	public Object crmviewSelect(AllMessageSearchCondition searchCondition){
		HashMap<String, String> pram = new HashMap<String, String>();
		Map<String,Object> crmview = null;
		
		try {
			String seachValue = "[CRM조회]조회날짜:"+searchCondition.getRegDt() + "조회KEY:" + searchCondition.getMsgKey();
			pram.put("emplId", searchCondition.getEmplId());
			pram.put("seachValue", seachValue);
			pram.put("ipAdr", searchCondition.getEmplIp());
			logDao.msgHistoryLog(pram);
			
			if (searchCondition.getRegDt().length() == 8) {
				searchCondition.setRegDt(searchCondition.getRegDt().substring(0,6));
				try {
					crmview = dao.crmview(searchCondition);
				} catch (Exception e) {
					crmview = dao.crmview2(searchCondition);
				}
			}
		} catch (Exception e) {
			logger.error("", e);
		}

		return crmview;
	}

}
