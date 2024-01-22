package com.ibk.msg.web.loginhistory;

import java.util.HashMap;
import java.util.List;

import com.ibk.msg.config.database.IbkRepository;

@IbkRepository
public interface LoginHistoryDao {
	int findLogHistoryTotalCount(LoginHistorySearchCondition param);
	List<HashMap<String,Object>> findLogHistory(LoginHistorySearchCondition param);
	int insertLogHistory(HashMap<String,Object> param);
}
