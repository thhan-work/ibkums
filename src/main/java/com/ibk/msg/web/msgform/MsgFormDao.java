package com.ibk.msg.web.msgform;

import java.util.List;

import com.ibk.msg.config.database.IbkRepository;

@IbkRepository
public interface MsgFormDao {

	int getMMSMsgFormListCount(MsgFormSearchCondition msgForm);
  
	List<MsgFormSearchCondition> getMMSMsgFormList(MsgFormSearchCondition msgForm);
	
	int addMMSMyMsg(MsgFormSearchCondition msgform);

	int getMMSMyMsgListCount(MsgFormSearchCondition msgform);

	List<MsgFormSearchCondition> getMMSMyMsgList(MsgFormSearchCondition msgform);

	int delMMSMyMsgList(MsgFormSearchCondition msgform);

	int deleteMMSMyMsg(MsgFormSearchCondition msgform);

	int getMMSMyListCount(MsgFormSearchCondition msgform);

	List<MsgFormSearchCondition> getMMSMyList(MsgFormSearchCondition msgform);

	int addMMSMyMsgInfo(MsgFormSearchCondition msgform);
}
