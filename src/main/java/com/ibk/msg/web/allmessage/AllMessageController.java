package com.ibk.msg.web.allmessage;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.base.Preconditions;
import com.ibk.msg.web.auth.EmployeeInfo;
import com.ibk.msg.web.auth.EmployeeService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AllMessageController {
	private static final Logger logger = LoggerFactory.getLogger(AllMessageController.class);

	@Autowired
	private AllMessageService allMessageService;

	@Autowired
	private EmployeeService employeeService;

	/*@GetMapping("/allmessage.ibk")
	public String viewListJsp() {
		return "allmessage/allmessage-list";
	}*/
	
	@GetMapping("/allmessage.ibk")
	public String viewListJsp(Model model, HttpServletRequest request) {
		String sPhnNo = request.getParameter("phno") != null ? request.getParameter("phno").trim() : "";
		String sStartDt = request.getParameter("s_startdt") != null ? request.getParameter("s_startdt").trim() : "";
		String sEndDt = request.getParameter("s_enddt") != null ? request.getParameter("s_enddt").trim() : "";
		String sFlag = request.getParameter("s_flag") != null ? request.getParameter("s_flag").trim() : "";
		String sPhoneReadonly = (sFlag.equals("S") && !sPhnNo.isEmpty() ? "readonly" : "");
		
		model.addAttribute("phno", sPhnNo);

		model.addAttribute("s_startdt", sStartDt);
		model.addAttribute("s_enddt", sEndDt);
		model.addAttribute("s_flag", sFlag);
		model.addAttribute("phoneReadonly", sPhoneReadonly);

			// log.info("phoneNo : "+ sPhnNo +" , sFlag : "+ sFlag +" , sPhoneReadonly : "+ sPhoneReadonly +" , sStartDt : "+ sStartDt +" , sEndDt : "+ sEndDt);

		return "allmessage/allmessage-list";
	}

	@GetMapping("/crmview.ibk")
	public String crmView(Model model, HttpServletRequest request, HttpServletResponse response) throws IOException {
		String telno = request.getParameter("telno");
		if (telno == null) {
			telno = request.getParameter("encTelNo");
			if (telno != null) {
				log.info("encryptedText : {}", telno);
				StandardPBEStringEncryptor jasypt = new StandardPBEStringEncryptor();
				jasypt.setPassword("ibk");      //암호화 키(password)
				jasypt.setAlgorithm("PBEWithMD5AndDES");
				telno = jasypt.decrypt(telno);
				log.info("decryptedText : {}", telno);
			}
		} else {
			StringBuilder queryString = new StringBuilder();
			Enumeration<String> parameterNames = request.getParameterNames();
			while(parameterNames.hasMoreElements()) {
				String parameterName = parameterNames.nextElement();
				if (parameterName.equals("telno")) {
					// TODO : 암호화 처리 encTelNo
					StandardPBEStringEncryptor jasypt = new StandardPBEStringEncryptor();
					jasypt.setPassword("ibk");      //암호화 키(password)
					jasypt.setAlgorithm("PBEWithMD5AndDES");
					String encryptedText = jasypt.encrypt(request.getParameter(parameterName));    //암호화
					
					log.info("encryptedText : {}", encryptedText);

					queryString.append("encTelNo")
					.append("=")
					.append(URLEncoder.encode(encryptedText));
				} else {
					queryString.append(parameterName)
					.append("=")
					.append(request.getParameter(parameterName));
				}
				
//				URLEncoder.encode(request.getParameter(parameterName));
				if (parameterNames.hasMoreElements()) {
					queryString.append("&");
				}
			}
			response.sendRedirect(request.getRequestURI() + "?" + queryString.toString());
			return null;
		}
		model.addAttribute("msgKey", request.getParameter("msgKey"));
		model.addAttribute("regDt", request.getParameter("regDt"));
		model.addAttribute("telno", telno);

		return "allmessage/crmview";
	}

	@GetMapping("/allmessageSSO.ibk")
	public String allmessageSSOJsp(HttpSession session, HttpServletRequest request) {
		Object objEmplClass = session.getAttribute("USER_CLASS");
		Object objEmplId = session.getAttribute("EMPL_ID");
		Object objLoginMethod = session.getAttribute("LOGIN_METHOD");

//		if (objEmplClass == null || objEmplId == null || objLoginMethod == null) {
		if (objEmplId == null) {
			return "allmessage/sso";
		}


		return "redirect:allmessage.ibk";
	}

	@GetMapping("/allmessage/search.ibk")
	public String viewSearchJsp(HttpSession httpSession) {
		// 로그인 권한 체크 (session 만료 검사)
		//	  if(httpSession.getAttribute("LOGIN_OK") == null || httpSession.getAttribute("USER_CLASS") == null || !httpSession.getAttribute("USER_CLASS").equals("M")){
		//		  return "allmessage/login";  
		//	  }

		return "allmessage/allmessage-list";
	}

	@RequestMapping("/crmview")
	@ResponseBody
	public Object crmviewSelect(HttpServletRequest request, HttpSession httpSession) {
		Map<String, Object> ret = new HashMap<String, Object>();
		Map<String, Object> res = new HashMap<String, Object>();

		ret.put("res", res);
		AllMessageSearchCondition searchCondition = new AllMessageSearchCondition();
		String msgKey = request.getParameter("msgKey");
		String regDt = request.getParameter("regDt");
		String telno = request.getParameter("telno");

		if(msgKey == null || msgKey.trim().equals("")) {
			res.put("response_code", "1");
			res.put("response_message", "메시지키가 없습니다.");
			return ret;
		}

		if(regDt == null || regDt.trim().equals("")) {
			res.put("response_code", "1");
			res.put("response_message", "발송일이 없습니다.");
			return ret;
		}

		if(telno == null || telno.trim().equals("")) {
			telno = "";
		}

		searchCondition.setMsgKey(msgKey);
		searchCondition.setRegDt(regDt);
		searchCondition.setTelNo(telno);

		setMyMessageSearchCondition(httpSession,searchCondition);
		Object sc = allMessageService.crmviewSelect(searchCondition);
		if (sc == null ){
			res.put("response_code", "2");
			res.put("response_message", "조회 데이터가 없습니다.");
		}else {
			ret.put("value", sc);
			res.put("response_code", "0");
			res.put("response_message", "성공");
		}

		return ret;
	}

	@GetMapping("/allmessage")
	@ResponseBody
	public Object findByPagination(AllMessageSearchCondition searchCondition, HttpSession httpSession) throws Exception {

		setMyMessageSearchCondition(httpSession,searchCondition);
		return allMessageService.findByPagination(searchCondition);
	}

	@PutMapping("/allmessage")
	@ResponseBody
	public Object modify(AllMessage allMessage, HttpSession httpSession) throws Exception {
		return allMessageService.modify(allMessage);
	}

	@GetMapping("/allmessage/successCount")
	@ResponseBody
	public int successCount(AllMessageSearchCondition searchCondition, HttpSession httpSession) throws Exception{
		//	  setMyMessageSearchCondition(httpSession, searchCondition);
		int a = allMessageService.successCount(searchCondition);
		return a;
	}
	
	@GetMapping("/allmessage/checkEmplHp")
	@ResponseBody
	public String checkEmplHp(AllMessageSearchCondition searchCondition, HttpSession httpSession) throws Exception{
		String sRetVal = "Y";
		
		if(httpSession.getAttribute("EMPL_ID") == null) {
			sRetVal = "D";				// 로그인이 안되어있음 - 권한없음
		} else {
			int iCheckEmplHp = allMessageService.checkEmplHp(searchCondition);
			if(iCheckEmplHp < 0) {
				sRetVal = "F";			// 휴대폰번호가 올바르지 않음
			} else if(iCheckEmplHp > 0) {
				sRetVal = "N";			// 직원 휴대폰번호는 검색할 수 없음
			}
		}

		return sRetVal;
	}



	private void setMyMessageSearchCondition(HttpSession session, AllMessageSearchCondition searchCondition){

		if(session.getAttribute("EMPL_ID") ==null) {    
			Preconditions.checkArgument(false, "session empl_id is empty");  
		}else {
			searchCondition.setEmplId((String)session.getAttribute("EMPL_ID")); 
		}

		if(session.getAttribute("IP")==null) {
		}else {
			searchCondition.setEmplIp((String)session.getAttribute("IP"));
		}
	}

	@PostMapping(value = "/allmessage/unitUpdate" ,  produces = {"application/json"})
	@ResponseBody
	public Object unitModify(@RequestBody Map<String, Object> param, HttpSession httpSession) throws Exception {
		if( httpSession.getAttribute("EMPL_ID") ==null) {    
			Preconditions.checkArgument(false, "session empl_id is empty");  
		}else {
			param.put("emplId", httpSession.getAttribute("EMPL_ID")); 
		}

		if(httpSession.getAttribute("IP")==null) {
		}else {
			param.put("ip", httpSession.getAttribute("IP"));
		}

		return allMessageService.unitModify(param);
	}

}






