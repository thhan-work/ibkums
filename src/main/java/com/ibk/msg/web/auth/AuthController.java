package com.ibk.msg.web.auth;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.base.Preconditions;

@RequestMapping(value = "/campaign")
@Controller
public class AuthController {
	private static final Logger logger = LoggerFactory.getLogger(AuthController.class);

	@Autowired
	private AuthService authService;
	
	/**
	 * 권한조회
	 * @param searchCondition
	 * @param httpSession
	 * @return
	 * @throws Exception
	 */
	@GetMapping("/authList")
	@ResponseBody
	public Object authList(AuthSearchCondition searchCondition, HttpSession httpSession) throws Exception {
		setSearchCondition(httpSession,searchCondition);
		return authService.authList(searchCondition);
	}
	
	/**
	 * 권한 사용자 화면 
	 * @return
	 */
	@GetMapping("/authUser.ibk")
	public String authUserView() {
		return "campaign/auth/authUser-list";
	}
	
	/**
	 * 권한 사용자 목록 조회
	 * @param searchCondition
	 * @param httpSession
	 * @return
	 * @throws Exception
	 */
	@GetMapping("/authUserList")
	@ResponseBody
	public Object authUserList(AuthSearchCondition searchCondition) throws Exception {
		return authService.authUserList(searchCondition);
	}
	
	/**
	 * 권한 사용자 목록 조회
	 * @param searchCondition
	 * @param httpSession
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value="/authUserInfo", produces = "application/json")
	@ResponseBody
	public Object authUserInfo(@RequestBody AuthSearchCondition searchCondition) throws Exception {
		return authService.authUserInfo(searchCondition);
	}
	
	/**
	 * 권한 사용자 > 직원 목록 조회
	 * @param searchCondition
	 * @param httpSession
	 * @return
	 * @throws Exception
	 */
	@GetMapping("/authEmpList")
	@ResponseBody
	public Object authEmpList(AuthSearchCondition searchCondition, HttpSession httpSession) throws Exception {
		setSearchCondition(httpSession, searchCondition);
		return authService.authEmpList(searchCondition);
	}
	
	/**
	 * 권한 사용자 저장
	 * @param searchCondition
	 * @param httpSession
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value="/saveAuthUser", produces = "application/json")
	@ResponseBody
	public Map<String, Object> saveAuthUser(@RequestBody TAuthUser tAuthUser, HttpSession httpSession) throws Exception {
		setSearchCondition(httpSession, tAuthUser);
		return authService.saveAuthUser(tAuthUser);
	}
	
	/**
	 * 권한 사용자 삭제
	 * @param searchCondition
	 * @param httpSession
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value="/deleteAuthUser", produces = "application/json")
	@ResponseBody
	public Map<String, Object> deleteAuthUser(@RequestBody TAuthUser tAuthUser) throws Exception {
		return authService.deleteAuthUser(tAuthUser);
	}
	
	/**
	 * 권한 일괄 부여
	 * @param searchCondition
	 * @param httpSession
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value="/groupEmplAuthGrant")
	@ResponseBody
	public Map<String, Object> groupEmplAuthGrant(@RequestBody TAuthGrant tAuthGrant, HttpSession httpSession) throws Exception {
		setSearchCondition(httpSession, tAuthGrant);
		return authService.groupEmplAuthGrant(tAuthGrant);
	}
	
	/**
	 * 해당 직원의 권한 부여
	 * @param searchCondition
	 * @param httpSession
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value="/oneEmplAuthGrant")
	@ResponseBody
	public Map<String, Object> oneEmplAuthGrant(@RequestBody TAuthGrant tAuthGrant, HttpSession httpSession) throws Exception {
		setSearchCondition(httpSession, tAuthGrant);
		return authService.oneEmplAuthGrant(tAuthGrant);
	}
	
	private void setSearchCondition(HttpSession session, Object obj){
		if(obj instanceof AuthSearchCondition) {
			AuthSearchCondition chgObj = (AuthSearchCondition) obj;
			
			if(session.getAttribute("EMPL_ID") == null) {    
				Preconditions.checkArgument(false, "session empl_id is empty");  
			}else {
				chgObj.setEmplId((String)session.getAttribute("EMPL_ID")); 
			}
			
		} else if(obj instanceof TAuthUser) {
			TAuthUser chgObj = (TAuthUser) obj;
			
			if(session.getAttribute("EMPL_ID") == null) {    
				Preconditions.checkArgument(false, "session empl_id is empty");  
			}else {
				chgObj.setRegId((String)session.getAttribute("EMPL_ID")); 
			}
		} else if(obj instanceof TAuthGrant) {
			TAuthGrant chgObj = (TAuthGrant) obj;
			
			if(session.getAttribute("EMPL_ID") == null) {    
				Preconditions.checkArgument(false, "session empl_id is empty");  
			}else {
				chgObj.setRegId((String)session.getAttribute("EMPL_ID")); 
			}
		}
	}
}