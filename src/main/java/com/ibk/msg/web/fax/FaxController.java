package com.ibk.msg.web.fax;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.base.Preconditions;

@Controller
public class FaxController {
  private static final Logger logger = LoggerFactory.getLogger(FaxController.class);

  @Autowired
  private FaxService faxService;
  
  @GetMapping("/fax/search.ibk")
  public String viewSearchJsp(HttpSession httpSession) {
	  // 로그인 권한 체크 (session 만료 검사)
//	  if(httpSession.getAttribute("LOGIN_OK") == null || httpSession.getAttribute("USER_CLASS") == null || !httpSession.getAttribute("USER_CLASS").equals("M")){
//		  return "allmessage/login";  
//	  }
	  
	  return "fax/fax-list";
  }
  
  @GetMapping("/fax")
  @ResponseBody
  public Object findByPagination(FaxSearchCondition searchCondition, HttpSession httpSession) throws Exception {
	  
	setMyMessageSearchCondition(httpSession,searchCondition);
    return faxService.findByPagination(searchCondition);
  }
  
  
  private void setMyMessageSearchCondition(HttpSession session, FaxSearchCondition searchCondition){
	  
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

  
	  
  
  
  
