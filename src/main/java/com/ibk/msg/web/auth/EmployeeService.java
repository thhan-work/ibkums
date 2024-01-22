package com.ibk.msg.web.auth;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

import com.google.common.base.Preconditions;
import com.ibk.msg.common.dto.PaginationResponse;
import com.ibk.msg.utils.IPUtils;
import com.ibk.msg.utils.RedirectionUtils;
import com.ibk.msg.web.loginhistory.LoginHistoryService;
import com.ibk.msg.web.user.UserInfo;

@Component
@ConfigurationProperties(prefix="spring")
public class EmployeeService {
	private static final Logger logger = LoggerFactory.getLogger(EmployeeService.class);
	
    @Autowired
    private EmployeeDao dao;
    
    @Autowired
    private LoginHistoryService loginHistoryService;

    private String motpurl;

	public String getMotpurl() {
		return motpurl;
	}

	public void setMotpurl(String motpurl) {
		this.motpurl = motpurl;
	}


    public EmployeeInfo findDetail(String EMPL_ID) {
        return dao.findDetail(EMPL_ID);
    }
    
    public EmployeeInfo findDetailEmplA(String EMPL_ID) {
        return dao.findDetailEmplA(EMPL_ID);
    }
    
    // 직원 휴대폰번호가 존재하는지 체크 (2021-08-12)
    public int checkEmplHp(String emplHpNo) {
    	return dao.checkEmplHp(emplHpNo);
    }

    public PaginationResponse findByPagination(EmployeeInfoSearchCondition searchCondition)
            throws Exception {

        Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
        Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");

        int totalCount = dao.findTotalCount(searchCondition);
        List<EmployeeInfo> users = dao.findEmployee(searchCondition);
        return new PaginationResponse(searchCondition, totalCount, users);
    }
    
    public PaginationResponse findBocodeByPagination(EmployeeInfoSearchCondition searchCondition)
            throws Exception {

        Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
        Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");

        int totalCount = dao.findBocodeTotalCount(searchCondition);
        List<EmployeeInfo> parts = dao.findBocode(searchCondition);
        return new PaginationResponse(searchCondition, totalCount, parts);
    }

