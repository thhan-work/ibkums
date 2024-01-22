package com.ibk.msg.web.asis;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AsIsController {

	@GetMapping("/statistics/sfLog.ibk")
	public String sfLog(HttpSession session, HttpServletRequest request) {
		String cmd = request.getParameter("cmd");

		Object objEmplClass = session.getAttribute("USER_CLASS");
		Object objEmplId = session.getAttribute("EMPL_ID");
		Object objLoginMethod = session.getAttribute("LOGIN_METHOD");

		if (objEmplClass == null || objEmplId == null || objLoginMethod == null) {
			if (cmd != null && (cmd.equalsIgnoreCase("msf") || cmd.equalsIgnoreCase("mmf"))) {
				session.setAttribute("RETURN_URL", "/allmessage.ibk");
			}

			if (cmd != null && cmd.equalsIgnoreCase("f_log")) {
				session.setAttribute("RETURN_URL", "/fax/search.ibk");
			}
			session.setAttribute("RETURN_URL", "/allmessage.ibk");
		}
		if (cmd != null && (cmd.equalsIgnoreCase("msf") || cmd.equalsIgnoreCase("mmf"))) {
			return "redirect:/allmessage.ibk";
		}

		if (cmd != null && cmd.equalsIgnoreCase("f_log")) {
			return "redirect:/fax/search.ibk";
		}

		return "redirect:/allmessage.ibk";
	}

	@GetMapping("/statistics/mLog.ibk")
	public String mLog(HttpSession session, HttpServletRequest request) {
		String cmd = request.getParameter("cmd");

		Object objEmplClass = session.getAttribute("USER_CLASS");
		Object objEmplId = session.getAttribute("EMPL_ID");
		Object objLoginMethod = session.getAttribute("LOGIN_METHOD");

		if (objEmplClass == null || objEmplId == null || objLoginMethod == null) {
			if (cmd != null && cmd.equalsIgnoreCase("m_log")) {
				session.setAttribute("RETURN_URL", "/email/search.ibk");
			}
			session.setAttribute("RETURN_URL", "/email/search.ibk");
		}
		if (cmd != null && cmd.equalsIgnoreCase("m_log")) {
			return "redirect:/email/search.ibk";
		}

		return "redirect:/email/search.ibk";
	}
}
