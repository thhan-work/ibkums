package com.ibk.msg.web.rcsTemplate;

import lombok.Data;

@Data
public class RcsTemplateBase {
	private String rnum;
	
	private String msgbaseId;
 	private String msgbaseName;                  /*   메시지베이스명		*/
	private String msgbaseFormId;                   
	private String brId;                            
	private String agencyId;                     /*   대행사ID		*/
	private String productcode;                  /*   product code emum: sms/lms/mms/tmplt		*/
	private String spec;                         /*   richcard, openrichcard		*/
	private String cardType;                     /*   - Standalone - Standalone horizontal - Carousel - Description - Cell - Free		*/
	private String status;                       /*   ready : 사용 pause : 사용중지		*/
	private String inputText;                    /*   Description인 경우, 템플릿 등록시 입력한 원본 문장을 제공합니다.		*/
	private String msgbaseAttribute;             /*   통계용 속성. Messagebaseform의 [bizCondition, bizCategory,bizService] 배열  ["금융 및 보험업", "금융", "승인"] ["소매업", "유통/이커머스", "주문"] ...		*/
	private String policyInfo;                   /*   검증정보		*/
	private String guideInfo;                    /*   중계사 가이드용으로 MaaP FE에서 validation하지 않는다.		*/
	private String params;                       /*   파라미터		*/
	private String formattedString;             /*   TTA RCS 규격을 기본으로 변수부를 삽입하는 방식으로 생성함		*/
	private String apprResult;                   /*   승인결과		*/
	private String apprReason;                   /*   승인이유		*/
	private String apprDt;                       /*   승인일시		*/
	private String regUserId;                    /*   등록자		*/
	private String regDt;                        /*   등록일시		*/
	private String updateUserId;                 /*   수정자		*/
	private String updateDt;                     /*   수정일시		*/
	
	public void setRcsTemplateBase(RcsTemplate rcsReq) {
		this.msgbaseId = rcsReq.getMsgbaseId();
		this.msgbaseName = rcsReq.getMsgbaseNm();
		this.msgbaseFormId = rcsReq.getMsgbaseFormId();
		this.brId = rcsReq.getBrId();
		this.agencyId = rcsReq.getAgencyId();        
		this.productcode = rcsReq.getProductcode();     
		this.spec = rcsReq.getSpec();
		this.cardType = rcsReq.getCardType();        
        this.status = rcsReq.getStatus();          
        //this.inputText = rcsReq       
        this.msgbaseAttribute = rcsReq.getMsgbaseAttribute();
        this.policyInfo = rcsReq.getPolicyInfo();      
        this.guideInfo = rcsReq.getGuideInfo();       
        this.params = rcsReq.getParams();          
        this.formattedString = rcsReq.getFormattedString();
        this.apprResult = rcsReq.getApprResult();      
        this.apprReason = rcsReq.getApprReason();      
        //this.apprDt = rcsReq.getApprDt;          
        this.regUserId = rcsReq.getRegUserId();       
        this.regDt = rcsReq.getRegDt();           
        this.updateUserId = rcsReq.getUpdateUserId();    
        this.updateDt = rcsReq.getUpdateDt();   
	} 
}    