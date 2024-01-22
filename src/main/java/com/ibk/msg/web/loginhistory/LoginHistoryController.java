package com.ibk.msg.web.loginhistory;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class LoginHistoryController {

	private static final Logger logger = LoggerFactory.getLogger(LoginHistoryController.class);
	
	@Autowired
	private LoginHistoryService loginHistoryService;
	
	@GetMapping("/admin/login-history.ibk")
	public String loginHisotry() {
		return "login-history/login-history-list";
	}
	
	@GetMapping("/admin/login-history-list")
	@ResponseBody
	public Object findByPagination(LoginHistorySearchCondition searchCondition) throws Exception {
		return loginHistoryService.findByPagination(searchCondition);
	}
}
