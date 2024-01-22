package com.ibk.msg.config.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ibk.msg.utils.IPUtils;
import com.ibk.msg.web.auth.EmployeeService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AllMSGCheckInterceptor extends HandlerInterceptorAdapter {

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
		String sessionIp = (String) session.getAttribute("IP");
		String requestIp = IPUtils.getClientIp(request);

		log.info("[SES] Session IP >>> {}", sessionIp);
		log.info("[REQ] Request IP >>> {}", requestIp);


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
		log.info("AllMSGCheckInterceptor");
		log.info("Interceptor > postHandle");

		HttpSession session = request.getSession();
		String emplId = (String) session.getAttribute("EMPL_ID");
		String userClass = (String) session.getAttribute("USER_CLASS");

		if(StringUtils.isNotBlank(emplId)){	// 세션 존재여부 확인

		}else{
			log.info("[WARN] URL 직접입력 접속!!");
			String url = request.getRequestURI().replace(request.getContextPath(), "");
			session.setAttribute("RETURN_URL", url);
			response.sendRedirect(request.getContextPath()+"/allmessageSSO.ibk");
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
