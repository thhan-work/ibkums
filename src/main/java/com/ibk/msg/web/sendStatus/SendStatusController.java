package com.ibk.msg.web.sendStatus;

import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.base.Preconditions;
import com.ibk.msg.web.smssendlist.SendHistorySearchCondition;
import com.ibk.msg.web.smssendlist.SmsSendListSearchCondition;
import com.ibk.msg.web.smssendlist.SmsSendListService;

@RequestMapping(value = "/campaign")
@Controller
public class SendStatusController {
	private static final Logger logger = LoggerFactory.getLogger(SendStatusController.class);

	@Autowired
	private SmsSendListService smssendlistService;
	
	@Autowired
	private SendStatusService sendStatusService;
	
	@GetMapping("/sendStatus.ibk")
	public String viewListJsp() {
		return "campaign/sendStatus/sendStatus-list";
	}

	/**
	 * 발송현황 list 조회
	 * @param searchCondition
	 * @param httpSession
	 * @return
	 * @throws Exception
	 */
	@GetMapping("/smssendlist")
	@ResponseBody
	public Object findByPagination(SmsSendListSearchCondition searchCondition, HttpSession httpSession) throws Exception {
		setSmsSendListSearchCondition(httpSession,searchCondition);
		return smssendlistService.findByPagination(searchCondition);
	}
	
	/**
	 * 발송현황 상세 > 기본정보 조회
	 * @param smssendlistId
	 * @return
	 * @throws Exception
	 */
	@GetMapping("/smssendlist-detail.ibk/{smssendlistId}")
	@ResponseBody
	public Object sendStausDetail(@PathVariable("smssendlistId") String smssendlistId) {
		Map<String, Object> sendStatusDetailMap = new HashMap<String, Object>();

		int smssendlistIdToInt = Integer.parseInt(smssendlistId);
		if (smssendlistIdToInt > 0) {
			sendStatusDetailMap = sendStatusService.findDetailAjax(smssendlistIdToInt);
		}
		return sendStatusDetailMap;
	}
	
	/**
	 * 발송현황 상세 > 발송 내역 조회
	 * @param searchCondition
	 * @param httpSession
	 * @return
	 * @throws Exception
	 */
	@GetMapping("/sendHistoryList")
	@ResponseBody
	public Object sendHistoryByPagination(SendHistorySearchCondition searchCondition, HttpSession httpSession) throws Exception {
		return sendStatusService.sendHistoryByPagination(searchCondition);
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

	/**
	 * 발송현황 > 삭제
	 * @param smssendlistId
	 * @return
	 * @throws Exception
	 */
	@GetMapping("/deleteSendStatus/{smssendlistId}")
	@ResponseBody
	public Object deleteSendStatus(@PathVariable("smssendlistId") String smssendlistId) {
		Map<String, Object> sendStatusResultMap = new HashMap<String, Object>();
		int smssendlistIdToInt = Integer.parseInt(smssendlistId);
		sendStatusResultMap = sendStatusService.deleteSendStatus(smssendlistIdToInt);
		
		return sendStatusResultMap;
	}
	
	/**
	 * 발송현황 > 상태값변경
	 * @param requestData
	 * @return
	 * @throws Exception
	 */
	@PostMapping("/updateSendStatus")
	@ResponseBody
	public Object updateSendStatus(@RequestParam Map<String, Object> requestData) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		try {
			resultMap = sendStatusService.updateSendStatus(requestData);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return resultMap;
	}
	
	/**
	 * 발송현황 > 기본정보 > 예약일시, 시작일시 조회
	 * @param requestData
	 * @return
	 * @throws Exception
	 */
	@PostMapping("/savecnt2")
	@ResponseBody
	public Object selectDateSaveCount2(@RequestBody Map<String, Object> requestData, Model model, HttpSession httpSession){
		logger.info("##GROUP_UNIQ_NO="+requestData.get("groupUniqNo"));

		HashMap<String, Object> result = sendStatusService.getDateSaveCnt2(requestData);
		TreeMap<String, Object> treeResult = new TreeMap<String,Object>(result); // 오름차순 정렬
		logger.info("##RESULTLIST="+treeResult.toString());

		return treeResult; // {일자1 : {시간1:건수1, 시간2:건수2, ...}, 일자2 : {시간1:건수1, 시간2:건수2 ...}, ...} 
	}
}






