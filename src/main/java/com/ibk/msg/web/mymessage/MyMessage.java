package com.ibk.msg.web.mymessage;

import lombok.Data;

@Data
public class MyMessage {
	
  private String id;
  private String messageType; //메시지구분
  private String phoneNumber; //핸드폰번호
  private String subject; // 메시지제목
  private String msg; //메시지내용
  private String startDate; //발송일 시작
  private String endDate; //발송일 끝
  private String regDt; //발송일(yyyymm형태)
  private char disYn; //디스플레이유무 (ETC2)
  private String sendRslt; //전송상태
  private String tranStatus;
  private String callBack;
  private String etc5; // 수신자명
  
  private String boCode; // 업무코드

  private String tranRefkey; // 실명번호
  private String unitSystemName; //발송시스템 이름
  private String custName;
  
  //MessageInfo
  private String tranCallback; //회신번호
  private String tranDate; //전송일자(sysdate)
  private String tranMsg; //메시지내용
  private String unitCode; //sms 업무시스템코드
  private String desCode; //SMS 업무시스템 세부 코드 또는 영업점 코드
  private String emplId; // 직원아이디
  private String partName; // 부서이름
  private String isAD; // 광고 여부(일반 메시지: 0, 광고 메시지: 1)
  private String userAD; // 서비스 품질보증서 신청고객 여부(미신청자: 0, 신청자: 1)
  private String emplClass; // 직급 코드(전체: ALL)
  private String emplPositionName; // 직급 코드(전체: ALL)
  
  //MessageDto
  private String uniqueKey;
	private String sender;
	private String sendType;
	private String title;
	private String mmsTitle;
	private String message;
	private String msgByte;
	private Integer sendCount;
	private String reserveDate;
	private String receivers;
	private String msgType;
	private String isAd; // 일반 메시지: 0, 광고 메시지: 1
	private String userAd; // 서비스 품질보증서 신청고객 여부(미신청자: 0, 신청자: 1)
	private String mType;  // CRM 고객 발송종류(고객관리 : 1, 카드마케팅 : 2, 일반마케팅(영리목적마케팅) : 3)(2013.09.30)
	private String cusType; // 발송 종류 선택(두낫콜 서비스 관련 / 2014.09.16)
	private String Infocd; // 정보공개구분코드추가(2015.05.14)
	
	
	//MsgSendRcv
	private String rcvFileCt; //수신할파일갯수
	private String rcvFileName; // 수신할 파일 사이즈
	private String rcvFileSize; // 수신할 파일 사이즈
	
	
	
}
