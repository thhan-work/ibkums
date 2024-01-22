package com.ibk.msg.web.mymessage;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.google.common.base.Preconditions;
import com.ibk.msg.web.message.model.MessageDto;

@Controller
public class MyMessageController {
  private static final Logger logger = LoggerFactory.getLogger(MyMessageController.class);

  @Autowired
  private MyMessageService mymessageService;

  @GetMapping("/mymessage.ibk")
  public String viewListJsp() {
    return "mymessage/mymessage-list";
  }

  @GetMapping("/mymessage")
  @ResponseBody
  public Object findByPagination(MyMessageSearchCondition searchCondition, HttpSession httpSession) throws Exception {
	  
	setMyMessageSearchCondition(httpSession,searchCondition);
    return mymessageService.findByPagination(searchCondition);
  }

  @DeleteMapping(value = "/mymessage/delete", produces = {"application/json"})
  @ResponseBody
  public Object remove(@RequestBody List<MyMessage> mymessageList, HttpSession session) throws Exception {
	  
    return mymessageService.remove(mymessageList);
  }
  
  @PutMapping(value = "/mymessage/resend", produces = {"application/json"})
  @ResponseBody
  @ResponseStatus(HttpStatus.CREATED)
  public Object resend(@RequestBody List<MyMessage> mymessageList, HttpSession session) throws Exception {
	  
	  setMyMessageCondition(session, mymessageList);
	  return mymessageService.resend(mymessageList, session);
  }
  
  
  private void setMyMessageSearchCondition(HttpSession session, MyMessageSearchCondition searchCondition){
	  
	  if(session.getAttribute("EMPL_ID") ==null) {    
		  Preconditions.checkArgument(false, "session empl_id is empty");  
	  }else {
		  searchCondition.setEmplId((String)session.getAttribute("EMPL_ID")); 
	  }
	  
	  if(session.getAttribute("EMPL_BOCODE")==null) {
	  }else {
		  searchCondition.setBoCode((String)session.getAttribute("EMPL_BOCODE"));
	  }
	  
	  if(session.getAttribute("USER_CLASS") == null) {
		  Preconditions.checkArgument(false, "session empl_bocode is empty");  
	  }else {
		  searchCondition.setUserClass((String)session.getAttribute("USER_CLASS"));
	  }
	  
	  if(session.getAttribute("IP") == null) {
		  Preconditions.checkArgument(false, "session ip is empty");  
	  }else {
		  searchCondition.setEmplIp((String)session.getAttribute("IP"));
	  }
  }
  
  
  private void setMyMessageCondition(HttpSession session, List<MyMessage> mymessageList){
	  
	  for(MyMessage messagedto : mymessageList){
		  
		  if(session.getAttribute("EMPL_ID") == null) {    
			  Preconditions.checkArgument(false, "session empl_id is empty");  
		  }else {
			  messagedto.setEmplId((String)session.getAttribute("EMPL_ID")); 
		  }
		  
		  if(session.getAttribute("EMPL_BOCODE") == null) {
			  Preconditions.checkArgument(false, "session empl_bocode is empty");  
		  }else {
			  messagedto.setBoCode((String)session.getAttribute("EMPL_BOCODE"));
		  }
		  
	  }
	  
  }
  
}

  
	  
  
  
  
