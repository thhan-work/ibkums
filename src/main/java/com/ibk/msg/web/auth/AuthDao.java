package com.ibk.msg.web.auth;

import java.util.List;

import com.ibk.msg.config.database.IbkRepository;

@IbkRepository
public interface AuthDao {
  List<AuthMgmtList> selectAuthList(AuthSearchCondition searchCondition);
  List<AuthMgmtList> selectEmpAuthList(AuthSearchCondition searchCondition);
  void deleteAuthGrant(TAuthGrant tAuthGrant);
  List<TAuthGrant> getEmplId(TAuthGrant tAuthGrant);
  int selectAuthUserTotalCount(AuthSearchCondition searchCondition);
  List<TAuthUser> selectAuthUserList(AuthSearchCondition searchCondition);
  TAuthUser selectAuthUser(AuthSearchCondition searchCondition);
  List<TAuthUser> selectAuthEmpList(AuthSearchCondition searchCondition);
  void updateAuthUser(TAuthUser tAuthUser);
  void insertAuthUser(TAuthUser tAuthUser);
  void deleteAuthUser(String emplId);
  int selectAuthEmpTotalCount(AuthSearchCondition searchCondition);
  void insertAuthGrant(TAuthGrant tAuthGrant);
}
