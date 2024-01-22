package com.ibk.msg.web.rcsBrand;

import lombok.Data;

@Data
public class RcsBrandChatbot {
	private String rnum;   
	
	private String brId;                    /* 브랜드ID 	*/                                     
	private String chatbotId;               /* 챗봇ID 	*/                                     
	private String subNum;                  /* 챗봇번호  	*/                                     
	private String subTitle;                /* 챗봇이름  	*/                                     
	private String display;                 /* 표시  	*/                                     
	private String rcsReply;                /* SMS MO 수신 0, RCS MO 수신 1 	*/                 
	private String mainnumYn;               /* 대표여부 (Y, N) 	*/                             
	private String status;                  /* 챗봇상태 승인대기,승인완료,승인거절,published 	*/             
	private String grpId;                   /* 그룹ID 	*/                                     
	private String apprYmd;                 /* 승인일시 	*/                                     
	private String apprResult;              /* 승인결과 	*/                                     
	private String apprReason;              /* 승인이유 	*/                                     
	private String regUserId;               /* 등록자 ID 	*/
	
	private String regUserNm;               /* 등록자 명 	*/
	
	private String regDt;                   /* 등록일시 	*/                                     
	private String updateUserId;            /* 수정자 ID 	*/                                     
	private String updateDt;                /* 수정일시 	*/
	
	private String brandId; /* param의 브랜드 ID */
	
	private String emplId; // 직원번호
	
}
