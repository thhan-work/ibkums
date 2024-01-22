package com.ibk.msg.web.auth;

import com.ibk.msg.utils.IPUtils;
import com.ibk.msg.utils.RedirectionUtils;
import com.ibk.msg.web.loginhistory.LoginHistoryService;
import com.ibk.msg.web.user.UserInfoService;
import com.initech.eam.nls.CookieManager;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@ConfigurationProperties(prefix="spring")
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private EmployeeService employeeService;
	
	@Autowired
    private LoginHistoryService loginHistoryService;

	@Autowired
	private UserInfoService userInfoService;

	private String loginmode;

	public String getLoginmode() {
		return loginmode;
	}

	public void setLoginmode(String loginmode) {
		this.loginmode = loginmode;
	}

	@GetMapping("/changepassword.ibk")
	public String viewListJspToChangePassword() {
		return "common/login-user-password";
	}

	@PostMapping(value = "/changepassword.ibk")
	public String changePasswordLoginUser(
			@RequestParam(name="passwd", required=true) String passwd		  
			, Model model
			, HttpServletRequest httpServletRequest
			, HttpSession session) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("passwd", passwd);		
		param.put("login_id", session.getAttribute("LOGIN_ID"));
		param.put("mod_id", session.getAttribute("EMPL_ID"));
		
		session.removeAttribute("PW_CN_DT");
		int changePasswordLoginUser = userInfoService.changePasswordLoginUser(param);

		if (changePasswordLoginUser == 0) { 
			// 실패
			model.addAttribute("errorMsg", "비밀번호 변경에 실패하였습니다.");
		} else {
			model.addAttribute("errorMsg", "비밀번호 변경에 성공하였습니다.");
		}

		return "common/login-user-password";
	}
	
	@GetMapping("/forcechangepassword.ibk")
	public String viewListJspToForceChangePassword() {
		return "common/force_passwd_change";
	}
	
	@RequestMapping(value = "/keepSession.ibk", produces = {"application/json"})
	@ResponseBody
	public Object keepSession(HttpServletRequest httpServletRequest) throws Exception {
		return new HashMap<String, Object>();
	}
	
	@PostMapping(value = "/forcechangepassword.ibk")
	public String forceChangePasswordLoginUser(
			@RequestParam(name="passwd", required=true) String passwd		  
			, Model model
			, HttpServletRequest httpServletRequest
			, HttpSession session) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("passwd", passwd);		
		param.put("login_id", session.getAttribute("LOGIN_ID"));
		param.put("mod_id", session.getAttribute("EMPL_ID"));
		
		session.removeAttribute("PW_CN_DT");
		int changePasswordLoginUser = userInfoService.changePasswordLoginUser(param);

		if (changePasswordLoginUser == 0) { 
			// 실패
			model.addAttribute("errorMsg", "비밀번호 변경에 실패하였습니다.");
			return "common/force_passwd_change";
		} else {
			model.addAttribute("errorMsg", "비밀번호 변경에 성공하였습니다.");
		}

		return RedirectionUtils.getMainPage(httpServletRequest, "redirect:");
	}

	@GetMapping("/login.ibk")
	public String viewLoginJsp(HttpServletRequest request) {
		return RedirectionUtils.getMainPage(request, "common/login");
	}

	@GetMapping("/motp_login.ibk")
	public String viewMotpLoginJsp(HttpServletRequest request) {
		return RedirectionUtils.getMainPage(request, "common/motp_login");
	}


	@PostMapping(value = "/login.ibk", produces = {"application/json"})
	public String event(
			@RequestParam(name="event_id", required=false) String event_id,@RequestParam(name="event_pw", required=false) String event_pw			
			,  Model model, HttpServletRequest httpServletRequest) throws Exception {

		String path = employeeService.idpwLoginCheck(event_id, event_pw, model, httpServletRequest);
		model.addAttribute("inputId", event_id);
		return path;
	}

	@PostMapping(value = "/motp_login.ibk", produces = {"application/json"})
	public String eventMotpLogin(			
			@RequestParam(name="motp_id", required=false) String motp_id,@RequestParam(name="motp_no", required=false) String motp_no
			,  Model model, HttpServletRequest httpServletRequest) throws Exception {

		String path = employeeService.motpLoginCheck(motp_id, motp_no, model, httpServletRequest);		
		model.addAttribute("motpId", motp_id);
		return path;
	}

	@RequestMapping("/")
	public String autoAuth(HttpSession httpSession, HttpServletRequest request) {
		//IBK에서 userid를 받아왔다고 가정함.
		if (loginmode.equals("test")) {
			logger.info("loginmode {}", loginmode);
			String ibkssouserid = "17489";
			logger.info("LOGIN START::::::::: EMPL_ID:" + ibkssouserid);

			//DB 조회
			if (StringUtils.isNotBlank(ibkssouserid)) {

				EmployeeInfo employeeInfo = employeeService.findDetail(ibkssouserid);

				if (employeeInfo != null) {
					//Session 부여
					httpSession.setAttribute("EMPL_ID", ibkssouserid);
					httpSession.setAttribute("EMPL_NAME", employeeInfo.getEmplName());
					httpSession.setAttribute("EMPL_BOCODE", employeeInfo.getBoCode());
					httpSession.setAttribute("EMPL_CLASS", employeeInfo.getEmplClass());
					httpSession.setAttribute("EMPL_EMAIL", employeeInfo.getEmalAdr());
					httpSession.setAttribute("isLoginPassed", false);
					httpSession.setAttribute("LOGIN_METHOD", "sso");

					//SIDE MENU 등급 조회
					LoginResult loginResult = employeeService.getSSOUserClass(ibkssouserid, httpSession, request);
					String userClass = loginResult.getUserClass();
					
					httpSession.setAttribute("USER_CLASS", userClass);
					logger.info("##LOGIN USER USER_CLASS : " + userClass);
				} else {
					//값이 없는데?
				}
			}

			return "index_test";
		}

		return RedirectionUtils.getMainPage(request, "index");
	}
	
