package com.ibk.msg.config.web;

import com.ibk.msg.utils.IPUtils;
import com.ibk.msg.web.auth.EmployeeService;
import com.ibk.msg.web.auth.LoginResult;
import com.ibk.msg.web.user.UserInfo;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.util.Enumeration;

@Slf4j
public class IpCheckInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	private EmployeeService employeeService;


	/**
	 * PreHandle(HttpServletRequest request, HttpServletResponse response, Object handler) 컨트롤러(즉
	 * RequestMapping이 선언된 메서드 진입) 실행 직전에 동작. 반환 값이 true일 경우 정상적으로 진행이 되고, false일 경우 실행이 멈춥니다.(컨트롤러
	 * 진입을 하지 않음) 전달인자 중 Object handler는 핸들러 매핑이 찾은 컨트롤러 클래스 객체입니다.
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		session.setMaxInactiveInterval(86400);
		
		String sessionIp = (String) session.getAttribute("IP");
		String requestIp = IPUtils.getClientIp(request);

		log.info("[SES] Session IP >>> {}", sessionIp);
		log.info("[REQ] Request IP >>> {}", requestIp);
		log.info("getRequestURI {}", request.getRequestURI());
		log.info("getRequestURL {}", request.getRequestURL());

		String emplId = (String) session.getAttribute("EMPL_ID");
		String userClass = (String) session.getAttribute("USER_CLASS");
		if (session.getAttribute("PW_CN_DT") != null) {
			if (!request.getRequestURI().startsWith(request.getContextPath()+"/forcechangepassword.ibk")) {
				response.sendRedirect(request.getContextPath()+"/forcechangepassword.ibk");
				return false;
			}
		}

		if(StringUtils.isBlank(emplId)){	// 세션 존재여부 확인
			StringBuilder queryString = new StringBuilder();
			Enumeration<String> parameterNames = request.getParameterNames();
			while(parameterNames.hasMoreElements()) {
				String parameterName = parameterNames.nextElement();
				if (parameterName.equals("telno")) {
					// TODO : 암호화 처리 encTelNo
					StandardPBEStringEncryptor jasypt = new StandardPBEStringEncryptor();
					jasypt.setPassword("ibk");      //암호화 키(password)
					jasypt.setAlgorithm("PBEWithMD5AndDES");
					String encryptedText = jasypt.encrypt(request.getParameter(parameterName));    //암호화
					
					log.info("encryptedText : {}", encryptedText);

					queryString.append("encTelNo")
					.append("=")
					.append(URLEncoder.encode(encryptedText));
				} else {
					queryString.append(parameterName)
					.append("=")
					.append(request.getParameter(parameterName));
				}
				
//				URLEncoder.encode(request.getParameter(parameterName));
				if (parameterNames.hasMoreElements()) {
					queryString.append("&");
				}
			}
			session.setAttribute("RETURN_URL", request.getRequestURI() + "?" + queryString.toString());
			response.sendRedirect(request.getContextPath()+"/");
			return false;
		}


		//    Enumeration names = request.getHeaderNames();
		//    while (names.hasMoreElements()) {
		//      String name = (String) names.nextElement();
		//      Enumeration values = request.getHeaders(name);  // support multiple values
		//      if (values != null) {
		//        while (values.hasMoreElements()) {
		//          String value = (String) values.nextElement();
		//          log.info(name + ": " + value);
		//        }
		//      }
		//    }

		if (StringUtils.isBlank(sessionIp)) {
			session.setAttribute("IP", requestIp);
			return true;
		} else {
			if (!StringUtils.equals(sessionIp, requestIp)) {
				// TODO : 어떤 페이지로 이동 시킬지 정해지면 변경이 필요 합니다.
				log.debug("sessionIp / requestIp MISMATCH!!!!!!! >>>> {}", sessionIp +":" + requestIp);
				response.setStatus(400);
				response.sendRedirect(request.getContextPath()+"/error/400");
				session.invalidate();
				return false;
			}
		}
		return true;
	}


	/**
	 * PostHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
	 * ModelAndView modelAndView) 컨트롤러 진입 후 view가 랜더링 되기 전 수행이 됩니다. 전달인자의 modelAndView을 통해 화면 단에 들어가는
	 * 데이터 등의 조작이 가능합니다.
	 */
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

		HttpSession session = request.getSession();
		String emplId = (String) session.getAttribute("EMPL_ID");
		String userClass = (String) session.getAttribute("USER_CLASS");

		if(StringUtils.isNotBlank(emplId)){	// 세션 존재여부 확인
			LoginResult checkUserInfo = employeeService.checkUserInfo(session, request);
			String selectClass = checkUserInfo.getUserClass();
			log.info("[SES] USERCLASS >>> {}", userClass);
			log.info("[SEL] SELECTCLASS >>> {}", selectClass);
			if (!userClass.equals(selectClass)) {
				session.setAttribute("USER_CLASS", selectClass);
			}

			if(session.getAttribute("USER_CLASS")==null||session.getAttribute("USER_CLASS").toString().indexOf("A") == -1) {
				log.info("[CNG] CHANGECLASS >>> {}", selectClass);
				session.setAttribute("USER_CLASS", selectClass);
			}
			if(session.getAttribute("USER_CLASS")==null||(session.getAttribute("USER_CLASS").toString().indexOf("A") == -1&&
					session.getAttribute("USER_CLASS").toString().indexOf("N") == -1&&session.getAttribute("USER_CLASS").toString().indexOf("P") == -1&&
					session.getAttribute("USER_CLASS").toString().indexOf("S") == -1)){
				log.info("--------------------------");
				response.setStatus(403);
				response.sendRedirect(request.getContextPath()+"/error/403");
			}
			if(request.getRequestURI().indexOf(request.getContextPath()+"/admin/") != -1){
				if(session.getAttribute("USER_CLASS").toString().indexOf("A") == -1){
					response.setStatus(403);
					response.sendRedirect(request.getContextPath()+"/error/403");
				}
			}else if(request.getRequestURI().indexOf(request.getContextPath()+"/emplsms/") != -1){
				if(session.getAttribute("USER_CLASS").toString().indexOf("A") == -1 && session.getAttribute("USER_CLASS").toString().indexOf("S") == -1){
					response.setStatus(403);
					response.sendRedirect(request.getContextPath()+"/error/403");
				}
			}

			// 정적 리소스은 null일 수 있음
			if(modelAndView != null) {
				// 220523 v2 로그인 사용자 정보 모델 세팅(상단 사용자 정보 표시용)
				UserInfo headerInfo = new UserInfo();
				headerInfo.setEmplId(emplId); // 사용자ID
				headerInfo.setUserLevel(userClass); // 사용자권한(=EMPL_LEVEL, userClass)
				headerInfo.setBoCode((String) session.getAttribute("EMPL_BOCODE")); // 부서코드
				headerInfo.setPartName((String) session.getAttribute("EMPL_BONAME")); // 부서명
				headerInfo.setEmplName((String) session.getAttribute("EMPL_NAME")); // 사용자명

				modelAndView.addObject("headerInfo", headerInfo);
			}
		}else{
			log.info("[WARN] URL 직접입력 접속!!");
			String url = request.getRequestURI().replace(request.getContextPath(), "");
			session.setAttribute("RETURN_URL", url);
			response.sendRedirect(request.getContextPath());
		}
	}
	/**
	 * afterComplete(HttpServletRequest request, HttpServletResponse response, Object handler,
	 * Exception ex) 컨트롤러 진입 후 view가 정상적으로 랜더링 된 후 제일 마지막에 실행이 되는 메서드입니다.
	 */
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response,
			Object object, Exception arg3) throws Exception {
		log.info("request path : {}", request.getRequestURI());
		log.info("request method : {}", request.getMethod());
		log.info("response status : {}", response.getStatus());
	}

}
