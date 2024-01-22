package com.ibk.msg.web.confirmlist;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

import com.google.common.base.Preconditions;
import com.ibk.msg.web.smsreq.SmsReqController;
import com.ibk.msg.web.smsreq.SmsReqData;
import com.ibk.msg.web.smsreq.T32Data;

@Controller
public class ConfirmListController {
	private static final Logger logger = LoggerFactory.getLogger(ConfirmListController.class);

  @Autowired
  private ConfirmListService confirmListService;

  @GetMapping("/confirmlist.ibk")
  public String viewListJsp() {
    return "confirmlist/confirmlist-list";
  }
  
  
 //등록 수정 상세 페이지를 같이 사용 합니다.
 @GetMapping("/confirmlist-detail.ibk")
 public ModelAndView viewDetailJsp(@RequestParam(value = "groupUniqNo", required = false) String groupUniqNo
		 , @RequestParam(value = "agreeType", required = false) String agreeType
		 	,@RequestParam(value = "agreeStatus", required = false) String agreeStatus
		 		,@RequestParam(value = "agreeId", required = false) String agreeId
		 			, HttpSession session) {
	 
	 logger.info("###groupUniqNo="+groupUniqNo);	// 그룹 고유 번호
	 logger.info("###agreeType="+agreeType);		// 승인 등급 (1, 2, 3, 4)
	 logger.info("###agreeStatus="+agreeStatus);	// 승인 상태 (I(승인대기), G(승인완료), N(반려))
	 logger.info("###agreeId="+agreeId);	// 승인자 ID
	 
	 Preconditions.checkArgument(StringUtils.isNoneBlank(groupUniqNo), "groupUniqNo is empty");
	 Preconditions.checkArgument(StringUtils.isNoneBlank(agreeType), "agreeType is empty");
	 Preconditions.checkArgument(StringUtils.isNoneBlank(agreeStatus), "agreeStatus is empty");
	 
	 ModelAndView mav = confirmListService.findDetail(groupUniqNo, agreeType, agreeStatus, agreeId, session);

	 return mav;
 }

 // 결재내역 리스트 조회
  @GetMapping("/confirmlist")
  @ResponseBody
  public Object findByPagination(ConfirmListSearchCondition searchCondition, HttpSession httpSession) throws Exception {
	  
	setSearchCondition(httpSession, searchCondition);
    return confirmListService.findByPagination(searchCondition);
  }
  

// 결재내역 디테일 승인자 정보 조회
  @PostMapping(value = "/confirmlist/agreeList", produces = {"application/json"})
  @ResponseBody
  public Object findByPagination(@RequestBody Map<String, Object> param, HttpSession httpSession) throws Exception {
	  logger.info("#######TEST START "+param.get("groupUniqNo").toString());
	  String groupUniqNo = param.get("groupUniqNo").toString();
	  
	  return confirmListService.findAgreeList(groupUniqNo);
  }
  
// 결재내역 반려
  @PostMapping("/confirmlist/reject")
  @ResponseBody
  public Object reject(@RequestBody ConfirmListSearchCondition condition, HttpSession session) {
	  logger.info("##REJECT / ConfirmListSearchCondition="+condition.toString());
	  setSearchCondition(session, condition);
	  
	  confirmListService.reject(condition);
	  
	  return null;
  }

//결재내역 승인
 @PostMapping("/confirmlist/accept")
 @ResponseBody
 public Object accept(@RequestBody ConfirmListSearchCondition condition, HttpSession session) {
	  logger.info("##ACCEPT / ConfirmListSearchCondition="+condition.toString());
	  setSearchCondition(session, condition);

	  confirmListService.accept(condition);
	  
	  return null;
 }
 
//결재내역 저장 후 승인
@PostMapping("/confirmlist/saveAccept/{agreeType}/{agreeId}")
@ResponseBody
public Object saveAccept(@PathVariable("agreeType") String agreeType, @PathVariable("agreeId") String agreeId, @RequestBody SmsReqData smsReqData, HttpSession session) {
	  logger.info("##SAVE ACCEPT / SmsReqData="+smsReqData.toString() +" / AgreeType=" + agreeType );
	  setSearchCondition(session, smsReqData);
	  
	  try {
		  confirmListService.saveAccept(smsReqData, agreeType, agreeId);
	  } catch (FileNotFoundException e) {
		  e.printStackTrace();
		  return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	  }
	  
	  return null;
}
  //업무 포탈 연동 승인건수 전달
	@GetMapping("/portal/check")
	public void totalCntConfirm(
	  @RequestParam(value = "empno", required = true) String empno,
	  							HttpServletRequest request, HttpServletResponse response) {
		//empno로 결제건수 가져오기
		int comfirmCnt=confirmListService.totalCntConfirm(empno);;
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Content-Type", "text/html; charset=UTF-8");
		String msg="callbackFunction({\"ReturnValue\":\"Cnt_CMC#"+comfirmCnt+"\"});";
		PrintWriter out=null;
		try {
			out = response.getWriter();
			out.println(msg); 
			out.close();
		}catch(IOException ex) {
			ex.printStackTrace();
		}finally {
			if(out !=null) {
				out.close();
				out=null;
			}
		}

	}

  private void setSearchCondition(HttpSession session, Object obj){
	  
	  if(obj instanceof ConfirmListSearchCondition){
		  ConfirmListSearchCondition changObj = (ConfirmListSearchCondition) obj;
		  if(session.getAttribute("EMPL_ID") ==null) {    
			  Preconditions.checkArgument(false, "session empl_id is empty");  
		  }else {
			  changObj.setEmplId((String)session.getAttribute("EMPL_ID")); 
		  }
		  
		  if(session.getAttribute("EMPL_BOCODE")==null) {
		  }else {
			  changObj.setBoCode((String)session.getAttribute("EMPL_BOCODE"));
		  }
		  
		  if(session.getAttribute("USER_CLASS")==null) {
		  }else {
			  changObj.setUserClass((String)session.getAttribute("USER_CLASS"));
		  }
  	  }else if(obj instanceof SmsReqData)
	  {
		  SmsReqData changObj = (SmsReqData) obj;
		  if(session.getAttribute("EMPL_ID") ==null) {
		  	Preconditions.checkArgument(false, "session empl_id is empty");  
		  }else {
		  	changObj.setEmplId((String)session.getAttribute("EMPL_ID")); 
		  }
		  
		  if(session.getAttribute("EMPL_BOCODE")==null) {
		  	  //Preconditions.checkArgument(false, "session empl_bocode is empty");
		  }else {
		  	changObj.setBoCode((String)session.getAttribute("EMPL_BOCODE"));
		  } 
	  }
  }
  
}

  
	  
  
  
  
