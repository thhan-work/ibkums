package com.ibk.msg.web.email;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.base.Preconditions;
import com.ibk.msg.web.allmessage.AllMessage;

@Controller
public class EmailController {
  private static final Logger logger = LoggerFactory.getLogger(EmailController.class);

  @Autowired
  private EmailService emailService;
  
  @GetMapping("/email/search.ibk")
  public String viewSearchJsp(HttpSession httpSession) {
	  // 로그인 권한 체크 (session 만료 검사)
//	  if(httpSession.getAttribute("LOGIN_OK") == null || httpSession.getAttribute("USER_CLASS") == null || !httpSession.getAttribute("USER_CLASS").equals("M")){
//		  return "allmessage/login";  
//	  }
	  
	  return "email/email-list";
  }
  
  @GetMapping("/email/{type}")
  @ResponseBody
  public Object findByPagination(@PathVariable("type") String type, EmailSearchCondition searchCondition, HttpSession httpSession) throws Exception {
	  
	setMyMessageSearchCondition(httpSession,searchCondition);
	searchCondition.setEmailType(type);
    return emailService.findByPagination(searchCondition);
  }
  
  @PutMapping(value = "/email", produces = {"application/json"})
  @ResponseBody
  public Object modify(@RequestBody Email email, HttpSession httpSession) throws Exception {
    return emailService.modify(email);
  }
  
  
  private void setMyMessageSearchCondition(HttpSession session, EmailSearchCondition searchCondition){
	  
	  if(session.getAttribute("EMPL_ID") ==null) {    
		  Preconditions.checkArgument(false, "session empl_id is empty");  
	  }else {
		  searchCondition.setEmplId((String)session.getAttribute("EMPL_ID")); 
	  }
	  
	  if(session.getAttribute("EMPL_BOCODE")==null) {
	  }else {
		  searchCondition.setBoCode((String)session.getAttribute("EMPL_BOCODE"));
	  }

	  if(session.getAttribute("IP")==null) {
	  }else {
		  searchCondition.setEmplIp((String)session.getAttribute("IP"));
	  }
  }
  
}

  
	  
  
  
  
