package com.ibk.msg.web.smssendlist;

import com.ibk.msg.web.smsreq.FileHeadData;

import lombok.Data;

@Data
public class SendHistory extends FileHeadData{
	
	private int rnum; 					//순번
	private String altMsgYn; 			//전환발송구분
	
	/* DIST_MMS_LOG_YYYYMM 이력테이블 */
	private String phone; 				//수신번호
	private String callback; 			//발신번호
	private String sentDate; 			//발송일시
	private String rsltDate; 			//수신일시
	private String telcoInfo; 			//이통사
	private String rslt; 				//결과
	private String msgDstic;			//메시지유형
	
	/* DIST_LOG_YYYYMM 이력테이블 */
	private String tranPhone; 			//수신번호
	private String tranCallback; 		//발신번호
	private String tranDate; 			//발송일시
	private String tranRsltDate; 		//수신일시
	private String tranNet; 			//이통사
	private String tranRslt; 			//결과
	
}
