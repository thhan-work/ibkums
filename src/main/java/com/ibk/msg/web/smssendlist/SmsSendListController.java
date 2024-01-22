package com.ibk.msg.web.smssendlist;

import java.io.FileNotFoundException;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

import com.google.common.base.Preconditions;
import com.ibk.msg.web.smsreq.SmsReqData;

@Controller
public class SmsSendListController {
	private static final Logger logger = LoggerFactory.getLogger(SmsSendListController.class);

	@Autowired
	private SmsSendListService smssendlistService;

	@GetMapping("/smssendlist.ibk")
	public String viewListJsp() {
		return "smssendlist/smssendlist-list";
	}

	//등록 수정 상세 페이지를 같이 사용 합니다.
	@GetMapping("/smssendlist-detail.ibk")
	public ModelAndView viewDetailJsp(
			@RequestParam(value = "id", required = false) int smssendlistId) {
		ModelAndView mav = new ModelAndView();
		if (smssendlistId > 0) {
			mav = smssendlistService.findDetail(smssendlistId);
		}
		return mav;
	}

	@GetMapping("/smssendlist/{smssendlistId}")
	@ResponseBody
	public Object findDetail(@PathVariable("smssendlistId") int smssendlistId) throws Exception {
		return smssendlistService.findDetail(smssendlistId);
	}

	@GetMapping(value="/smssendlist/fileDoneCheck/{groupUniqNo}")
	@ResponseBody
	public Object fileDoneCheck(@PathVariable("groupUniqNo") int groupUniqNo, HttpSession httpSession) throws Exception {
		return smssendlistService.fileDoneCheck(groupUniqNo);
	}

	@GetMapping("/smssendlist")
	@ResponseBody
	public Object findByPagination(SmsSendListSearchCondition searchCondition, HttpSession httpSession) throws Exception {

		setSmsSendListSearchCondition(httpSession,searchCondition);
		return smssendlistService.findByPagination(searchCondition);
	}

	/*** 취소 ***/
	@DeleteMapping(value = "/smssendlist/delete/{groupUniqNo}")
	@ResponseBody
	public Object remove(@PathVariable("groupUniqNo") int groupUniqNo, HttpSession session) throws Exception {
		return smssendlistService.remove(groupUniqNo);
	}
	@DeleteMapping(value = "/smssendlist/cancel/{groupUniqNo}")
	@ResponseBody
	public Object cancel(@PathVariable("groupUniqNo") int groupUniqNo, HttpSession session) throws Exception {
		return smssendlistService.cancel(groupUniqNo);
	}

	/*** 발송중지 ***/
	@PostMapping(value = "/smssendlist/stopsend/{groupUniqNo}")
	@ResponseBody
	public Object stopSend(@PathVariable("groupUniqNo") int groupUniqNo, HttpSession session) throws Exception {
		return smssendlistService.stopSend(groupUniqNo);
	}

	/*** 발송재개 ***/
	@PostMapping(value = "/smssendlist/restartsend/{groupUniqNo}")
	@ResponseBody
	public Object restartSend(@PathVariable("groupUniqNo") int groupUniqNo, HttpSession session) throws Exception {
		return smssendlistService.restartSend(groupUniqNo);
	}

	/***승인URL 접근***/
	@GetMapping(value="/smssendlist/confirm/{groupUniqNo}/{emplId}")
	@ResponseBody
	public Object confirm(@PathVariable("groupUniqNo") int groupUniqNo, @PathVariable("emplId")String emplId) throws Exception {
		String confirmResult = smssendlistService.confirmUpdate(groupUniqNo, emplId);
		logger.info(":::승인URL 요청 결과 [기안/승인자](결과) :[" + groupUniqNo + "/" + emplId +"](" + confirmResult + ")" );
		return confirmResult;
	}

