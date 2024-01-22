package com.ibk.msg.web.smsreq;

import lombok.Data;

@Data
public class FileHeadData {
	private String groupUniqNo;  // 그룹고유번호
	private String msgDstic;     // 메시지 타입 (SM/LM/MM)
	private String sndrTelno;    // 발신번호
	private String msgCtnt;      // 메시지 내용 (LMS/MMS는 제목)
	private String umsMsgCtnt;   // UMS메시지 내용
	private String imageCount;   // 이미지 파일 갯수
	private byte[] image1;       
	private byte[] image2;
	private byte[] image3;
	private String imagePath1;   // 파일경로1
	private String imagePath2;   // 파일경로2
	private String imagePath3;   // 파일경로3

	
	public FileHeadData smsReqDataToFileHeadData(SmsReqData smsReqData){
		FileHeadData fileHeadData = new FileHeadData();
		
		fileHeadData.setGroupUniqNo(smsReqData.getGroupUniqNo());
		fileHeadData.setMsgDstic(smsReqData.getMsgDstic());
		fileHeadData.setSndrTelno(smsReqData.getSndrTelno());
		fileHeadData.setMsgCtnt(smsReqData.getMsgCtnt());
		fileHeadData.setUmsMsgCtnt(smsReqData.getUmsMsgCtnt());
		fileHeadData.setImageCount(smsReqData.getImageCount());
		fileHeadData.setImagePath1(smsReqData.getImagePath1());
		fileHeadData.setImagePath2(smsReqData.getImagePath2());
		fileHeadData.setImagePath3(smsReqData.getImagePath3());
		
		return fileHeadData;
	}
}