/*	private String loginRedirect(HttpServletRequest request, String def) {
		HttpSession session = request.getSession();
	    
	    String emplId = (String) session.getAttribute("EMPL_ID");
	    String userClass = (String) session.getAttribute("USER_CLASS");
	    
		if(StringUtils.isNotBlank(emplId)){	// 세션 존재여부 확인
	    	logger.info("emplId : {}", emplId);
	    	String returnUrl = session.getAttribute("RETURN_URL") != null ? session.getAttribute("RETURN_URL").toString() : "/message.ibk";
	    	session.removeAttribute("RETURN_URL");
			return "redirect:" + returnUrl;
	    }

		return def;
	}*/

	@RequestMapping("/test")
	public String autoTestAuth(HttpSession httpSession, HttpServletRequest request) {
		return "index_sso";
	}

	@RequestMapping("/auth")
	public String autoAuth(@RequestParam(value = "emplId", required = false) String emplId, HttpSession httpSession, HttpServletRequest request) {
		//DB 조회
		if (StringUtils.isNotBlank(emplId)) {

			EmployeeInfo employeeInfo = employeeService.findDetail(emplId);

			if (employeeInfo != null) {
				//Session 부여
				httpSession.setAttribute("EMPL_ID", emplId);
				httpSession.setAttribute("EMPL_NAME", employeeInfo.getEmplName());
				httpSession.setAttribute("EMPL_BOCODE", employeeInfo.getBoCode());
				httpSession.setAttribute("EMPL_CLASS", employeeInfo.getEmplClass());
				httpSession.setAttribute("EMPL_EMAIL", employeeInfo.getEmalAdr());
				httpSession.setAttribute("LOGIN_METHOD", "sso");				
				httpSession.setAttribute("isLoginPassed", false);

				//SIDE MENU 등급 조회
				LoginResult loginResult = employeeService.getSSOUserClass(emplId, httpSession, request);
				String userClass = loginResult.getUserClass();
				
				httpSession.setAttribute("USER_CLASS", userClass);
				logger.info("##LOGIN USER USER_CLASS : " + userClass);

				String returnUrl = httpSession.getAttribute("RETURN_URL") != null ? httpSession.getAttribute("RETURN_URL").toString() : "/message.ibk";
				httpSession.removeAttribute("RETURN_URL");

				return "redirect:" + returnUrl;
			} else {
				//값이 없는데?
				return "index";
			}
		}
		return "index";
	}


	@RequestMapping("/authAllMSG")
	public String autoAuthAllMSG(@RequestParam(value = "emplId", required = false) String emplId, HttpSession httpSession, HttpServletRequest request) {
		//DB 조회
		if (StringUtils.isBlank(emplId)) {

			//Session 부여
			httpSession.setAttribute("EMPL_ID", emplId);
			httpSession.setAttribute("isLoginPassed", false);

			String userClass = "A";

			httpSession.setAttribute("USER_CLASS", userClass);
			logger.info("##LOGIN USER USER_CLASS : " + userClass);

			String returnUrl = httpSession.getAttribute("RETURN_URL") != null ? httpSession.getAttribute("RETURN_URL").toString() : "/message.ibk";
			httpSession.removeAttribute("RETURN_URL");

			return "redirect:" + returnUrl;
		}
		return "allmessage/allmessage-list";
	}


	@RequestMapping("/ssoAllMSG")
	public String autoSSOAllMSGAuth(@RequestParam(value = "ticket", required = false) String ticket, HttpSession httpSession, HttpServletRequest request,HttpServletResponse response) {
		CookieManager.setEncStatus(true);

		String encTicket = (String) request.getParameter("ticket");

		if (encTicket != null) {
			encTicket = URLDecoder.decode(encTicket);
		}
		int firstIndex   = encTicket.indexOf("&&");

		String encTicket2  = encTicket.substring(0, firstIndex);
		String hmac = encTicket.substring(firstIndex + 2);
		//인증티켓과 hmac 값 추출

		List res = null;
		String userid=null;

		boolean decSuccess=false;

		String url = "error/403error";

		try {
			logger.debug("autoSSOAuth  >> try");
			res = CookieManager.readClientTicket(encTicket2, hmac);
			//인증티켓 유효성 검증

			userid = (String) res.get(0);
			//SSOID 추출
			logger.debug("autoSSOAuth  >> try >> ssoid 추출");
			/*url = login(userid, httpSession, request);
			if (url.equals("redirect:/message.ibk")) {
				return "redirect:/allmessage/allmessage-list";
			}*/
			httpSession.setAttribute("EMPL_ID", userid);
			//url = httpSession.getAttribute("RETURN_URL") != null ? httpSession.getAttribute("RETURN_URL").toString() : "redirect:/allmessage/allmessage-list";
			url = "redirect:/allmessage.ibk";
			logger.debug("autoSSOAuth  >> try >> ssoid 추출 >> web 로그인");
			decSuccess=true;

		} catch (Exception e) {
			logger.error("", e);
			httpSession.setAttribute("errorMsg", "SSO 접속 오류");
			decSuccess=false;

		}

		return url;
	}

	@RequestMapping("/sso")
	public String autoSSOAuth(@RequestParam(value = "ticket", required = false) String ticket, HttpSession httpSession, HttpServletRequest request,HttpServletResponse response) {
		CookieManager.setEncStatus(true);

		String encTicket = (String) request.getParameter("ticket");

		if (encTicket != null) {
			encTicket = URLDecoder.decode(encTicket);
		}
		int firstIndex   = encTicket.indexOf("&&");

		String encTicket2  = encTicket.substring(0, firstIndex);
		String hmac = encTicket.substring(firstIndex + 2);
		//인증티켓과 hmac 값 추출

		List res = null;
		String userid=null;

		boolean decSuccess=false;

		String url = "redirect:/motp_login.ibk";

		try {
			logger.debug("autoSSOAuth  >> try");
			res = CookieManager.readClientTicket(encTicket2, hmac);
			//인증티켓 유효성 검증

			userid = (String) res.get(0);
			//SSOID 추출
			logger.debug("autoSSOAuth  >> try >> ssoid 추출");
			// WEB 로그인 시도
			url = login(userid, httpSession, request);
			logger.debug("autoSSOAuth  >> try >> ssoid 추출 >> web 로그인");
			decSuccess=true;

		} catch (Exception e) {
			logger.error("", e);
			httpSession.setAttribute("errorMsg", "SSO 접속 오류");
			decSuccess=false;

		}

		return url;
	}


	/**
	 * SMS 웹 로그인 처리
	 * 
	 * @param emplId
	 * @param httpSession
	 * @param request
	 * @return
	 */
	public String login(String emplId, HttpSession httpSession, HttpServletRequest request){
		//DB 조회
		String clientIp = IPUtils.getClientIp(request);
		
		if (StringUtils.isNotBlank(emplId)) {
			EmployeeInfo employeeInfo = employeeService.findDetail(emplId);
			if(employeeInfo == null){ //A 사번 체크를 위한 로직
				employeeInfo = employeeService.findDetailEmplA(emplId);
			}
			if (employeeInfo != null) {
				//Session 부여
				httpSession.setAttribute("EMPL_ID", emplId);
				httpSession.setAttribute("EMPL_NAME", employeeInfo.getEmplName());
				httpSession.setAttribute("EMPL_BOCODE", employeeInfo.getBoCode());
				httpSession.setAttribute("EMPL_CLASS", employeeInfo.getEmplClass());
				httpSession.setAttribute("EMPL_EMAIL", employeeInfo.getEmalAdr());
				httpSession.setAttribute("isLoginPassed", false);
				httpSession.setAttribute("LOGIN_METHOD", "sso");

				//SIDE MENU 등급 조회
				LoginResult loginResult = employeeService.getSSOUserClass(emplId, httpSession, request);
				String userClass = loginResult.getUserClass();

				httpSession.setAttribute("USER_CLASS", userClass);
				logger.info("##LOGIN USER USER_CLASS : " + userClass);
				
				loginHistoryService.insertLogHistory("sso", emplId, clientIp, "성공");
				return RedirectionUtils.getMainPage(httpSession, "redirect:/message.ibk");
			} else {
				//EMPLOYEE_INFO에 정보가 없을 경우 USER_MAPPING 테이블에서 정보 조회 
				//1. USER_MAAPING 에서 SSO에서 받아온 EMPL_ID로 조회 
				//2-1. EMPL_ID가 존재 할 경우
				//		1. USE_IP_CHECK 데이터 확인 
				//		1-1. 'N'일 경우
				//		1-1-1. 조회한 데이터로 로그인 SESSION 정보에 Setting
				//		1-2. 'Y'일 경우
				//		1-2-1. 해당 EMPL_ID와 접속 IP로 USER_MAAPING 테이블 조회
				//		1-2-1-1. 데이터 존재 할 경우 조회한 데이터로 로그인 SESSION 정보에 Setting
				//		1-2-1-2. 데이터 존재 하지 않을 경우 로그인 실패
				//2-2. EMPL_ID가 존재 하지 않을 경우 
				//		2.	접속 IP로 

				boolean loginOk = false;
				logger.debug("##EMPLOYEE_INFO NOT FIND DATA");
				logger.debug("##SSO EMPL_ID :" + emplId);
				logger.debug("##CONNECT IP :" + clientIp);
				UserMappingInfo searchUserMapping = new UserMappingInfo();
				searchUserMapping.setUseYn("Y");
				searchUserMapping.setLoginId(emplId);
				UserMappingInfo resultUserMapping = employeeService.findUserMappingLoginId(searchUserMapping);

				if(resultUserMapping != null){
					if(resultUserMapping.getUseIpCheck().equals("Y")){
						if(resultUserMapping.getEmplIp() != null && IPUtils.isMatch(resultUserMapping.getEmplIp().trim(), clientIp)){
							loginOk = true;
						}else{
							logger.error("##IP MISMATCH!!!! " + emplId);
						}
					}else{
						loginOk = true;
					}
				}else{
					searchUserMapping = new UserMappingInfo();
					searchUserMapping.setUseYn("Y");
					searchUserMapping.setUseIpCheck("Y");
					searchUserMapping.setEmplIp(clientIp);
					resultUserMapping = employeeService.findUserMappingconnectIP(searchUserMapping);

					if(resultUserMapping != null){
						loginOk = true;
					}else{
						logger.error("##NOT FOUND MAPPING DATA !!!! " + emplId);
					}
				}

				if(loginOk){
					httpSession.setAttribute("EMPL_ID", resultUserMapping.getEmplId());
					httpSession.setAttribute("EMPL_NAME", resultUserMapping.getEmplName());
					httpSession.setAttribute("EMPL_BOCODE", resultUserMapping.getBoCode());
					httpSession.setAttribute("EMPL_CLASS", resultUserMapping.getEmplLevel());
					httpSession.setAttribute("EMPL_EMAIL", "");
					httpSession.setAttribute("isLoginPassed", false);
					httpSession.setAttribute("LOGIN_METHOD", "sso_user");

					//SIDE MENU 등급 조회
					String userClass = "N";

					httpSession.setAttribute("USER_CLASS", userClass);
					logger.info("##LOGIN USER USER_CLASS : " + userClass);
					
					loginHistoryService.insertLogHistory("sso_user", emplId, clientIp, "성공");

					String returnUrl = httpSession.getAttribute("RETURN_URL") != null ? httpSession.getAttribute("RETURN_URL").toString() : "/message.ibk";
					httpSession.removeAttribute("RETURN_URL");

					return "redirect:" + returnUrl;
				}else{
					logger.info(":::접속 유저("+emplId+")의 정보가 존재하지 않습니다.");
					
					loginHistoryService.insertLogHistory("sso", emplId, clientIp, "접속 유저("+emplId+")의 정보가 존재하지 않습니다.");
					httpSession.setAttribute("errorMsg", "접속 유저("+emplId+")의 정보가 존재하지 않습니다.");
					return "redirect:/motp_login.ibk";
				}
			}
		}

		logger.info(":::SSO에서 조회된 EMPL_ID가 존재하지 않습니다.");
		loginHistoryService.insertLogHistory("sso", emplId, clientIp, "SSO에서 조회된 EMPL_ID("+emplId+")의 정보가 존재하지 않습니다.");
		httpSession.setAttribute("errorMsg", "SSO에서 조회된 EMPL_ID가 존재하지 않습니다.");
		return "redirect:/motp_login.ibk";
	}

	/**
	 * 로그아웃 처리
	 *
	 * @version 2022.05.04
	 */
	@GetMapping("/logout.ibk")
	public String eventLogout(HttpServletRequest request) {
		HttpSession session = request.getSession();

		// 세션 삭제 전 로그인방법 확인
		String loginMethod = (String) session.getAttribute("LOGIN_METHOD");

		// 세션 삭제 (로그아웃)
		session.invalidate();
		request.getSession(true);

		// idpw 로그인했을 경우 idpw 로그인화면으로 이동
		String returnUrl = "redirect:/";
		if("idpw".equals(loginMethod)) returnUrl = "redirect:/login.ibk";

		return returnUrl;
	}
	

}