    public LoginResult getSSOUserClass(String EMPL_ID, HttpSession httpSession, HttpServletRequest request) {
		String userClass = "";
		String clientIp = IPUtils.getClientIp(request);
		LoginResult loginResult = new LoginResult();
		UserInfo userInfo = dao.findUserInfo(EMPL_ID);
		if (userInfo != null) {
			//관리자 계정
			if(userInfo.getEmplLevel().trim().equals("A")){			
				if(userInfo.getEmplIp() != null 
						&& !userInfo.getEmplIp().trim().equals("") 
						&& IPUtils.isMatch(userInfo.getEmplIp().trim(), clientIp)){
					userClass = "A";
					loginResult.setUserClass("A");
					return loginResult;
				}else{
					logger.info("관리자 권한 IP 불일치 Client IP[" + clientIp +"]");
					userClass = "N";
					loginResult.setUserClass("N");
					loginResult.setErrorMsg("관리자 권한 IP 불일치 Client IP[" + clientIp +"]");
				}
			} else if(userInfo.getEmplLevel().trim().equals("S")){
				// 직원용SMS
				if(userInfo.getEmplIp() != null && !userInfo.getEmplIp().trim().equals("")){
					if(IPUtils.isMatch(userInfo.getEmplIp().trim(), clientIp)){
						userClass += "S";
						loginResult.setUserClass( loginResult.getUserClass() + "S");						
					}else{
						logger.info("인사부(직원발송) 권한 IP 불일치 Client IP[" + clientIp +"]");
						userClass += "N";
						loginResult.setUserClass( loginResult.getUserClass() + "N");
					}
				}
				// 승인권자
				if(userInfo.getUserLevel().trim().equals("2") || userInfo.getUserLevel().trim().equals("3")){
					userClass += "P";
					loginResult.setUserClass( loginResult.getUserClass() + "P");
				}
			} else {
				if(userInfo.getEmplIp() != null 
						&& !userInfo.getEmplIp().trim().equals("") 
						&& IPUtils.isMatch(userInfo.getEmplIp().trim(), clientIp)){
					userClass = userInfo.getUserLevel().trim();
					loginResult.setUserClass("N");
					return loginResult;
				}else{
					logger.info(userInfo.getUserLevel().trim() + " 권한 IP 불일치 Client IP[" + clientIp +"]");
					userClass = "N";
					loginResult.setUserClass("N");
					loginResult.setErrorMsg(userInfo.getUserLevel().trim() +" Client IP[" + clientIp +"]");
				}
			}
			
			return loginResult;
		}

		return loginResult;
	}
    /*public String getSSOUserClass(String EMPL_ID, HttpSession httpSession, HttpServletRequest request) {
    	String userClass = "";
		String clientIp = IPUtils.getClientIp(request);
		
		UserInfo userInfo = dao.findUserInfo(EMPL_ID);
		if (userInfo != null) {
			//관리자 계정
			if(userInfo.getAdminYn().trim().equals("Y")){			
				if(userInfo.getEmplIp() != null 
						&& !userInfo.getEmplIp().trim().equals("") 
						&& IPUtils.isMatch(userInfo.getEmplIp().trim(), clientIp)){
					userClass = "A";
					return userClass;
				}else{
					logger.info("관리자 권한 IP 불일치 Client IP[" + clientIp +"]");
					userClass = "N";
				}
			}

			if(userInfo.getAdminYn().trim().equals("N")){
				// 직원용SMS
				if(userInfo.getEmplIp() != null && !userInfo.getEmplIp().trim().equals("")){
					if(IPUtils.isMatch(userInfo.getEmplIp().trim(), clientIp)){
						userClass += "S";
					}else{
						logger.info("인사부(직원발송) 권한 IP 불일치 Client IP[" + clientIp +"]");
						userClass += "N";
					}
				}
				// 승인권자
				if(userInfo.getUserLevel().trim().equals("2") || userInfo.getUserLevel().trim().equals("3")){
					userClass += "P";
				}
			}
			return userClass;
		}
		
		return "N";
    }*/
	/**
	 * 사이드 메뉴 표시 등급 설정
	 * 
	 * #### 등급 정리 ---
	 *  - 관리자 		: 	A
	 *  - 일반 		: 	N
	 *  - 승인권자 	:	P 
	 *  - 직원용SMS	:	S
	 * #### -----------
	 * 
	 * @param ibkssouserid
	 * @param httpSession
	 * @param request 
	 */
	public LoginResult checkUserInfo(HttpSession httpSession, HttpServletRequest request) {
		String loginMethod = httpSession.getAttribute("LOGIN_METHOD").toString();
		
		if (loginMethod.equals("sso")) {
			String sso_id = httpSession.getAttribute("EMPL_ID").toString();
			LoginResult loginResult = getSSOUserClass(sso_id, httpSession, request);
			return loginResult;
//			return getSSOUserClass(sso_id, httpSession, request);
		}
		
		if (loginMethod.equals("sso_user")) {
			LoginResult loginResult = new LoginResult();
			loginResult.setUserClass("N");
//			return "N";
			return loginResult;
		}

		if (loginMethod.equals("motp_emp")) {
			String motp_id = httpSession.getAttribute("EMPL_ID").toString();
			LoginResult loginResult = getSSOUserClass(motp_id, httpSession, request);
			return loginResult;
		}

		if (loginMethod.equals("motp")) {
			String motp_id = httpSession.getAttribute("LOGIN_ID").toString();
			HashMap<String, Object> loginInfo = dao.motpCheck(motp_id);
			LoginResult loginResult = new LoginResult();
			loginResult.setUserClass(loginInfo.get("EMPL_LEVEL").toString());
			return loginResult;
		}

		if (loginMethod.equals("idpw")) {
			String login_id = httpSession.getAttribute("LOGIN_ID").toString();
			HashMap<String, Object> loginInfo = dao.loginCheck(login_id);
			LoginResult loginResult = new LoginResult();
			loginResult.setUserClass(loginInfo.get("EMPL_LEVEL").toString());
			return loginResult;
		}
		LoginResult loginResult = new LoginResult();
		loginResult.setUserClass("N");
		return loginResult;
	}

	public UserMappingInfo findUserMappingLoginId(UserMappingInfo searchUserMapping) {
		return dao.findUserMappingLoginId(searchUserMapping);
	}


