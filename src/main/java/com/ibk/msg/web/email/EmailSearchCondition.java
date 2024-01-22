package com.ibk.msg.web.email;

import com.ibk.msg.common.dto.PaginationCondition;

import lombok.Data;


@Data
public class EmailSearchCondition extends PaginationCondition {

  private String searchStartDt;
  private String searchEndDt;
  private String regDt;
  private String messageType; //메시지 구분
  private String boCode; // 업무코드
  private String emplId; // 직원번호
  private String emplIp; // 직원IP
  private String searchWordType; // 조회 조건
  private String searchWord; // 조회 값
  
  private String emailType;	// emarketing: 본부 대량메일 발송내역, ecare : 고객 스케쥴 메일 발송내역
}
