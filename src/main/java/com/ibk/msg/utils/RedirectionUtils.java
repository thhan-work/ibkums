package com.ibk.msg.utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;

public class RedirectionUtils {
	
	private RedirectionUtils() {}
	
	public static String getMainPage(HttpServletRequest request, String def) {
		return getMainPage(request.getSession(), def);
	}
	
	public static String getMainPage(HttpSession session, String def) {
		
		Object objEmplClass = session.getAttribute("USER_CLASS");
		Object objEmplId = session.getAttribute("EMPL_ID");
		Object objLoginMethod = session.getAttribute("LOGIN_METHOD");
		
		if (objEmplClass == null || objEmplId == null || objLoginMethod == null) {
			return def;
		}
		
		String emplId = objEmplId.toString();

		/* 202205 v1
		if (loginMethod.equals("idpw")) {
			String returnUrl = session.getAttribute("RETURN_URL") != null ? session.getAttribute("RETURN_URL").toString() : "/eventsend.ibk";
	    	session.removeAttribute("RETURN_URL");
			return "redirect:" + returnUrl;
		}
		
		if(StringUtils.isNotBlank(emplId)){	// 세션 존재여부 확인
			String returnUrl = session.getAttribute("RETURN_URL") != null ? session.getAttribute("RETURN_URL").toString() : "/message.ibk";
	    	session.removeAttribute("RETURN_URL");
			return "redirect:" + returnUrl;
		}
		*/

		// 202205 v2 메인페이지 대량문자 > 예약현황
		if(StringUtils.isNotBlank(emplId)) {
			String returnUrl = session.getAttribute("RETURN_URL") != null ? session.getAttribute("RETURN_URL").toString() : "/campaign/reservationStatus.ibk";
			session.removeAttribute("RETURN_URL");
			return "redirect:" + returnUrl;
		}

	return def;
	}
}
