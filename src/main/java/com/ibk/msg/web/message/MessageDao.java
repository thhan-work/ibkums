package com.ibk.msg.web.message;

import com.ibk.msg.config.database.IbkRepository;
import com.ibk.msg.web.message.model.MsgSend;

@IbkRepository
public interface MessageDao {

	int sendSMS(MsgSend request_msgsendinfo);
	int logSMS(MsgSend request_msgsendinfo);
	int sendMMS(MsgSend request_msgsendinfo);
	int logMMS(MsgSend request_msgsendinfo);

	String getCutOption(String rcvPhone);

	String getOpt(String unitCode);
	
	int sendSMSWithoutUnsubscribe(MsgSend request_msgsendinfo);
	int sendMMSWithoutUnsubscribe(MsgSend request_msgsendinfo);
	
	String getSeq();
	int getSMSUnsubscribeCount(MsgSend request_msgsendinfo);
	int getMMSUnsubscribeCount(MsgSend request_msgsendinfo);

}
