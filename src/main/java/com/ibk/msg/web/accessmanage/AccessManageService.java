package com.ibk.msg.web.accessmanage;

import com.google.common.base.Preconditions;
import com.ibk.msg.common.dto.PaginationResponse;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class AccessManageService {

  @Autowired
  private AccessManageDao dao;

  public PaginationResponse findUsers(AccessManageSearchCondition searchCondition) {

    Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perSize is null");
    Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "pageNo is null");

    int totalCount = dao.findTotalCount(searchCondition);
    if (totalCount == 0) {
      return new PaginationResponse(searchCondition, totalCount, null);
    } else {
      List<AccessUser> users = dao.findUsers(searchCondition);
      return new PaginationResponse(searchCondition, totalCount, users);
    }
  }

  public AccessUser createUser(AccessUser user) {
    AccessUser duplicationUser = dao.findDetail(user.getEmpNo());
    if (duplicationUser == null) {
      dao.addUser(user);
    } else {
      throw new IllegalArgumentException("Duplication user");
    }
    return user;
  }

  public AccessUser modifyUser(AccessUser user) {
    dao.modifyUser(user);
    return user;
  }

  public void removeUser(String[] empNos) {
    for (String empNo : empNos) {
      dao.removeUser(empNo);
    }
  }

  public AccessUser findDetail(String empNo) {
    return dao.findDetail(empNo);
  }
}
