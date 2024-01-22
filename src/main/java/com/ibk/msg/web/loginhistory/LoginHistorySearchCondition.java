package com.ibk.msg.web.loginhistory;

import com.ibk.msg.common.dto.PaginationCondition;

import lombok.Data;


@Data
public class LoginHistorySearchCondition extends PaginationCondition {

  private String EMP_NO;
  
  
  
}