	public UserMappingInfo findUserMappingconnectIP(UserMappingInfo searchUserMapping) {
		return dao.findUserMappingconnectIP(searchUserMapping);
	}
	
	/**
	 * SSO 실패 시 2차 로그인계정 권한 체크
	 * 
	 * @param emplId
	 * @param object
	 * @param request
	 * @return
	 */
	public String checkLoginAuthInfo(String emplId, Object object, HttpServletRequest request) {

		HashMap<String, String> loginAuthInfo = dao.findLoginAuthInfo(emplId);
		String clientIp = IPUtils.getClientIp(request);

		if(loginAuthInfo == null){
			logger.info("####loginAuthInfo NULL!!!!!!!!!");
			return "N";
		}

		try {
			//사용여부
			if(!loginAuthInfo.get("USE_YN").trim().equals("Y")){
				logger.info("####USER 사용 여부 : N  EMPL_ID[" + emplId +"]");
				return "N";
			}

			//권한체크 (A : 관리자, M : 모니터링권한, C: 분배비율)
			if(!loginAuthInfo.get("EMPL_LEVEL").trim().equals("A") && !loginAuthInfo.get("EMPL_LEVEL").trim().equals("M") && !loginAuthInfo.get("EMPL_LEVEL").trim().equals("C")){
				logger.info("####USER 접근 권한 없음. EMPL_LEVEL[" + loginAuthInfo.get("EMPL_LEVEL").trim() +"]");
				return "N";
			}

			// 관리자(A)권한 일떄 IP체크
			//			if(loginAuthInfo.get("EMPL_LEVEL").trim().equals("A")){
			//IP 체크
			
			if(!IPUtils.isMatch(loginAuthInfo.get("EMPL_IP").trim(), clientIp)){
				logger.info("####USER 접속 IP 불일치 Client IP[{}]", clientIp);
				return "N";
			}				
			//			}

			logger.info("####USER 접속 성공 EMPL_LEVEL[" + loginAuthInfo.get("EMPL_LEVEL").trim() +"]");


			HttpSession httpSession = request.getSession();

			httpSession.setAttribute("EMPL_ID", emplId);
			httpSession.setAttribute("EMPL_NAME", loginAuthInfo.get("EMPL_NAME") != null ? loginAuthInfo.get("EMPL_NAME").trim() : "");
			httpSession.setAttribute("EMPL_BOCODE", loginAuthInfo.get("BO_CODE") != null ? loginAuthInfo.get("BO_CODE").trim() : "");
			httpSession.setAttribute("USER_CLASS", loginAuthInfo.get("EMPL_LEVEL").trim());

			return loginAuthInfo.get("EMPL_LEVEL").trim();
		} catch (NullPointerException e) {
			logger.info("####NullPointerException!!");
			return "N";
		}
	}
	
