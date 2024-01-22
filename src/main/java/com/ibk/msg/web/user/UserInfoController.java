package com.ibk.msg.web.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

@Controller
public class UserInfoController {
	private static final Logger logger = LoggerFactory.getLogger(UserInfoController.class);
	
    @Autowired
    private UserInfoService userInfoService;
    
    @GetMapping("/admin/user.ibk")
    public String viewListJspToUser() {
        return "employee/user-list";
    }

    @GetMapping("/admin/employee.ibk")
    public String viewListJspToEmployee() {
        return "employee/employee-list";
    }

    @GetMapping("/admin/authorizer.ibk")
    public String viewListJspToAuthorizer() {
        return "authorizer/authorizer-list";
    }

    @GetMapping("/admin/admin.ibk")
    public String viewListJspToAdmin() {
        return "admin/admin-list";
    }
    
    @GetMapping("/admin/directlogin.ibk")
    public String viewListJspToLoginUser() {
        return "login-user/login-user-list";
    }
    
    @GetMapping("/admin/motplogin.ibk")
    public String viewListJspToMotpUser() {
        return "motp-user/motp-user-list";
    }

    @GetMapping("/user")
    @ResponseBody
    public Object findByPagination(UserInfoSearchCondition searchCondition) throws Exception {
        return userInfoService.findByPagination(searchCondition);
    }
    
    @GetMapping("/loginuser")
    @ResponseBody
    public Object findLoginUserByPagination(UserInfoSearchCondition searchCondition) throws Exception {
        return userInfoService.findByLoginUserPagination(searchCondition);
    }

    @GetMapping("/user/{emplId}")
    @ResponseBody
    public Object findDetail(@PathVariable("emplId") String emplId) throws Exception {
        return userInfoService.findDetail(emplId);
    }

    @GetMapping("/user/{emplId}/count")
    @ResponseBody
    public int getCount(@PathVariable("emplId") String emplId) throws Exception {
        return userInfoService.findDetailCount(emplId);
    }
    
    @GetMapping("/loginuser/{loginId}")
    @ResponseBody
    public HashMap<String, Object> getLoginUser(@PathVariable("loginId") String loginId) throws Exception {
        return userInfoService.getLoginUser(loginId);
    }
    
    @GetMapping("/loginuser/{loginId}/count")
    @ResponseBody
    public int getLoginUserCount(@PathVariable("loginId") String loginId) throws Exception {
        return userInfoService.getLoginUserCount(loginId);
    }

    @PutMapping(value = "/user/{emplId}", produces = {"application/json"})
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public Object modify(@PathVariable("emplId") String emplId, @RequestBody UserInfo userInfo, HttpSession session) throws Exception {
    	logger.info("[INFO] ########### emplId="+emplId);
    	logger.info("[INFO] ########### userInfo="+userInfo.toString());
    	
        userInfo.setModId(getWriter(session));
        userInfo.setEmplId(emplId);
        return userInfoService.modify(userInfo);
    }
    
    @PutMapping(value = "/loginuser", produces = {"application/json"})
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public Object modifyLoginUser(@RequestBody Map<String, Object> param, HttpSession session) throws Exception {

    	logger.info("[INFO] ########### userInfo="+param.toString());
    	
    	param.put("mod_id", getWriter(session));
    	
    	
        return userInfoService.modifyLoginUser(param);
    }

    @DeleteMapping("/user/{requestType}/{emplId}")
    @ResponseBody
    public Object remove(@PathVariable("emplId") String[] userIdArr, @PathVariable("requestType") String requestType, HttpSession session) throws Exception {
    	logger.info("[INFO] ########### emplId="+userIdArr);
    	logger.info("[INFO] ########### requestType="+requestType);
    	
        return userInfoService.remove(userIdArr, requestType, session);
    }
    @DeleteMapping("/loginuser/remove/{userId}")
    @ResponseBody
    public Object removeLoginUser(@PathVariable("userId") String[] userIdArr, HttpSession session) throws Exception {
    	logger.info("[INFO] ########### emplId="+userIdArr);
    	
        return userInfoService.removeLoginUser(userIdArr, session);
    }

    @PostMapping(value = "/user", produces = {"application/json"})
    @ResponseBody
    @ResponseStatus(HttpStatus.CREATED)
    public Object add(@RequestBody UserInfo userInfo, HttpSession session) throws Exception {
    	logger.info("[INFO] ########### userInfo="+ userInfo.toString());
    	logger.info("[INFO] ########### regId="+ getWriter(session));
    	
        userInfo.setRegId(getWriter(session));
        return userInfoService.add(userInfo);
    }
    
    @PostMapping(value = "/loginuser", produces = {"application/json"})
    @ResponseBody
    @ResponseStatus(HttpStatus.CREATED)
    public Object addLoginUser(@RequestBody HashMap<String, String> param, HttpSession session) throws Exception {
    	logger.info("[INFO] ########### userInfo="+ param.toString());
    	logger.info("[INFO] ########### regId="+ getWriter(session));
    	param.put("reg_id", getWriter(session));
        //userInfo.setRegId(getWriter(session));
        return userInfoService.addLoginUser(param);
    }
    
    

    private String getWriter(HttpSession session) {
        return (String) session.getAttribute("EMPL_ID");
    }
    
	@GetMapping("/motpuser")
    @ResponseBody
    public Object findmotpuserByPagination(UserInfoSearchCondition searchCondition) throws Exception {
        return userInfoService.findByMotpUserPagination(searchCondition);
    }
    
    @GetMapping("/motpuser/{loginId}")
    @ResponseBody
    public HashMap<String, Object> getmotpuser(@PathVariable("loginId") String loginId) throws Exception {
        return userInfoService.getMotpUser(loginId);
    }
    
    @GetMapping("/motpuser/{loginId}/count")
    @ResponseBody
    public int getmotpuserCount(@PathVariable("loginId") String loginId) throws Exception {
        return userInfoService.getMotpUserCount(loginId);
    }
    
    @PutMapping(value = "/motpuser", produces = {"application/json"})
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public Object modifymotpuser(@RequestBody Map<String, Object> param, HttpSession session) throws Exception {

    	logger.info("[INFO] ########### userInfo="+param.toString());
    	
    	param.put("mod_id", getWriter(session));
    	
    	
        return userInfoService.modifyMotpUser(param);
    }
   
    @DeleteMapping("/motpuser/remove/{userId}")
    @ResponseBody
    public Object removemotpuser(@PathVariable("userId") String[] userIdArr, HttpSession session) throws Exception {
    	logger.info("[INFO] ########### emplId="+userIdArr);
    	
        return userInfoService.removeMotpUser(userIdArr, session);
    }

    @PostMapping(value = "/motpuser", produces = {"application/json"})
    @ResponseBody
    @ResponseStatus(HttpStatus.CREATED)
    public Object addmotpuser(@RequestBody HashMap<String, String> param, HttpSession session) throws Exception {
    	logger.info("[INFO] ########### userInfo="+ param.toString());
    	logger.info("[INFO] ########### regId="+ getWriter(session));
    	param.put("reg_id", getWriter(session));
        //userInfo.setRegId(getWriter(session));
        return userInfoService.addMotpUser(param);
    }
    
}
