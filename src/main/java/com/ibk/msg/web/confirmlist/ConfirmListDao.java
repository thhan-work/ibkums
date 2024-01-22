package com.ibk.msg.web.confirmlist;

import java.util.HashMap;
import java.util.List;

import com.ibk.msg.config.database.IbkRepository;
import com.ibk.msg.web.smsreq.T32Data;
import com.ibk.msg.web.user.UserInfo;

@IbkRepository
public interface ConfirmListDao {
	
  int findTotalCount(ConfirmListSearchCondition searchCondition);

//  void findDetail(SmsSendList smssendlist);

  	List<ConfirmList> findConfirmList(ConfirmListSearchCondition searchCondition);
  
  	ConfirmList findDetail(String confirmlistId);

	T32Data selectAgreeTarget(HashMap<String, String> pram);
	
	List<UserInfo> selectAgreeTargetList(String agreeType);
	
	int updateT32Accept(ConfirmListSearchCondition condition);
	
	int checkAgreeAccept(ConfirmListSearchCondition condition);
	
	int insertT32Agree(ConfirmListSearchCondition condition);
	
	int updateT21Agree(ConfirmListSearchCondition condition);
	
	int updateReason_T21_INFO(ConfirmListSearchCondition condition);
  
	List<String> selectT28TargetList(HashMap<String, String> pram);

	int countT28TargetList(HashMap<String, String> pram);

	int selectTotalCntConfirm(String empl_id);

	List<T54DData> selectT54D(String empl_id);

	int insertT32AgreeTarget(String groupUniqNo, String agreeType, String target);
}
