package com.ibk.msg.web.reservedmessage;

import com.ibk.msg.common.dto.PaginationCondition;
import lombok.Data;

@Data
public class ReservedMessageSearchCondition extends PaginationCondition {
  private String searchSendStatus;
  private String searchPhoneNumber;
  private String searchStartDt;
  private String searchEndDt;
  private String regDt;
  private String boCode; // 업무코드
  private String emplId; // 직원번호
  
  private String emplIp; // 직원IP
}
