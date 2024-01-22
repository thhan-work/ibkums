package com.ibk.msg.web.accessmanage;

import com.ibk.msg.config.database.IbkRepository;
import java.util.List;

@IbkRepository
public interface AccessManageDao {

  List<AccessUser> findUsers(AccessManageSearchCondition searchCondition);

  int findTotalCount(AccessManageSearchCondition searchCondition);

  void addUser(AccessUser user);

  void modifyUser(AccessUser user);

  void removeUser(String empNo);

  AccessUser findDetail(String empNo);
}
