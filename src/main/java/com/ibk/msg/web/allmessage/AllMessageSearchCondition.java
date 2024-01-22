package com.ibk.msg.web.allmessage;

import com.ibk.msg.common.dto.PaginationCondition;

import lombok.Data;


@Data
public class AllMessageSearchCondition extends PaginationCondition {

  private String searchStartDt;
  private String searchEndDt;
  private String regDt;
  private String messageType; //메시지 구분
  private String boCode; // 업무코드
  private String emplId; // 직원번호
  private String emplIp; // 직원IP
  private String searchPhoneNumber; // 핸드폰 번호
  private String msgKey;
  private String msgType;
  private String telNo;
}
