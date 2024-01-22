package com.ibk.msg.web.loglist;

import java.util.HashMap;
import java.util.List;

import com.ibk.msg.config.database.IbkRepository;

@IbkRepository
public interface LogListDao {
	
  int findTotalCount(LogListSearchCondition searchCondition);

  List<LogList> findLogList(LogListSearchCondition searchCondition);
  
  LogList findDetail(String smssendlistId);
  
  void recordLog(HashMap<String, String> pram);
  void msgHistoryLog(HashMap<String, String> pram);
  
}
