package com.ibk.msg.web.user;

import lombok.Data;

@Data
public class UserInfo {
   private String emplId;               //VARCHAR2(10) NOT NULL
   private String userLevel;            //USER_LEVEL CHAR(1) NOT NULL
   private String emplName;             //EMPL_NAME VARCHAR2(20) NULL
   private String BoCode;               //BO_CODE VARCHAR2(10) NULL
   private String emplPosition;         //EMPL_POSITION VARCHAR2(5) NULL
   private String emplIp;               //EMPL_IP VARCHAR2(15) NULL
   private String useYn;                //USE_YN CHAR(1) NOT NULL
   //private String passwd;             //PASSWD VARCHAR(50) NULL
   private String regDt;                //REG_DT VARCHAR(14) NOT NULL
   private String regId;                //REG_ID VARCHAR(14) NOT NULL
   private String modDt;                //MOD_DT VARCHAR(14) NOT NULL
   private String modId;                //MOD_DT VARCHAR(14) NOT NULL
   private String adminYn;				//ADMIN_YN CHAR(1) NOT NULL @Bora
   private String emplYn;				//EMPL_YN CHAR(1) NOT NULL @YooSin
   
   private String emplLevel;
   
   private String partName; 			//PART_NAME VARCHAR2(40) NOT NULL (KIUPSMS.PART_INFO)
   
   private String requestType; 	// 요청 타입 (SMS 발송화면 : send, 승인자 : ack , 관리자 : admin)
}
