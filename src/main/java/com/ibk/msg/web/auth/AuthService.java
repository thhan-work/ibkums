package com.ibk.msg.web.auth;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.collections.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.base.Preconditions;
import com.ibk.msg.common.dto.NoPaginationResponse;
import com.ibk.msg.common.dto.PaginationResponse;
import com.ibk.msg.web.message.MessageService;

@Component
@PropertySources({
	@PropertySource("classpath:local.properties")
	, @PropertySource(value="classpath:${spring.profiles.active}.properties", ignoreResourceNotFound=true)
})
public class AuthService {

	private static final Logger logger = LoggerFactory.getLogger(MessageService.class);

	@Autowired
	private AuthDao authDao;

	/**
	 * 권한조회
	 * @param searchCondition
	 * @return
	 * @throws Exception
	 */
	public NoPaginationResponse authList(AuthSearchCondition searchCondition) throws Exception {
		NoPaginationResponse rslt = new NoPaginationResponse();
		List<AuthMgmtList> authList = null;
		
		String dtlEmplId = searchCondition.getInfoEmplId();
		if(dtlEmplId != null) {
			authList = authDao.selectEmpAuthList(searchCondition);
		} else {
			authList = authDao.selectAuthList(searchCondition);
		}
		
		rslt.setData(authList);
		
		return rslt;
	}
	
	/**
	 * 권한 사용자 목록 조회
	 * @param searchCondition
	 * @return
	 */
	public PaginationResponse authUserList(AuthSearchCondition searchCondition) throws Exception {
		Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
		Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");

		int totalCount = authDao.selectAuthUserTotalCount(searchCondition);
		List<TAuthUser> userList = authDao.selectAuthUserList(searchCondition);

		return new PaginationResponse(searchCondition, totalCount, userList);
	}
	
	/**
	 * 권한 사용자 정보 조회
	 * @param searchCondition
	 * @return
	 */
	public TAuthUser authUserInfo(AuthSearchCondition searchCondition) {
		return authDao.selectAuthUser(searchCondition);
	}
	
	/**
	 * 권한 사용자 > 직원 조회
	 * @param searchCondition
	 * @return
	 */
	public Object authEmpList(AuthSearchCondition searchCondition) {
		Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
	    Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");
	    
	    int totalCount = authDao.selectAuthEmpTotalCount(searchCondition);
		List<TAuthUser> empList = authDao.selectAuthEmpList(searchCondition);
		
		return new PaginationResponse(searchCondition, totalCount, empList);
	}

	/**
	 * 권한 사용자 저장
	 * @param tAuthUser
	 * @return
	 */
	@Transactional(transactionManager = "ibkSmsTxManager")
	public Map<String, Object> saveAuthUser(TAuthUser tAuthUser) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		String result = "FAIL";
		
		// 권한 사용자 조회
		AuthSearchCondition param = new AuthSearchCondition();
		param.setInfoEmplId(tAuthUser.getEmplId());
		TAuthUser user = authDao.selectAuthUser(param);
		
		// 권한 사용자 등록
		if(user == null) {
			authDao.insertAuthUser(tAuthUser);
			result = "SUCCESS";
		} else {
			resultMap.put("message", "이미 등록된 사용자입니다.");
		}
		
		resultMap.put("result", result);
		return resultMap;
	}

	/**
	 * 권한 사용자 삭제
	 * @param tAuthUser
	 * @return
	 */
	@Transactional(transactionManager = "ibkSmsTxManager")
	public Map<String, Object> deleteAuthUser(TAuthUser tAuthUser) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		String result = "FAIL";
		
		List<String> emplIdList = tAuthUser.getEmplIdList();
		
		if(CollectionUtils.isNotEmpty(emplIdList)) {
			for(String emplId : emplIdList) {
				// 1. 권한사용자 부여된 권한 삭제
				TAuthGrant param = new TAuthGrant();
				param.setEmplId(emplId);
				authDao.deleteAuthGrant(param);
				
				// 2. 권한사용자 삭제
				authDao.deleteAuthUser(emplId);
			}
		}
		
		result = "SUCCESS";
		resultMap.put("result", result);
		return resultMap;
	}

	/**
	 * 권한 일괄 부여
	 * @param tAuthGrant
	 * @return
	 */
	@Transactional(transactionManager = "ibkSmsTxManager")
	public Map<String, Object> groupEmplAuthGrant(TAuthGrant tAuthGrant) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		String result = "FAIL";
		
		List<String> authIdList = tAuthGrant.getAuthIdList();
		List<String> emplIdList = tAuthGrant.getEmplIdList();
		
		if(CollectionUtils.isNotEmpty(emplIdList)) {
			for(String authEmplId : emplIdList) {
				tAuthGrant.setEmplId(authEmplId);
				
				if(CollectionUtils.isNotEmpty(authIdList)) {
					for(String authId : authIdList) {
						tAuthGrant.setAuthId(authId);
						
						// 1. 해당직원의 해당권한 조회
						List<TAuthGrant> grantList = authDao.getEmplId(tAuthGrant);
						
						// 2. 권한 저장
						if(CollectionUtils.isEmpty(grantList)) {
							authDao.insertAuthGrant(tAuthGrant);
						}
					}
				}
			}
		}
		
		result = "SUCCESS";
		resultMap.put("result", result);
		return resultMap;
	}

	/**
	 * 해당 직원의 권한 부여
	 * @param tAuthGrant
	 * @return
	 */
	@Transactional(transactionManager = "ibkSmsTxManager")
	public Map<String, Object> oneEmplAuthGrant(TAuthGrant tAuthGrant) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		String result = "FAIL";
		
		List<String> authIdList = tAuthGrant.getAuthIdList();
		List<String> emplIdList = tAuthGrant.getEmplIdList();
		
		// empId 중복 제거 
		Set<String> set = new HashSet<String>(emplIdList);         
		List<String> newEmplIdList =new ArrayList<String>(set);
		
		if(CollectionUtils.isNotEmpty(newEmplIdList)) {
			for(String authEmplId : newEmplIdList) {
				tAuthGrant.setEmplId(authEmplId);
				
				// 1. 해당 직원의 부여된 권한 조회
				List<TAuthGrant> grantList = authDao.getEmplId(tAuthGrant);
				
				// 2. 권한 존재 시, 일괄 삭제
				if(CollectionUtils.isNotEmpty(grantList)) {
					authDao.deleteAuthGrant(tAuthGrant);
				}
				
				// 3. 해당 직원의 권한 등록
				if(CollectionUtils.isNotEmpty(authIdList)) {
					for(String authId : authIdList) {
						tAuthGrant.setAuthId(authId);
						authDao.insertAuthGrant(tAuthGrant);
					}
				}
			}
		}
		
		result = "SUCCESS";
		resultMap.put("result", result);
		return resultMap;
	}
}
