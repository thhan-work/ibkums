package com.ibk.msg.web.rcsBrand;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.base.Preconditions;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping(value = "/campaign")
@Controller
public class RcsBrandController {

	private static final Logger logger = LoggerFactory.getLogger(RcsBrandController.class);
	
	@Autowired
	RcsBrandService service;
	
	@GetMapping("/rcsBrand.ibk")
	public String viewListJsp() {
		return "campaign/rcsBrand/rcsBrand-list";
	}
	
	/**
	 * RCS Brand 조회
	 * 
	 * @param searchCondition
	 * @param httpSession
	 * @return
	 * @throws Exception
	 */
	@GetMapping(value = "/rcsBrand/list")
	@ResponseBody
	public Object findByPagination(RcsBrandSearchCondition searchCondition, HttpSession httpSession) throws Exception {
		return service.findRcsBrandByPagination(searchCondition);
	}
	
	/**
	 * RCS Brand 저장(등록,수정)
	 * 
	 * @param rcsBrand
	 * @param httpSession
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value = "/rcsBrand/save" , produces = "application/json")
	@ResponseBody
	public Object saveRcsTemplate(RcsBrand rcsTemplate, HttpSession httpSession) throws Exception {
		return service.saveRcsBrand(rcsTemplate);
		
	}
	
	/** RCS Brand 삭제
	 * @param requestData
	 * @param httpSession
	 * @return
	 * @throws Exception
	 */
	@DeleteMapping(value = "/rcsBrand/remove")
	@ResponseBody
	public Object removeRcsTemplate(@RequestParam(value = "brId") String brId, HttpSession httpSession) throws Exception {
		RcsBrand rcsBrand = new RcsBrand();
		rcsBrand.setBrId(brId);
		
		return service.removeRcsBrand(rcsBrand);
	}
	
	/**
	 * RCS 챗봇(발신번호) 조회
	 * @param searchCondition
	 * @param httpSession
	 * @return
	 * @throws Exception
	 */
	@GetMapping(value = "/rcsBrand/chatbot")
	@ResponseBody
	public Object findByChatbotPagination(RcsBrandSearchCondition searchCondition, HttpSession httpSession) throws Exception {
		return service.findRcsBrandChatbotByPagination(searchCondition);
	}
	
	/**
	 * RCS 챗봇(발신번호) 저장(추가,삭제)
	 * @param searchCondition
	 * @param httpSession
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value = "/rcsBrand/saveChatbot")
	@ResponseBody
	public Object saveRcsBrandChatbot(RcsBrandChatbot param, HttpSession httpSession) throws Exception {
		
		setSearchCondition(httpSession, param);
		param.setRegUserId( param.getEmplId() );
		
		return service.saveRcsBrandChatbot(param);
	}
	
	/**
	 * 챗봇(발신번호) 삭제
	 * @param brId 브랜드ID
	 * @param httpSession
	 * @return
	 * @throws Exception
	 */
	@DeleteMapping(value = "/rcsBrand/removeChatbot")
	@ResponseBody
	public Object removeRcsBrandChatbot(@RequestParam(value = "brId") String brId, @RequestParam(value = "chatbotId") String chatbotId,HttpSession httpSession) throws Exception {

		RcsBrandChatbot brandChatbot = new RcsBrandChatbot();
		brandChatbot.setBrId(brId);
		brandChatbot.setChatbotId(chatbotId);
		
		return service.removeRcsBrandChatbot(brandChatbot);
	}
	
	private void setSearchCondition(HttpSession session, Object obj){

		if(obj instanceof RcsBrandChatbot) {
			RcsBrandChatbot chgObj = (RcsBrandChatbot) obj;
			if(session.getAttribute("EMPL_ID") ==null) {    
				Preconditions.checkArgument(false, "session empl_id is empty");  
			}else {
				chgObj.setEmplId((String)session.getAttribute("EMPL_ID")); 
			}
		}
	}
	
}
