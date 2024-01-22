package com.ibk.msg.web.mymessage;

import java.util.List;

import com.ibk.msg.config.database.IbkRepository;
import com.ibk.msg.web.message.model.MsgSend;

@IbkRepository
public interface MyMessageDao {
  int findTotalCount(MyMessageSearchCondition searchCondition);

  List<MyMessage> findMyMessage(MyMessageSearchCondition searchCondition);

  int remove(MyMessage mymessage);

  int resend(MyMessage mymessage);
  
  int sendSMS(MsgSend mymessage);
  
  int logSMS(MsgSend mymessage);
	
  int sendMMS(MsgSend mymessage);
	
  int logMMS(MsgSend mymessage);

  String getCutOption(String rcvPhone);

  String getOpt(String unitCode);
  
}
