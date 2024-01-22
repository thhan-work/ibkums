package com.ibk.msg.web.eventsend;

import java.util.HashMap;
import java.util.List;

import com.ibk.msg.config.database.IbkRepository;
import com.ibk.msg.web.message.model.MsgSendInfo;

@IbkRepository
public interface EventSendDao {

	List<HashMap<String, String>> checkLogin();
	List<PartInfo> getClassList();
	List<PartInfo> getPositionList();
	List<PartInfo> getUserListDCon(PartInfo request_partinfo);
	List<PartInfo> getPartList(PartInfo request_partinfo);
	List<MsgSendInfo> getTargetAllList(MsgSendInfo request_msgsendinfo);
	List<MsgSendInfo> getTargetAreaList(PartInfo request_partinfo);

}

