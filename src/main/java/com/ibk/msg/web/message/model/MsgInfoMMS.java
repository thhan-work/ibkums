/*
 * @(#)MsgInfo.java
 * Copyright 2008(c) kiupbank Corp. All Rights Reserved
 * and open the template in the editor.
 */
package com.ibk.msg.web.message.model;


/**
 * MMS 정보를 제공한다.
 *
 * @author www.infobank.net
 * @version 2008.12.11
 */
public class MsgInfoMMS {

    /**
     * 메시지 키
     */
    public String TRAN_MSGKEY;


    /**
     * 실명번호
     */
    public String TRAN_REFKEY;


    /**
     * 마지막 발송시스템
     */
    public String TRAN_LVIA;

    /**
     * 처음 발송시스템
     */
    public String TRAN_FVIA;



    /**
     * 메시지 아이디
     */
    public String TRAN_ID;



    /**
     * 휴대폰 번호
     */
    public String TRAN_PHONE;



    /**
     * 회신 번호
     */
    public String  TRAN_CALLBACK;



    /**
     * 전송 일자
     */
    public String TRAN_DATE;



    /**
     * 메시지 내용
     */
    public String TRAN_MSG;



    /**
     * 전송 상태
     */
    public String TRAN_STATUS;



    /**
     * 전송 결과
     */
    public String TRAN_RSLT;



    /**
     * 발송 시스템 이름
     */
    public String UNIT_SYSTEM_NAME;



    /**
     * 영업점 이름
     */
    public String PART_NAME;



    /**
     * 직원 이름
     */
    public String EMPL_NAME;



    /**
     * 고객 이름
     */
    public String CUST_NAME;
    
    
     /**
     * 제목
     */
    public String SUBJECT;
    
    
     /**
     * 파일PATH1
     */
    public String FILE_PATH1;
    
    
    /**
     * 파일SIZ
     */
    public String FILE_SIZ1;

	 
	 
    /**
	 * BLS 거래에 대한 계좌번호
	 */
	public String ETC1;

	/**
	 * BLS 거래에 대한 전행고객번호
	 */
	public String ETC3;
	
	/**  
	 * 응답시간
	 */
	public String RSLTDATE;
	
	/**
	 * 이통사 정보
	 */
	public String TELCOINFO;
	
	/**
	 * 업무명
	 */
	public String UNIT_NAME;
	
	/**
	 * 담당자/발송자 정보
	 */
	public String UNIT_PIC;
	
	/**
	 * 담당자 연락처 정보
	 */
	public String UNIT_PIC_TELNO;

}
