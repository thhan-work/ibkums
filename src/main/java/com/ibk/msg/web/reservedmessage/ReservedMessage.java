package com.ibk.msg.web.reservedmessage;

import lombok.Data;

@Data
public class ReservedMessage {
  private int id;
  private int seq;
  private String messageType; //메시지유형
  private String phoneNumber; //핸드폰번호
  private String subject; // 메시지제목
  private String msg; //메시지내용
  private String startDate; //발송일 시작
  private String endDate; //발송일 끝
  private String regDt; //발송일(yyyymm형태)
  private char disYn; //디스플레이유무 (ETC2)
  private String sendStatus; //전송상태
  private String callBack;
  private String boCode; // 업무코드
  private String emplId; // 직원번호
  
  private String etc5; //수신 고객명
}
