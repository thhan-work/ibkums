package com.ibk.msg.web.reservedmessage;

import com.ibk.msg.config.database.IbkRepository;
import java.util.List;

@IbkRepository
public interface ReservedMessageDao {
  int findTotalCount(ReservedMessageSearchCondition searchCondition);

  List<ReservedMessage> findReservedMessage(ReservedMessageSearchCondition searchCondition);

  int cancel(ReservedMessage reservedmessage);

}
