package com.ibk.msg.web.allmessage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ibk.msg.config.database.IbkRepository;
import com.ibk.msg.web.template.TemplateSearchCondition;

@IbkRepository
public interface AllMessageDao {
	
  int findTotalCount(AllMessageSearchCondition searchCondition);
  int findTotalCount2(AllMessageSearchCondition searchCondition);

  List<AllMessage> findAllMessage(AllMessageSearchCondition searchCondition);
  List<AllMessage> findAllMessage2(AllMessageSearchCondition searchCondition);
  
  int successCount(AllMessageSearchCondition searchCondition);

  List<HashMap<String, String>> checkLogin(String loginInfoType);
  HashMap<String, Object> loginCheck(String id);
  void updateLoginDt(String id);
  void updateLoginFailCn(String id);
//  AllMessage detail(AllMessage allmessage);

  int unitModify(Map<String, Object> param);
  
  HashMap<String, Object> motpCheck(String id);
  void updateMotpDt(String id);
  void updateMotpFailCn(String id);
  
  Map<String, Object> crmview(AllMessageSearchCondition searchCondition);
  Map<String, Object> crmview2(AllMessageSearchCondition searchCondition);
}
