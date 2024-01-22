package com.ibk.msg.web.user;

import com.ibk.msg.config.database.KiupSmsRepository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@KiupSmsRepository
public interface UserInfoDao {


    int findTotalCount(UserInfoSearchCondition userInfoSearchCondition);
    List<UserInfo> findUser(UserInfoSearchCondition userInfoSearchCondition);
    void remove(UserInfo userInfo);
    void add(UserInfo userInfo);
    void modify(UserInfo userInfo);
    UserInfo findDetail(String emplId);
    int findDetailCount(String emplId);
	
	int findTotalLoginUserCount(UserInfoSearchCondition userInfoSearchCondition);
	List<HashMap<String,String>> findLoginUser(UserInfoSearchCondition userInfoSearchCondition);
	void addLoginUser(HashMap<String,String> param);
	void removeLoginUser(String userId);
	int getLoginUserCount(String loginId);
	HashMap<String, Object> getLoginUser(String loginId);	
	int modifyLoginUser(Map<String, Object> param);
	int changePasswordLoginUser(Map<String, Object> param);
	
	int findTotalMotpUserCount(UserInfoSearchCondition userInfoSearchCondition);
	List<HashMap<String,String>> findMotpUser(UserInfoSearchCondition userInfoSearchCondition);
	void addMotpUser(HashMap<String,String> param);
	void removeMotpUser(String userId);
	int getMotpUserCount(String loginId);
	HashMap<String, Object> getMotpUser(String loginId);	
	int modifyMotpUser(Map<String, Object> param);
}
