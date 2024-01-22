package com.ibk.msg.web.mymessage;

import com.ibk.msg.common.dto.PaginationCondition;

import lombok.Data;


@Data
public class MyMessageSearchCondition extends PaginationCondition {

  private String searchSendStatus;
  private String searchPhoneNumber;
  private String searchStartDt;
  private String searchEndDt;
  private String regDt;
  private String boCode; // 업무코드
  private String emplId; // 직원번호
  
  private String userClass; // 계정 권한
  
  private String emplIp; // 직원IP
}