	/***결재 올리기, 임시저장 ***/
	@PostMapping(value= "/smssendlist/tmpSave", produces ={"application/json"})
	@ResponseBody
	@ResponseStatus(HttpStatus.CREATED)
	public Object tmpSave(@RequestBody SmsSendList smssendlist, HttpSession httpSession) throws Exception {
		setSmsSendList(httpSession, smssendlist);
		try {
			return smssendlistService.tmpSave(smssendlist, httpSession); 
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	/***저장(결재진행중) ***/
	@PostMapping(value= "/smssendlist/save", produces ={"application/json"})
	@ResponseBody
	@ResponseStatus(HttpStatus.CREATED)
	public Object save(@RequestBody SmsSendList smssendlist, HttpSession httpSession) throws Exception {
		setSmsSendList(httpSession, smssendlist);

		try {
			return smssendlistService.save(smssendlist, httpSession);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	/*** 발송승인요청 ***/
	@PostMapping(value="/smssendlist/testSend", produces={"application/json"})
	@ResponseBody
	@ResponseStatus(HttpStatus.OK)
	public Object testSend(@RequestBody SmsSendList smssendlist, HttpSession httpSession) throws Exception {
		setSmsSendList(httpSession, smssendlist);
		return smssendlistService.testSend(smssendlist, httpSession);
	}

	@GetMapping(value="/smssendlist/confirmSelect/{groupUniqNo}")
	@ResponseBody
	public Object confirmSelect(@PathVariable("groupUniqNo") int groupUniqNo, HttpSession httpSession) throws Exception {
		return smssendlistService.confirmSelect(groupUniqNo, httpSession);
	}

	@GetMapping(value="/smssendlist/sendConfirmSelect/{groupUniqNo}")
	@ResponseBody
	public Object sendConfirmSelect(@PathVariable("groupUniqNo") int groupUniqNo, HttpSession httpSession) throws Exception {
		return smssendlistService.sendConfirmSelect(groupUniqNo, httpSession);
	}

	@GetMapping(value="/smssendlist/digitalConfirmSelect/{groupUniqNo}")
	@ResponseBody
	public Object digitalConfirmSelect(@PathVariable("groupUniqNo") int groupUniqNo, HttpSession httpSession) throws Exception {
		return smssendlistService.digitalConfirmSelect(groupUniqNo, httpSession);
	}

	@GetMapping(value="/smssendlist/cmsConfirmSelect/{groupUniqNo}")
	@ResponseBody
	public Object cmsConfirmSelect(@PathVariable("groupUniqNo") int groupUniqNo, HttpSession httpSession) throws Exception {
		return smssendlistService.cmsConfirmSelect(groupUniqNo, httpSession);
	}

	@GetMapping(value="/smssendlist/agreeSelect/{groupUniqNo}")
	@ResponseBody
	public Object agreeSelect(@PathVariable("groupUniqNo") int groupUniqNo, HttpSession httpSession) throws Exception {
		return smssendlistService.agreeSelect(groupUniqNo, httpSession);
	}

	private void setSmsSendListSearchCondition(HttpSession session, SmsSendListSearchCondition searchCondition){

		if(session.getAttribute("EMPL_ID") ==null) {    
			Preconditions.checkArgument(false, "session empl_id is empty");  
		}else {
			searchCondition.setEmplId((String)session.getAttribute("EMPL_ID")); 
		}

		if(session.getAttribute("EMPL_BOCODE")==null) {
		}else {
			searchCondition.setBoCode((String)session.getAttribute("EMPL_BOCODE"));
		}

		if(session.getAttribute("USER_CLASS")==null) {
		}else {
			searchCondition.setUserClass((String)session.getAttribute("USER_CLASS"));
		}
	}

	private void setSmsSendList(HttpSession session, SmsSendList smssendlist){

		if(session.getAttribute("EMPL_ID") ==null) {    
			Preconditions.checkArgument(false, "session empl_id is empty");  
		}else {
			smssendlist.setEmplId((String)session.getAttribute("EMPL_ID")); 
		}

		if(session.getAttribute("EMPL_BOCODE")==null) {
		}else {
			smssendlist.setBoCode((String)session.getAttribute("EMPL_BOCODE"));
		}
	}

}






