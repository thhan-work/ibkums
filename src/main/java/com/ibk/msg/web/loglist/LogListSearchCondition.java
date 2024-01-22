package com.ibk.msg.web.loglist;

import com.ibk.msg.common.dto.PaginationCondition;

import lombok.Data;


@Data
public class LogListSearchCondition extends PaginationCondition {

  private String searchStartDt;
  private String searchEndDt;
  private String regDt;
  private String messageType; //메시지 구분
  private String draftStatus; //기안상태
  private String draftName; //기안명
  private String boCode; // 업무코드
  private String emplId; // 직원번호
}
