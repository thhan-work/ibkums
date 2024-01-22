package com.ibk.msg.web.loginhistory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.ibk.msg.common.dto.PaginationResponse;

@Component
public class LoginHistoryService {
	
	private static final Logger logger = LoggerFactory.getLogger(LoginHistoryService.class);
	
	@Autowired
	private LoginHistoryDao loginHistoryDao;
	
	public int insertLogHistory(String login_type, String emp_no, String ip, String login_result) {
		HashMap<String,Object> param = new HashMap<String, Object>();
		param.put("LOGIN_TYPE", login_type);
		param.put("EMP_NO", emp_no);
		param.put("IP", ip);
		param.put("LOGIN_RESULT", login_result);
		
		int ret = loginHistoryDao.insertLogHistory(param);
		return ret;
	}
	
    public PaginationResponse findByPagination(LoginHistorySearchCondition param)
            throws Exception {
        
        int totalCount = loginHistoryDao.findLogHistoryTotalCount(param);
        List<HashMap<String,Object>> users = loginHistoryDao.findLogHistory(param);
        return new PaginationResponse(param, totalCount, users);
        
    }


}
