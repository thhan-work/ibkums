package com.ibk.msg.web.email;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ibk.msg.config.database.IbkRepository;

@IbkRepository
public interface EmailDao {
	
  int findTotalCount(EmailSearchCondition searchCondition);

  List<Email> findAllMessage(EmailSearchCondition searchCondition);
  
  int successCount(EmailSearchCondition searchCondition);

  List<HashMap<String, String>> checkLogin(String loginInfoType);
  HashMap<String, String> loginCheck(String id);
  void updateLoginDt(String id);
  void updateLoginFailCn(String id);
//  AllMessage detail(AllMessage allmessage);

  int unitModify(Map<String, Object> param);

  int resendUpdate(Email email);

}