	private String error(Model model, String errormsg, String path) {
		model.addAttribute("errorMsg", errormsg);
		
		return path;
	}
	public String idpwLoginCheck(String allmsg_id, String allmsg_pw
			, Model model, HttpServletRequest httpServletRequest) {
		//1. login 시도 성공 여부 체크
		//2. 로그인 성공 시
		//2-1. 전체 메시지 화면 이동
		//3. 로그인 실패 시
		//3-1. 로그인 페이지로 이동

		//1. login 시도 성공 여부 체크
		HashMap<String, Object> loginInfo = null;
		String userClass = "N";

		HttpSession httpSession = httpServletRequest.getSession();
		String clientIp = IPUtils.getClientIp(httpServletRequest);

		loginInfo = dao.loginCheck(allmsg_id);

		if(loginInfo == null  || loginInfo.size() <= 0){ // 로그인 가능 계정 정보 없음
			loginHistoryService.insertLogHistory("idpw", allmsg_id, clientIp, "등록된 계정이 없습니다.");
			return error(model, "등록된 계정이 없습니다.<br>담당자에게 문의 하시기 바랍니다.", "common/login");
		}
		
		if (Integer.parseInt(loginInfo.get("LOGIN_FAIL_CN").toString()) > 5) {
			loginHistoryService.insertLogHistory("idpw", allmsg_id, clientIp, "로그인 실패 5회초과.");
			return error(model, "로그인 실패 5회초과. 관리자에게 문의하세요.", "common/login");
		} 
		if(!loginInfo.get("LOGIN_ID").equals(allmsg_id)) {
			loginHistoryService.insertLogHistory("idpw", allmsg_id, clientIp, "등록된 계정이 없습니다.");
			return error(model, "등록된 계정이 없습니다.<br>담당자에게 문의 하시기 바랍니다.", "common/login");
		}
		
		if(!loginInfo.get("PASSWD").equals(allmsg_pw)) {
			dao.updateLoginFailCn(allmsg_id);
			loginHistoryService.insertLogHistory("idpw", allmsg_id, clientIp, "ID / PW 정보를 확인하여 주시기 바랍니다.");
			return error(model, "ID / PW 정보를 확인하여 주시기 바랍니다.", "common/login");
		}
		//사용여부
		if(!loginInfo.get("USE_YN").toString().trim().equals("Y")){
			loginHistoryService.insertLogHistory("idpw", allmsg_id, clientIp, "비활성화된 계정입니다.");
			return error(model, "비활성화된 계정입니다.", "common/login");
		}
		
		//관리자일 경우 IP 체크
		//IP체크
		if(loginInfo.get("EMPL_IP") == null || !IPUtils.isMatch(loginInfo.get("EMPL_IP").toString().trim(), clientIp)){
			loginHistoryService.insertLogHistory("idpw", allmsg_id, clientIp, "접근 불가능한 IP입니다.");
			return error(model, "접근 불가능한 IP입니다.<br><br>담당자에게 문의하여 주시기 바랍니다.", "common/login");
		}
		
		dao.updateLoginDt(allmsg_id);

		userClass=loginInfo.get("EMPL_LEVEL").toString();
		httpSession.setAttribute("EMPL_ID", loginInfo.get("EMPL_ID"));
		httpSession.setAttribute("LOGIN_ID", loginInfo.get("LOGIN_ID"));
		httpSession.setAttribute("EMPL_NAME",loginInfo.get("EMPL_NAME"));
		httpSession.setAttribute("EMPL_BOCODE", loginInfo.get("BO_CODE"));
		httpSession.setAttribute("EMPL_BONAME", loginInfo.get("PART_NAME"));
		httpSession.setAttribute("USER_CLASS",  userClass);
		httpSession.setAttribute("LOGIN_OK",  "Y");
		httpSession.setAttribute("isLoginPassed", false);
		httpSession.setAttribute("LOGIN_METHOD", "idpw");

		
		if (loginInfo.get("PW_CN_DT") != null) {			
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.DAY_OF_YEAR, -90);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String format = sdf.format(calendar.getTime());
			String passwordChangeDate = loginInfo.get("PW_CN_DT").toString();
			
			if (passwordChangeDate.compareTo(format) < 0) {
				httpSession.setAttribute("PW_CN_DT", "idpw");
				return error(model, "현재 비밀번호가 90일 이전에 변경되었습니다. 비밀번호를 변경하셔야 됩니다.", "redirect:forcechangepassword.ibk");
			}
		}
		
		loginHistoryService.insertLogHistory("idpw", allmsg_id, clientIp, "성공");
		return RedirectionUtils.getMainPage(httpServletRequest, "redirect:eventsend.ibk");
/*		if(userClass.equals("G")) {	//2-1. 전체 메시지 화면 이동
 			loginHistoryService.insertLogHistory("idpw", allmsg_id, clientIp, "성공");
 			return "eventSend/send-event";
		}else if(userClass.equals("A")) {
			loginHistoryService.insertLogHistory("idpw", allmsg_id, clientIp, "성공");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			String now = sdf.format(System.currentTimeMillis());
			String passDeadLine = "201909";
			System.out.println("##ADMIN PASS TERM : " + passDeadLine);
			System.out.println("##NOW : "+now);
			System.out.println("##TERM : " + passDeadLine);
			if(Integer.parseInt(now) < Integer.parseInt(passDeadLine)){
				return "redirect:message.ibk";
			}else{
				return "eventSend/send-event";
			}
		}else{	//접근권한 없음.
			loginHistoryService.insertLogHistory("idpw", allmsg_id, clientIp, "접근 권한이 없는 계정입니다.");
			return error(model, "접근 권한이 없는 계정입니다.<br><br>담당자에게 문의하여 주시기 바랍니다.", "common/login");
		}*/
		
