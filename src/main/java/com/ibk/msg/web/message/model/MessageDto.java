package com.ibk.msg.web.message.model;

public class MessageDto {
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
 
	//경조사보내기 직급 코드
	private String emplClass;
	//경조사보내기 직위 명
	private String emplPositionName;
	
	public String getUniqueKey() {
		return uniqueKey;
	}
	public void setUniqueKey(String uniqueKey) {
		this.uniqueKey = uniqueKey;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getSendType() {
		return sendType;
	}
	public void setSendType(String sendType) {
		this.sendType = sendType;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getMmsTitle() {
		return mmsTitle;
	}
	public void setMmsTitle(String mmsTitle) {
		this.mmsTitle = mmsTitle;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getMsgByte() {
		return msgByte;
	}
	public void setMsgByte(String msgByte) {
		this.msgByte = msgByte;
	}
	public Integer getSendCount() {
		return sendCount;
	}
	public void setSendCount(Integer sendCount) {
		this.sendCount = sendCount;
	}
	public String getReserveDate() {
		return reserveDate;
	}
	public void setReserveDate(String reserveDate) {
		this.reserveDate = reserveDate;
	}
	public String getReceivers() {
		return receivers;
	}
	public void setReceivers(String receivers) {
		this.receivers = receivers;
	}
	public String getMsgType() {
		return msgType;
	}
	public void setMsgType(String msgType) {
		this.msgType = msgType;
	}
	public String getIsAd() {
		return isAd;
	}
	public void setIsAd(String isAd) {
		this.isAd = isAd;
	}
	public String getUserAd() {
		return userAd;
	}
	public void setUserAd(String userAd) {
		this.userAd = userAd;
	}
	//영리목적 마케팅 수신거부 080 번호 추가를 위한 값(2013.09.30 PWY)
	public String getMtype() {
		return mType;
	}
	public void setMtype(String mType) {
		this.mType = mType;
	}
	//두낫콜 관련
	public String getCusType() {
		return cusType;
	}
	public void setCusType(String cusType) {
		this.cusType = cusType;
	}
	//20150514 정보공개구분코드추가
	public String getInfocd() {
		return Infocd;
	}
	public void setInfocd(String Infocd) {
		this.Infocd = Infocd;
	}
	public String getEmplClass() {
		return emplClass;
	}
	public void setEmplClass(String emplClass) {
		this.emplClass = emplClass;
	}
	public String getEmplPositionName() {
		return emplPositionName;
	}
	public void setEmplPositionName(String emplPositionName) {
		this.emplPositionName = emplPositionName;
	}
	@Override
	public String toString() {
		return "MessageDto [uniqueKey=" + uniqueKey + ", sender=" + sender + ", sendType=" + sendType + ", title="
				+ title + ", mmsTitle=" + mmsTitle + ", message=" + message + ", msgByte=" + msgByte + ", sendCount="
				+ sendCount + ", reserveDate=" + reserveDate + ", receivers=" + receivers + ", msgType=" + msgType
				+ ", isAd=" + isAd + ", userAd=" + userAd + ", mType=" + mType + ", cusType=" + cusType + ", Infocd="
				+ Infocd + ", emplClass=" + emplClass + ", emplPositionName=" + emplPositionName + "]";
	}
	
	
}