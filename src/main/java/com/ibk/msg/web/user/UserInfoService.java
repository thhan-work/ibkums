package com.ibk.msg.web.user;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.base.Preconditions;
import com.ibk.msg.common.dto.PaginationResponse;

@Component
public class UserInfoService {

    @Autowired
    private UserInfoDao dao;


    public PaginationResponse findByPagination(UserInfoSearchCondition searchCondition)
            throws Exception {
        Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
        Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");

        int totalCount = dao.findTotalCount(searchCondition);
        List<UserInfo> users = dao.findUser(searchCondition);
        return new PaginationResponse(searchCondition, totalCount, users);
    }
    
    public PaginationResponse findByLoginUserPagination(UserInfoSearchCondition searchCondition)
            throws Exception {
        Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
        Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");

        int totalCount = dao.findTotalLoginUserCount(searchCondition);
        List<HashMap<String,String>> users = dao.findLoginUser(searchCondition);
        return new PaginationResponse(searchCondition, totalCount, users);
    }

    @Transactional(transactionManager = "ibkSmsTxManager")
    public Set remove(String[] emplIdArr, String requestType, HttpSession session) {
    	Preconditions.checkArgument(StringUtils.isNoneBlank(emplIdArr), "emplId is empty");
    	Preconditions.checkArgument(StringUtils.isNoneBlank(requestType), "requestType is empty");
    	
        Set resultSet = new HashSet();
        for (String emplId : emplIdArr) {
        	UserInfo userInfo = new UserInfo();
        	userInfo.setEmplId(emplId);
        	userInfo.setModId(session.getAttribute("EMPL_ID").toString());
        	
        	//1. 해당 타입에 맞게 값 수정
        	// ㅁ USER_INFO 1 row에 세가지 정보가 같이 들어감
        	//   - SMS발송 : EMPL_IP NOT NULL
        	//   - 관리자 : ADMIN_YN = 'Y'
        	//   - 승인자 : USER_LEVEL = '2' or '3'
        	if(requestType.equals("send")){// SMS발송
        		userInfo.setRequestType(requestType);
        		userInfo.setEmplIp(null);
        		userInfo.setUseYn("N");
        		userInfo.setEmplYn("N");
        	}else if(requestType.equals("admin")){// 관리자
        		userInfo.setRequestType(requestType);
        		userInfo.setAdminYn("N");
        	}else if(requestType.equals("ack")){// 승인자
        		userInfo.setRequestType(requestType);
        		userInfo.setUserLevel("9");
        	}
        	dao.modify(userInfo);
        	
        	//2. 세가지 타입 모두 해당 사항 없을 경우 삭제
            dao.remove(userInfo);
            resultSet.add(emplId);
        }
        return resultSet;
    }
    
    @Transactional(transactionManager = "ibkSmsTxManager")
    public Set removeLoginUser(String[] userIdArr, HttpSession session) {
    	Preconditions.checkArgument(StringUtils.isNoneBlank(userIdArr), "emplId is empty");
    	
        Set resultSet = new HashSet();
        for (String userId : userIdArr) {
            dao.removeLoginUser(userId);
            resultSet.add(userId);
        }
        return resultSet;
    }
    
    
    public String add(UserInfo userInfo) {
        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getEmplId()), "emplId is empty");

        dao.add(userInfo);
        return userInfo.getEmplId();
    }
    
    public String addLoginUser(HashMap<String,String> param) {
      //  Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getEmplId()), "emplId is empty");

        dao.addLoginUser(param);
        return param.get("login_id");
    }


    public Object modify(UserInfo userInfo) {
        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getEmplId()), "emplId is empty");

        dao.modify(userInfo);
        return userInfo.getEmplId();
    }

    public UserInfo findDetail(String emplId) {
        return dao.findDetail(emplId);
    }

    public int findDetailCount(String emplId) {
        return dao.findDetailCount(emplId);
    }
    public int getLoginUserCount(String loginId) {
        return dao.getLoginUserCount(loginId);
    }
    
    public HashMap<String, Object> getLoginUser(String loginId) {
        return dao.getLoginUser(loginId);
    }

	public Object modifyLoginUser(Map<String, Object> param) {
		HashMap<String, Object> ori=dao.getLoginUser((String)param.get("login_id"));
		String use_yn=(String) ori.get("USE_YN");
		if(!use_yn.equals((String)param.get("use_yn"))) {
			param.put("use_yn_cn", "Y");
		}
		return dao.modifyLoginUser(param);
	}
	
	public int changePasswordLoginUser(Map<String, Object> param) {
		return dao.changePasswordLoginUser(param);		
	}
	
    public PaginationResponse findByMotpUserPagination(UserInfoSearchCondition searchCondition)
            throws Exception {
        Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
        Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");

        int totalCount = dao.findTotalMotpUserCount(searchCondition);
        List<HashMap<String,String>> users = dao.findMotpUser(searchCondition);
        return new PaginationResponse(searchCondition, totalCount, users);
    }
    
    @Transactional(transactionManager = "ibkSmsTxManager")
    public Set removeMotpUser(String[] userIdArr, HttpSession session) {
    	Preconditions.checkArgument(StringUtils.isNoneBlank(userIdArr), "emplId is empty");
    	
        Set resultSet = new HashSet();
        for (String userId : userIdArr) {
            dao.removeMotpUser(userId);
            resultSet.add(userId);
        }
        return resultSet;
    }
    
    public String addMotpUser(HashMap<String,String> param) {
      //  Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getEmplId()), "emplId is empty");

        dao.addMotpUser(param);
        return param.get("login_id");
    }

    public int getMotpUserCount(String loginId) {
        return dao.getMotpUserCount(loginId);
    }
    
    public HashMap<String, Object> getMotpUser(String loginId) {
        return dao.getMotpUser(loginId);
    }

	public Object modifyMotpUser(Map<String, Object> param) {
		HashMap<String, Object> ori=dao.getMotpUser((String)param.get("login_id"));
		String use_yn=(String) ori.get("USE_YN");
		if(!use_yn.equals((String)param.get("use_yn"))) {
			param.put("use_yn_cn", "Y");
		}
		return dao.modifyMotpUser(param);
	}

}
