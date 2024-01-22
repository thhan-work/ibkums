package com.ibk.msg.web.confirmlist;

import com.ibk.msg.common.dto.PaginationCondition;

import lombok.Data;


@Data
public class ConfirmListSearchCondition extends PaginationCondition {

  private String searchStartDt;
  private String searchEndDt;
  private String regDt;
  private String messageType; //메시지 구분
  private String draftStatus; //기안상태
  private String draftName; //기안명
  private String boCode; // 업무코드
  private String emplId; // 직원번호
  private String userClass; // 유저등급         관리자 : A, 일반 : N, 승인권자 : P, 직원용SMS : S

  private String groupUniqNo;	 	//그룹고유번호
  private String agreeType;			// 승인 구분 (1차, 2차, 3차)
  private String agreeStatus;			// 승인 상태 (I 진행중, G 승인, N 반려)
  private String modifyReason;		// 수정/반려 사유
  private String prcssStusDstic;		// T21 처리 상태 값
  private String agreeId;		// 승인자 ID
}
