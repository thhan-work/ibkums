package com.ibk.msg.web.eventsend;

import com.ibk.msg.web.auth.EmployeeService;
import com.ibk.msg.web.message.model.MessageDto;
import com.ibk.msg.web.user.UserInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class EventSendController {

	private static final Logger logger = LoggerFactory.getLogger(EventSendController.class);

	@Autowired
	private EventSendService eventSendService;

	@Autowired
	private EmployeeService employeeService;

	@GetMapping("/eventsend.ibk")
	public String viewListJsp(HttpSession httpSession, Model model) {
		if(httpSession.getAttribute("USER_CLASS")!=null) {
			if (httpSession.getAttribute("USER_CLASS").toString().indexOf("G")!=-1
					|| httpSession.getAttribute("USER_CLASS").toString().indexOf("A")!=-1) {
				// 220523 Interceptor에서 제외되기 때문에 별도 추가
				UserInfo headerInfo = new UserInfo();
				headerInfo.setEmplId((String) httpSession.getAttribute("EMPL_ID")); // 사용자ID
				headerInfo.setUserLevel((String) httpSession.getAttribute("USER_CLASS")); // 사용자권한(=EMPL_LEVEL, userClass)
				headerInfo.setBoCode((String) httpSession.getAttribute("EMPL_BOCODE")); // 부서코드
				headerInfo.setPartName((String) httpSession.getAttribute("EMPL_BONAME")); // 부서명
				headerInfo.setEmplName((String) httpSession.getAttribute("EMPL_NAME")); // 사용자명
				model.addAttribute("headerInfo", headerInfo);
				return "eventSend/send-event";
			}
		}
		return "eventSend/login";
	}
	
	@GetMapping("/motp_eventsend.ibk")
	public String viewMotpListJsp(HttpSession httpSession, Model model) {
		return "eventSend/motp_login";
	}


	@PostMapping(value = "/motp_eventsend.ibk", produces = {"application/json"})
	public String eventMotp(
	  		@RequestParam(name="motp_id", required=false) String motp_id,@RequestParam(name="motp_no", required=false) String motp_no
			, Model model, HttpServletRequest httpServletRequest) throws Exception {
		String path = employeeService.motpLoginCheck(motp_id, motp_no, model, httpServletRequest);
		model.addAttribute("motpId", motp_id);
		if(path.equals("common/motp_login")) {
			path="eventSend/motp_login";
		}
		return path;
	}
	/**
	 * 경조사보내기 로그인
	 * 
	 * @param event_id
	 * @param event_pw
	 * @param model
	 * @param httpSession
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value = "/eventsend.ibk", produces = {"application/json"})
	public String event(			
	  		@RequestParam(name="event_id", required=false) String event_id,@RequestParam(name="event_pw", required=false) String event_pw
			, Model model, HttpServletRequest httpServletRequest) throws Exception {

		//		String path = eventSendService.login(event_id, event_pw, model);
		String path = employeeService.idpwLoginCheck(event_id, event_pw, model, httpServletRequest);
		model.addAttribute("inputId", event_id);
		if(path.equals("common/login")) {
			path="eventSend/login";
		}
		return path;
	}

	/**
	 * 경조사보내기 수신인 검색
	 * 
	 * @param type
	 * @param boCode
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value = "/eventsend/search/{type}/{boCode}", produces = {"application/json"})
	@ResponseBody
	public Object search(@PathVariable("type") String type	,@PathVariable("boCode") String boCode, Model model) throws Exception {
		logger.info("경조사보내기 수신인 검색		(type=" + type+",boCode="+boCode+")");
		return eventSendService.search(type, boCode);
	} 


	@PostMapping(value = "/eventsend/send/{type}", produces = {"application/json"})
	@ResponseBody
	public Object send(@PathVariable("type") String type, @RequestBody MessageDto messageDto, HttpSession session) throws Exception {
		logger.info(" * sendEvent type : [" + type + "]");
		logger.info(messageDto.toString());

		Object result = eventSendService.sendMsg(type, session, messageDto);

		return result;
	}
}
