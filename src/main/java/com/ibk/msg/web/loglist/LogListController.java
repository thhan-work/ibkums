package com.ibk.msg.web.loglist;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.base.Preconditions;

@Controller
public class LogListController {
//  private static final Logger logger = LoggerFactory.getLogger(SmsSendListController.class);

  @Autowired
  private LogListService loglistService;

  @GetMapping("/admin/loglist.ibk")
  public String viewListJsp() {
    return "loglist/loglist-list";
  }
  
  @GetMapping("/loglist")
  @ResponseBody
  public Object findByPagination(LogListSearchCondition searchCondition, HttpSession httpSession) throws Exception {
	  
	setMyMessageSearchCondition(httpSession,searchCondition);
    return loglistService.findByPagination(searchCondition);
  }
  
  private void setMyMessageSearchCondition(HttpSession session, LogListSearchCondition searchCondition){
	  
	  if(session.getAttribute("EMPL_ID") ==null) {    
		  Preconditions.checkArgument(false, "session empl_id is empty");  
	  }else {
		  searchCondition.setEmplId((String)session.getAttribute("EMPL_ID")); 
	  }
	  
	  if(session.getAttribute("EMPL_BOCODE")==null) {
	  }else {
		  searchCondition.setBoCode((String)session.getAttribute("EMPL_BOCODE"));
	  }
  }
  
}

  
	  
  
  
  
