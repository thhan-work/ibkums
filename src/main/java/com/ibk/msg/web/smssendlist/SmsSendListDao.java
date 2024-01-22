package com.ibk.msg.web.smssendlist;

import java.util.List;
import java.util.Map;

import com.ibk.msg.config.database.IbkRepository;
import com.ibk.msg.web.smsreq.T32Data;

@IbkRepository
public interface SmsSendListDao {
	
  int findTotalCount(SmsSendListSearchCondition searchCondition);

  List<SmsSendList> findSmsSendList(SmsSendListSearchCondition searchCondition);
  
  SmsSendList findDetail(int smssendlistId);

  int remove(int groupUniqNo);
  
  int saveT21(SmsSendList smssendlist);
  
  int saveInfo(SmsSendList smssendlist);
  
  int testSend(SmsSendList smssendlist);
  
  int testSend2(SmsSendList smssendlist);
  
  int sendCount(int groupUniqNo);
  
  int selectT30(SmsSendList smssendlist);
 
  int selectT32(T32Data data);
  
  int selectT32(SmsSendList smssendlist);
  
  int removeT30(SmsSendList smssendlist);
  
  int removeT32(SmsSendList smssendlist);
  
  int removeT30(int groupUniqNo);
  
  int removeT32(int groupUniqNo);
  
  int deleteT32(SmsSendList smssendlist);

  int saveT30(SmsSendList smssendlist);
  
  int saveT32(SmsSendList smssendlist);
  
  int insertT32(SmsSendList smssendlist);
  
  int inT32(SmsSendList smssendlist);
  
  int updateStatus(SmsSendList smssendlist);
  
  List<SmsSendList> confirmSelect(int groupUniqNo);
  
  List<SmsSendList> sendConfirmSelect(int groupUniqNo);
  
  List<SmsSendList> digitalConfirmSelect(int groupUniqNo);
  
  List<SmsSendList> cmsConfirmSelect(int groupUniqNo);
  
  List<SmsSendList> userInfoLevel2(int groupUniqNo);
  
  List<SmsSendList> userInfoLevel3(int groupUniqNo);
  
  int agreeSelect(int groupUniqNo);
  
  int selectFourthDisagree(int groupUniqNo);

  int confirmUpdate(int groupUniqNo, String emplId);
  
  String confirmSelectSatus(int groupUniqNo, String emplId);
  
  int saveInst(SmsSendList smssendlist);

  String confirmT21Satus(int groupUniqNo);

  int selectT26DoneCheck(int groupUniqNo, String stus);

  void removeT21_INFO(int groupUniqNo);
  
  int updateT21EmplID(SmsSendList smssendlist);
  
  int cancel(int groupUniqNo);

}
