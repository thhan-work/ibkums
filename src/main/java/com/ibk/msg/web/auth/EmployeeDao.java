package com.ibk.msg.web.auth;

import com.ibk.msg.config.database.WebmailRepository;
import com.ibk.msg.web.user.UserInfo;

import java.util.HashMap;
import java.util.List;

@WebmailRepository
public interface EmployeeDao {
	
	HashMap<String, String> findLoginAuthInfo(String emplId);

    int findBocodeTotalCount(EmployeeInfoSearchCondition searchCondition);
    List<EmployeeInfo> findBocode(EmployeeInfoSearchCondition employeeInfoSearchCondition);
    
    UserMappingInfo findUserMappingLoginId(UserMappingInfo searchUserMapping);
	UserMappingInfo findUserMappingconnectIP(UserMappingInfo searchUserMapping);
	
    
	EmployeeInfo findDetail(String empl_id);
    int findTotalCount(EmployeeInfoSearchCondition searchCondition);
    List<EmployeeInfo> findEmployee(EmployeeInfoSearchCondition employeeInfoSearchCondition);

    UserInfo findUserInfo(String eMPL_ID);
    EmployeeInfo findDetailEmplA(String eMPL_ID);
    
    int checkEmplHp(String emplHpNo);
	
	HashMap<String, Object> loginCheck(String allmsg_id);
	void updateLoginDt(String allmsg_id);
	void updateLoginFailCn(String allmsg_id);
	
	HashMap<String, Object> motpCheck(String id);
	void updateMotpDt(String id);
	void updateMotpFailCn(String id);

}
