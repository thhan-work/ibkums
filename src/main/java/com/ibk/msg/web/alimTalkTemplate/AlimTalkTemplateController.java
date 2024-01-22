package com.ibk.msg.web.alimTalkTemplate;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.base.Preconditions;

import java.util.Map;

import javax.servlet.http.HttpSession;

@Slf4j
@RequestMapping(value = "/campaign")
@Controller
public class AlimTalkTemplateController {
	private static final Logger logger = LoggerFactory.getLogger(AlimTalkTemplateController.class);
	
	@Autowired
	AlimTalkTemplateService service;

	@GetMapping("/alimTalkTemplate.ibk")
	public String temaplte2(HttpSession httpSession, Model model) {
		return "campaign/alimTalkTemplate/alimTalk-list";
	}
	
	
	/**
	 * 알림톡 Template 조회
	 * @param searchCondition
	 * @param httpSession
	 * @return
	 * @throws Exception
	 */
	@GetMapping(value = "/alimTalkTemplate/list")
	@ResponseBody
	public Object findByPagination(AlimTalkTemplateSearchCondition searchCondition, HttpSession httpSession) throws Exception {
		
		return service.findRcsTemplateByPagination(searchCondition);
		
	}
	
	/** 알림톡 Template 저장 (등록/수정)
	 * @param alimtalkTemplate
	 * @param httpSession
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value = "/alimTalkTemplate/save" , produces = "application/json")
	@ResponseBody
	public Integer saveAlimTalkTemplate(AlimTalkTemplate alimtalkTemplate, HttpSession httpSession) throws Exception {
		setSearchCondition(httpSession, alimtalkTemplate);
		
		return service.saveAlimTalkTemplate(alimtalkTemplate);
	}
	
	/**
	 * 알림톡 Template 삭제
	 * @param requestData
	 * @param httpSession
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value = "/alimTalkTemplate/remove" , produces = "application/json")
	@ResponseBody
	public Object removeAlimTalkTemplate(@RequestBody Map<String, Object> requestData, HttpSession httpSession) throws Exception {
		AlimTalkTemplate template = new AlimTalkTemplate();
		setSearchCondition(httpSession, template);
		template.setKkoTmplCd((String) requestData.get("kkoTmplCd"));
		template.setApprResult((String) requestData.get("apprResult") );
		template.setUpdtUserId( template.getEmplId() );
		
		return service.deleteAlimTalkTemplate(template);
	}
	
	/**
	 * 알림톡 Template 승인요청
	 * @param requestData
	 * @param httpSession
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value = "/alimTalkTemplate/approval", produces = "application/json")
	@ResponseBody
	public Integer approvalAlimTalkTemplate(@RequestBody Map<String, Object> requestData, HttpSession httpSession) throws Exception {
		AlimTalkTemplate template = new AlimTalkTemplate();
		setSearchCondition(httpSession, template);
		template.setApprReqUserId( template.getEmplId()  ); // EMPL_ID
		template.setKkoTmplCd((String) requestData.get("kkoTmplCd"));
		return service.approvalAlimTalkTemplate(template);
	}
	
	private void setSearchCondition(HttpSession session, Object obj){

		if(obj instanceof AlimTalkTemplateSearchCondition) {
			AlimTalkTemplateSearchCondition chgObj = (AlimTalkTemplateSearchCondition) obj;
			
			if(session.getAttribute("EMPL_ID") == null) {    
				Preconditions.checkArgument(false, "session empl_id is empty");  
			}else {
				chgObj.setEmplId((String)session.getAttribute("EMPL_ID")); 
			}
		} else if(obj instanceof AlimTalkTemplate) {
			AlimTalkTemplate chgObj = (AlimTalkTemplate) obj;
			if(session.getAttribute("EMPL_ID") ==null) {    
				Preconditions.checkArgument(false, "session empl_id is empty");  
			}else {
				chgObj.setEmplId((String)session.getAttribute("EMPL_ID")); 
			}
		}
	}
	
}
