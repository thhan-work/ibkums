package com.ibk.msg.web.fax;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ibk.msg.config.database.IbkRepository;

@IbkRepository
public interface FaxDao {
	
  int findTotalCount(FaxSearchCondition searchCondition);

  List<Fax> findAllMessage(FaxSearchCondition searchCondition);
  
  int successCount(FaxSearchCondition searchCondition);

  List<HashMap<String, String>> checkLogin(String loginInfoType);
  HashMap<String, String> loginCheck(String id);
  void updateLoginDt(String id);
  void updateLoginFailCn(String id);
//  AllMessage detail(AllMessage allmessage);

  int unitModify(Map<String, Object> param);

}
