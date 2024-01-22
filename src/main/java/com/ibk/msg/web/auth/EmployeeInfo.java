package com.ibk.msg.web.auth;

import lombok.Data;

@Data
public class EmployeeInfo {
    //EMPL_ID 이 사용자아이디인듯 싶으니, 이것으로 통일
    //EMPL_CLASS 확실하진 않지만, 이게 분류로 구분하는데 사용해도 되겠다.
    //0 : 일반사용자, 1: 직원용 SMS 발송 등록자, 2: 승인자, 9: 관리자   로 정의해두고 사용하자.
    //PW가 없다.

    private String emplId;              //VARCHAR2(10)     NOT NULL,
    private String boCode;              //VARCHAR2(10)     NOT NULL,
    private String emplBsno_7;          //VARCHAR2(13)         NULL,
    private String emplName;            //VARCHAR2(20)         NULL,
    private String emplHpNo;           //VARCHAR2(13)         NULL,
    private String emplCut;             //CHAR(1)              NULL,
    private String emplClass;          //CHAR(1)              NULL,
    private String emplPosition;        //VARCHAR2(5)          NULL,
    private String emalAdr;            //VARCHAR2(50)         NULL,
    private String rsptCd;             //VARCHAR2(4)          NULL,
    private String orgzAtrbCd;        //VARCHAR2(4)          NULL
    
    private String partName;
}