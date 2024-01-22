package com.ibk.msg.web.sendStatus;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ibk.msg.config.database.IbkRepository;
import com.ibk.msg.web.smssendlist.SendHistory;
import com.ibk.msg.web.smssendlist.SendHistorySearchCondition;

@IbkRepository
public interface SendStatusDao {
	List<String> getSaveDateList2(Map<String, Object> requestData);
	ArrayList<Map<String, Object>> selectStartDsticList(Map<String, Object> requestData);
	HashMap<String, Object> getDateTotalCnt(Map<String, Object> requestData);
	
	List<SendHistory> selectSmsSendHistoryList(SendHistorySearchCondition smssendlist);
	List<SendHistory> selectMmsSendHistoryList(SendHistorySearchCondition smssendlist);
	  
	int smsSendHistoryTotalCount(SendHistorySearchCondition searchCondition);
	int mmsSendHistoryTotalCount(SendHistorySearchCondition searchCondition);
	  
	void deleteSendStatusDRF002M(Map<String, Object> paramMap); 
	void deleteSendStatusDRF002D(Map<String, Object> paramMap); 
	void deleteSendStatusDRF004M(Map<String, Object> paramMap); 
	void deleteSendStatusDRF001M(Map<String, Object> paramMap); 
	void deleteSendStatusDRF003M(Map<String, Object> paramMap); 
	void deleteSendStatusDRF003D(Map<String, Object> paramMap);
	void updateSendStatus(Map<String, Object> requestData); 
	
}
