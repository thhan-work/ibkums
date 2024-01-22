package com.ibk.msg.web.reservedmessage;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.base.Preconditions;

@Controller
public class ReservedMessageController {

  @Autowired
  private ReservedMessageService reservedmessageService;

  @GetMapping("/reservedmessage.ibk")
  public String viewListJsp() {
    return "reservedmessage/reservedmessage-list";
  }

  @GetMapping("/reservedmessage")
  @ResponseBody
  public Object findByPagination(ReservedMessageSearchCondition searchCondition, HttpSession httpSession) throws Exception {
	  setReservedMessageSearchCondition(httpSession, searchCondition);
	  return reservedmessageService.findByPagination(searchCondition);
  }
 
  @DeleteMapping(value = "/reservedmessage/cancel", produces = {"application/json"})
  @ResponseBody
  public Object cancel(@RequestBody List<ReservedMessage> reservedmessageList, HttpSession httpSession) throws Exception {
	  setReservedMessageSearchCondition(httpSession, reservedmessageList);
	  return reservedmessageService.cancel(reservedmessageList);
  }
  
  private void setReservedMessageSearchCondition(HttpSession session, ReservedMessageSearchCondition searchCondition){
	  if(session.getAttribute("EMPL_ID") ==null) {    
		  Preconditions.checkArgument(false, "session empl_id is empty");  
	  }else {
		  searchCondition.setEmplId((String)session.getAttribute("EMPL_ID")); 
	  }
	  if(session.getAttribute("EMPL_BOCODE")==null) {
	  }else {
		  searchCondition.setBoCode((String)session.getAttribute("EMPL_BOCODE"));
	  }
	  if(session.getAttribute("IP") == null) {
		  Preconditions.checkArgument(false, "session ip is empty");  
	  }else {
		  searchCondition.setEmplIp((String)session.getAttribute("IP"));
	  }
  }
  
  private void setReservedMessageSearchCondition(HttpSession session, List<ReservedMessage> reservedmessageList){
	  for(ReservedMessage reservedmessage : reservedmessageList){
		  if(session.getAttribute("EMPL_ID") ==null) {    
			  Preconditions.checkArgument(false, "session empl_id is empty");  
		  }else {
			  reservedmessage.setEmplId((String)session.getAttribute("EMPL_ID")); 
		  }
		  if(session.getAttribute("EMPL_BOCODE")==null) {
		  }else {
			  reservedmessage.setBoCode((String)session.getAttribute("EMPL_BOCODE"));
		  }
	  }
   }
}
