package com.ibk.msg.web.rcsTemplate;
import lombok.extern.slf4j.Slf4j;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.common.base.Preconditions;
import com.ibk.msg.web.rcsBrand.RcsBrand;
import com.ibk.msg.web.rcsBrand.RcsBrandSearchCondition;
import com.ibk.msg.web.rcsBrand.RcsBrandService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

@Slf4j
@RequestMapping(value = "/campaign")
@Controller
public class RcsTemplateController {
	private static final Logger logger = LoggerFactory.getLogger(RcsTemplateController.class);

	@Autowired
	RcsTemplateService service;
	
	@Autowired
	RcsBrandService brandService;
	
	@GetMapping("/rcsTemplate.ibk")
	public String viewListJsp() {
		return "campaign/rcsTemplate/rcsTemplate-list";
	}
	
	/**
	 * RCS Template 조회
	 * @param searchCondition
	 * @param httpSession
	 * @return
	 * @throws Exception
	 */
	@GetMapping(value = "/rcsTemplate/list")
	@ResponseBody
	public Object findByPagination(RcsTemplateSearchCondition searchCondition, HttpSession httpSession) throws Exception {
		setSearchCondition(httpSession,searchCondition);
		
		return service.findRcsTemplateByPagination(searchCondition);
		
	}
	
	/** RCS Template 저장 (등록/수정)
	 * @param rcsTemplate
	 * @param httpSession
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value = "/rcsTemplate/save" , produces = "application/json")
	@ResponseBody
	public Integer saveRcsTemplate(RcsTemplate rcsTemplate, HttpSession httpSession) throws Exception {
		setSearchCondition(httpSession, rcsTemplate);
		
		// 등록일 경우 mapper에서 insert
		rcsTemplate.setRegUserId( rcsTemplate.getEmplId() ); 
		
		// 수정일 경우 mapper에서 update
		rcsTemplate.setUpdateUserId( rcsTemplate.getEmplId() );
		
		return service.saveRcsTemplate(rcsTemplate);
		
	}
	
	/**
	 * RCS Template 등록시 필요한 combo box(select box) 정보(서술,스타일,브랜드) 조회 
	 * @param searchCondition
	 * @param httpSession
	 * @return
	 * @throws Exception
	 */
	@GetMapping(value = "/rcsTemplate/getComboBoxList")
	@ResponseBody
	public Map<String, Object> getBizService(String param, HttpSession httpSession) throws Exception {
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<String,Object>();
		
		// 서술
		List<Map<String, Object>> descList = service.getRcsBizService("description");
		map.put("descList", descList);
		
		//스타일
		List<Map<String, Object>> cellList  = service.getRcsBizService("cell");
		map.put("cellList", cellList);
		
		// 브랜드
		List<RcsBrand> brandList = brandService.findRcsBrand(new RcsBrandSearchCondition());
		map.put("brandList", brandList);
		
		return map;
	}
	
	/**
	 * RCS Template 삭제
	 * @param requestData
	 * @param httpSession
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value = "/rcsTemplate/remove" , produces = "application/json")
	@ResponseBody
	public Object removeRcsTemplate(@RequestBody Map<String, Object> requestData, HttpSession httpSession) throws Exception {
		

		RcsTemplate rcsTemplate = new RcsTemplate();
		rcsTemplate.setData(requestData);
		setSearchCondition(httpSession,rcsTemplate);
		
		rcsTemplate.setUpdateUserId( rcsTemplate.getEmplId() ); // EMPL_ID
		
		return service.deleteRcsTemplate(rcsTemplate);
	}
	
	/**
	 * RCS Template 승인요청
	 * @param requestData
	 * @param httpSession
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value = "/rcsTemplate/approval", produces = "application/json")
	@ResponseBody
	public Integer approvalRcsTemplate(@RequestBody Map<String, Object> requestData, HttpSession httpSession) throws Exception {
		
		RcsTemplate rcsTemplate = new RcsTemplate();
		rcsTemplate.setData(requestData);
		
		setSearchCondition(httpSession, rcsTemplate);
		rcsTemplate.setApprReqUserId( rcsTemplate.getEmplId() ); // EMPL_ID		
		
		return service.approvalRcsTemplate(rcsTemplate);
	}
	

	private void setSearchCondition(HttpSession session, Object obj){

		if(obj instanceof RcsTemplateSearchCondition) {
			RcsTemplateSearchCondition chgObj = (RcsTemplateSearchCondition) obj;
			
			if(session.getAttribute("EMPL_ID") == null) {    
				Preconditions.checkArgument(false, "session empl_id is empty");  
			}else {
				chgObj.setEmplId((String)session.getAttribute("EMPL_ID")); 
			}
		} else if(obj instanceof RcsTemplate) {
			RcsTemplate chgObj = (RcsTemplate) obj;
			if(session.getAttribute("EMPL_ID") ==null) {    
				Preconditions.checkArgument(false, "session empl_id is empty");  
			}else {
				chgObj.setEmplId((String)session.getAttribute("EMPL_ID")); 
			}
		}
	}
	
	

}
