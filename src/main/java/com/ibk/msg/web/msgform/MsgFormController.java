package com.ibk.msg.web.msgform;

import java.util.Hashtable;

import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.ExceptionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

import com.ibk.msg.common.dto.PaginationResponse;
import com.ibk.msg.web.notice.Notice;

@Controller
public class MsgFormController {
	
	private static final Logger logger = LoggerFactory.getLogger(MsgFormController.class);

	@Autowired
	private MsgFormService msgFormService;

	
	/**
	 * 	 * 2018.10.18 JYS : 
	 *  ㅁ IBK ASIS 웹에서 division = "sms"는 사용 하지 않음.
	 *   - ASIS 소스에서 division = "sms" 관련 메세지 미리보기 부분은 제거
	 */
	
	
	/**
	 * 서식함 메뉴 선택시 최초 페이지 호출
	 * 
	 * @param code
	 * @return
	 * @throws Exception
	 */
	@GetMapping("/form/{code}")
	@ResponseBody
	public Object initMsgFormPage(@PathVariable("code") String code, HttpSession session) throws Exception {
		
		logger.debug("########### Call initMsgFormPage  CODE:"+code);
		
		ModelAndView mav = new ModelAndView();
		
		PaginationResponse pr = null;
		MsgFormSearchCondition msgform = new MsgFormSearchCondition();
		
		// sms 통합
		String division = "mms";
		
		msgform.setCode(code);
		msgform.setDivision(division);
		msgform.setPerPage(8);
		msgform.setCurrentPage(1);

		if(code.equals("happy")) // 해피콜문자
		{
			msgform.setMsgFormClcd("2");
			if (division.equals("mms")) {
				msgform.setMsgFormCate("1"); // init View 리스트 (해피콜문자 - 신규) 메시지 설정 
				pr = msgFormService.getMMSMsgFormList(msgform);
			} 
			mav.setViewName("msgForm/msgForm-happy");

		}else if(code.equals("head")) // 본부양식
		{
			msgform.setMsgFormClcd("1");
			msgform.setMsgFormCate(null); // 해피콜문자에만 사용
			if (division.equals("mms")) {
				pr = msgFormService.getMMSMsgFormList(msgform);
			}
			mav.setViewName("msgForm/msgForm-head");
			
		}else if(code.equals("personal")) // 개인서식함
		{
			if (division.equals("mms")) {
				msgform.setBoCode(session.getAttribute("EMPL_BOCODE").toString());
				msgform.setEmplId(session.getAttribute("EMPL_ID").toString());
				pr = msgFormService.getMMSMyList(msgform);
			} 
			mav.setViewName("msgForm/msgForm-personal");
			
		}else if(code.equals("dept")) // 부서서식함
		{
			if (division.equals("mms")) {
				msgform.setBoCode(session.getAttribute("EMPL_BOCODE").toString());
				pr = msgFormService.getMMSMyMsgList(msgform);
			}			
			mav.setViewName("msgForm/msgForm-dept");
		}
		
		logger.debug("########### Call initMsgFormPage  SelectListDATA:\n"+pr.toString());
		
		mav.addObject("category", msgform.getMsgFormCate());
		mav.addObject("total", pr.getTotalRecords());      
		mav.addObject("perPage", pr.getPerPage());         
		mav.addObject("currentPage", pr.getCurrentPage()); 
		mav.addObject("lastPage", pr.getLastPage());       
		mav.addObject("startPage", pr.getStartPage());     
		mav.addObject("endPage", pr.getEndPage());         
		mav.addObject("dataList", pr.getData());              
		
		return mav;
	}
	
	
	/**
	 * 서식함 데이터 리스트 조회
	 * 
	 * @param code
	 * @return
	 * @throws Exception
	 */
	@PostMapping("/form/{code}")
	@ResponseBody
	@ResponseStatus(HttpStatus.OK)
	public PaginationResponse getMsgFormList(@PathVariable("code") String code, @RequestBody MsgFormSearchCondition msgform, HttpSession session) throws Exception {
		
		logger.debug("########### Call getMsgFormList  MsgForm:"+msgform.toString());
		
		PaginationResponse pr = null;
	
		// sms 통합
		String division = "mms";
		
		if(code.equals("happy")) // 해피콜문자 (MSG_FORM_CLCD : 2)
		{
			msgform.setMsgFormClcd("2");
			if (division.equals("mms")) {
				pr = msgFormService.getMMSMsgFormList(msgform);
	
			}
		}else if(code.equals("head")) // 본부양식 (MSG_FORM_CLCD : 1)
		{
			msgform.setMsgFormClcd("1");
			if (division.equals("mms")) {
				pr = msgFormService.getMMSMsgFormList(msgform);
			} 
		}else if(code.equals("personal")) // 개인서식함
		{
			if (division.equals("mms")) {
				msgform.setBoCode(session.getAttribute("EMPL_BOCODE").toString());
				msgform.setEmplId(session.getAttribute("EMPL_ID").toString());
				pr = msgFormService.getMMSMyList(msgform);
			} 
		}else if(code.equals("dept")) // 부서서식함
		{
			if (division.equals("mms")) {
				msgform.setBoCode(session.getAttribute("EMPL_BOCODE").toString());
				pr = msgFormService.getMMSMyMsgList(msgform);
			}
		}
		
		logger.debug("########### Call getMsgFormList  SelectListDATA:"+pr.toString());
		
		return pr;
	}

	
	/**
	 * 개인서식함 저장
	 * 
	 * @param msgform
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value = "/form/{code}/save", produces = {"application/json"})
	@ResponseBody
	@ResponseStatus(HttpStatus.CREATED)
	public Object add(@PathVariable("code") String code, @RequestBody MsgFormSearchCondition msgform, HttpSession session) throws Exception {
	  
	  logger.debug("########### Call 개인서식함 이동 저장  MsgForm:"+msgform.toString());
	  
		// sms 통합
		String division = "mms";
	
		int result = 0;
	
		if(code.equals("personal")) // 개인서식함
		{
			if (division.equals("mms")) {
				msgform.setEmplId(session.getAttribute("EMPL_ID").toString());
				msgform.setMyMsgTitle(msgform.getTitle());
				msgform.setMyMsgCts(msgform.getMsg());
				msgform.setMsgFilePath("");
				msgform.setMsgFileSiz("0");
				
				result = msgFormService.addMMSMyMsg(msgform);
			}
		}else if(code.equals("dept")) // 부서서식함
		{
			msgform.setBoCode(session.getAttribute("EMPL_BOCODE").toString());
			msgform.setMyMsgTitle(msgform.getTitle());
			msgform.setMyMsgCts(msgform.getMsg());
			msgform.setMsgFilePath("");
			msgform.setMsgFileSiz("0");
			
			result = msgFormService.addMMSMyMsgInfo(msgform);
		}
		
		return result;
	}
	  
	/**
	 * 서식함 메세지 삭제
	 * 
	 * @param msgform
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@DeleteMapping("/form/{code}/delete")
	@ResponseBody
	public Object remove(@RequestBody MsgFormSearchCondition msgform, HttpSession session) throws Exception {

			// sms 통합
			String division = "mms";

			int result = 0;
			
			try {
	
				if (msgform.getCode().equals("personal")) { // 개인메시지함
					if (division.equals("mms")) {
						msgform.setEmplId(session.getAttribute("EMPL_ID").toString());
						result = msgFormService.deleteMMSMyMsg(msgform);
					}
				} else if (msgform.getCode().equals("dept")) { // 부서메시지함
					if (division.equals("mms")) {
						msgform.setBoCode(session.getAttribute("EMPL_BOCODE").toString());
						result = msgFormService.delMMSMyMsgList(msgform);
					} 
				} else { // 해피콜 / 본부
	//					if (division.equals("mms")) {
	//						mmsFormInfo.MSG_FORM_NO = Integer.parseInt(seq);
	//						v.add(mmsFormInfo);
	//						rs = mmsForm.delMsgFormList(v);
	//					} else {
	//						msgFormInfo.MSG_FORM_NO = Integer.parseInt(seq);
	//						v.add(msgFormInfo);
	//						rs = msgFormMgr.delMsgFormList(v);
	//					}
				}
	
			} catch (Exception e) {
				logger.error("ERROR:",e);
			}

			return result;
  }
}
