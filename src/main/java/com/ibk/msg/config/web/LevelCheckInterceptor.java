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
import com.ibk.msg.web.auth.LoginResult;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LevelCheckInterceptor extends HandlerInterceptorAdapter {

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
		log.info("getRequestURI {}", request.getRequestURI());
		log.info("getRequestURL {}", request.getRequestURL());

		Object objUserClass = session.getAttribute("USER_CLASS");
		if (objUserClass == null) {
			session.setAttribute("RETURN_URL", request.getRequestURI());
			response.sendRedirect(request.getContextPath()+"/");
			return false;
		}
		String userClass = (String) objUserClass;
		
		if (userClass == "A" || userClass.equals("A")) {
			return true;
		} else {
			log.info("userClass {}", userClass);
			response.sendRedirect(request.getContextPath()+"/forbidden/not_available.ibk");
			session.invalidate();
			return false;
		}
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response,
			Object object, Exception arg3) throws Exception {
		log.info("request path : {}", request.getRequestURI());
		log.info("request method : {}", request.getMethod());
		log.info("response status : {}", response.getStatus());
	}

}