		//3-1. 로그인 페이지로 이동
//		return "common/login";
		
	}
	
	public String motpLoginCheck(String motp_id, String motp_no, Model model, HttpServletRequest httpServletRequest) {
		//1. login 시도 성공 여부 체크
		//2. 로그인 성공 시
		//2-1. 전체 메시지 화면 이동
		//3. 로그인 실패 시
		//3-1. 로그인 페이지로 이동

		//1. login 시도 성공 여부 체크
		
		String userClass = "N";
		String result = "DEFAULT";

		HttpSession httpSession = httpServletRequest.getSession();
		String clientIp = IPUtils.getClientIp(httpServletRequest);

		

		// check MOTP
//		String callAuth = "retcode=OT0000";
		String callAuth = callAuth(motp_id , motp_no);
		if (callAuth.indexOf("retcode=OT0000") == -1) {
			String otpError = callAuth.substring(callAuth.indexOf("errmsg=")+7).replaceAll("\\n","");			
			dao.updateMotpFailCn(motp_id);
			loginHistoryService.insertLogHistory("motp", motp_id, clientIp, otpError);
			return error(model, otpError, "common/motp_login");
		} 
		
		//조직도 확인 먼저
		EmployeeInfo employeeInfo = findDetail(motp_id);
		if(employeeInfo == null){ //A 사번 체크를 위한 로직
			employeeInfo = findDetailEmplA(motp_id);
		}
		if (employeeInfo != null) {
			//Session 부여
			httpSession.setAttribute("EMPL_ID", motp_id);
			httpSession.setAttribute("EMPL_NAME", employeeInfo.getEmplName());
			httpSession.setAttribute("EMPL_BOCODE", employeeInfo.getBoCode());
			httpSession.setAttribute("EMPL_CLASS", employeeInfo.getEmplClass());
			httpSession.setAttribute("EMPL_EMAIL", employeeInfo.getEmalAdr());
			httpSession.setAttribute("EMPL_HP", employeeInfo.getEmplHpNo());
			httpSession.setAttribute("isLoginPassed", false);
			httpSession.setAttribute("LOGIN_METHOD", "motp_emp");

			//SIDE MENU 등급 조회
			LoginResult loginResult = getSSOUserClass(motp_id, httpSession, httpServletRequest);
			userClass = loginResult.getUserClass();
			httpSession.setAttribute("USER_CLASS", userClass);
			
			loginHistoryService.insertLogHistory("motp_emp", motp_id, clientIp, "성공");
			return RedirectionUtils.getMainPage(httpServletRequest, "redirect:message.ibk");
		}

		HashMap<String, Object> loginInfo = dao.motpCheck(motp_id);
		if(loginInfo == null  || loginInfo.size() <= 0){ // 로그인 가능 계정 정보 없음
			loginHistoryService.insertLogHistory("motp", motp_id, clientIp, "등록된 계정이 없습니다.");
			return error(model, "등록된 계정이 없습니다.<br>담당자에게 문의 하시기 바랍니다.", "common/motp_login");
		}
		
	/*	if (Integer.parseInt(loginInfo.get("LOGIN_FAIL_CN").toString()) > 5) {
			loginHistoryService.insertLogHistory("motp", motp_id, clientIp, "로그인 실패 5회초과.");
			return error(model, "로그인 실패 5회초과. 관리자에게 문의하세요.", "common/motp_login");
		} */
		if(!loginInfo.get("LOGIN_ID").equals(motp_id)) {
			loginHistoryService.insertLogHistory("motp", motp_id, clientIp, "등록된 계정이 없습니다.");
			return error(model, "등록된 계정이 없습니다.<br>담당자에게 문의 하시기 바랍니다.", "common/motp_login");
		}
		
		//사용여부
		if(!loginInfo.get("USE_YN").toString().trim().equals("Y")){
			loginHistoryService.insertLogHistory("motp", motp_id, clientIp, "비활성화된 계정입니다.");
			return error(model, "비활성화된 계정입니다.", "common/motp_login");
		}
		
		//관리자일 경우 IP 체크
		//IP체크
		if(loginInfo.get("EMPL_IP") != null && !IPUtils.isMatch(loginInfo.get("EMPL_IP").toString().trim(), clientIp)){
			loginHistoryService.insertLogHistory("motp", motp_id, clientIp, "접근 불가능한 IP입니다.");
			return error(model, "접근 불가능한 IP입니다.<br><br>담당자에게 문의하여 주시기 바랍니다.", "common/motp_login");
		}
		
		dao.updateMotpDt(motp_id);

		userClass=loginInfo.get("EMPL_LEVEL").toString();
		httpSession.setAttribute("EMPL_ID", loginInfo.get("EMPL_ID"));
		httpSession.setAttribute("LOGIN_ID", loginInfo.get("LOGIN_ID"));
		httpSession.setAttribute("EMPL_NAME",loginInfo.get("EMPL_NAME"));
		httpSession.setAttribute("EMPL_BOCODE", loginInfo.get("BO_CODE"));
		httpSession.setAttribute("USER_CLASS",  userClass);
		httpSession.setAttribute("LOGIN_OK",  "Y");
		httpSession.setAttribute("isLoginPassed", false);
		httpSession.setAttribute("LOGIN_METHOD", "motp");
		
		loginHistoryService.insertLogHistory("motp", motp_id, clientIp, "성공");
		return RedirectionUtils.getMainPage(httpServletRequest, "redirect:message.ibk");

		/*if(userClass.equals("G")) {	//2-1. 전체 메시지 화면 이동
			loginHistoryService.insertLogHistory("motp", motp_id, clientIp, "성공.");
			return "eventSend/send-event";
		}else if(userClass.equals("A")) {
			loginHistoryService.insertLogHistory("motp", motp_id, clientIp, "성공.");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			String now = sdf.format(System.currentTimeMillis());
			String passDeadLine = "201909";
			System.out.println("##ADMIN PASS TERM : " + passDeadLine);
			System.out.println("##NOW : "+now);
			System.out.println("##TERM : " + passDeadLine);
			if(Integer.parseInt(now) < Integer.parseInt(passDeadLine)){
				return "redirect:message.ibk";
			}else{
				return "eventSend/send-event";
			}
		}else{	//접근권한 없음.
			loginHistoryService.insertLogHistory("motp", motp_id, clientIp, "접근 권한이 없는 계정입니다.");
			return error(model, "접근 권한이 없는 계정입니다.<br><br>담당자에게 문의하여 주시기 바랍니다.", "common/motp_login");
		}*/
		
	}

	public String callAuth(String userid , String otp_no){
		/* ※ 처리결과 형식(예)
		 (인증처리가 정상인 경우)
		   retcode=OT0000|retmsg=성공
		 (인증처리가 실패인 경우)
		   retcode=OT1103|errmsg=OTP발생번호 검증에 실패하였습니다. OTP발생번호 확인 후 다시 시도하십시오.
		 */
		HttpURLConnection connection = null;
		URL url;
		try {
			String resulturl = motpurl;

			url = new URL(resulturl);

			connection = (HttpURLConnection) url.openConnection();
			connection.setRequestMethod("POST");
			connection.setDoInput(true);
			connection.setDoOutput(true);
			connection.setConnectTimeout(3000);
			connection.setReadTimeout(3000);

			try(OutputStream out = connection.getOutputStream()){
				out.write(("userid="+URLEncoder.encode(userid,"UTF-8")).getBytes());
				out.write("&".getBytes());
				out.write(("otp_no="+URLEncoder.encode(otp_no,"UTF-8")).getBytes());
				out.write("&".getBytes());
				out.write(("logintype=nomal").getBytes());
			}

			try(InputStream in = connection.getInputStream();
					ByteArrayOutputStream out = new ByteArrayOutputStream()){
				byte[] buf = new byte[1024 * 8];
				int length = 0;
				while((length = in.read(buf)) != -1){
					out.write(buf, 0, length);
				}
				return new String(out.toByteArray(), "UTF-8");
			}

		} catch (MalformedURLException e) {
			logger.error("", e);
		} catch (Exception ee) {
			logger.error("", ee);
		}
		return "errmsg=MOTP 접속 불가";
	}

	
}
