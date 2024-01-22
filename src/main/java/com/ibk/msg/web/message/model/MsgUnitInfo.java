/*
 * @(#)MsgUnitInfo.java
 *
 * Copyright 2001(c) Infobank Corp. All Rights Reserved.
 * e-FineSMS 3th Project. Developed by Messaging Biz. Development.
 */
package com.ibk.msg.web.message.model;



/**
 * 업무시스템 정보를 제공한다.
 *
 * @author www.infobank.net
 * @version 2005.01.17
 */
public class MsgUnitInfo {



	/**
	 * 기본 업무시스템 코드
	 */
	public String UNIT_CODE;



	/**
	 * 기본 업무시스템 코드
	 */
	public String UNIT_SYSTEM_CODE;



	/**
	 * 기본 업무시스템 이름
	 */
	public String UNIT_SYSTEM_NAME;



	/**
	 * 세부 업무시스템 코드 또는 영업점 코드
	 */
	public String DES_CODE;



	/**
	 * 월별 허용건수(-1: 제한 없음)
	 */
	public int MSG_MAX = 0;



	/**
	 * 이번달 사용건수
	 */
	public int MSG_CNT = 0;



	/**
	 * 전송 우선 순위(0: 2순위, 1: 1순위)이나, EMMA <--> SMRS 구간의 순위이므로 실제로는 의미 없음.
	 */
	public int PRIORITY = 0;



	/**
	 * 월별 허용건수 구분(0: UNIT_CODE 전체적용, 1: DES_CODE 각자적용)
	 */
	public String SUB_CODE;



	/**
	 * 수신거부 구분(0: 일반 차단, 1: 절대 비차단)
	 */
	public String OPT;



	/**
	 * 월별 허용건수(-1: 제한 없음)
	 */
	public int VMSG_MAX = 0;



	/**
	 * 월별 허용건수 설명
	 */
	public String VMSG_MAX_EXP;



	/**
	 * 이번달 사용건수
	 */
	public int VMSG_CNT = 0;



	/**
	 * 전송 우선 순위(0: 2순위, 1: 1순위)이나, EMMA <--> SMRS 구간의 순위이므로 실제로는 의미 없음.
	 */
	public int VPRIORITY = 0;



	/**
	 * 전송 우선 순위 설명
	 */
	public String VPRIORITY_EXP;



	/**
	 * 월별 허용건수 구분(0: UNIT_CODE 전체적용, 1: DES_CODE 각자적용)
	 */
	public String VSUB_CODE;



	/**
	 * 월별 허용건수 구분 설명
	 */
	public String VSUB_CODE_EXP;



	/**
	 * 수신거부 구분(0: 일반 차단, 1: 절대 비차단)
	 */
	public String VOPT;



	/**
	 * 수신거부 구분 설명
	 */
	public String VOPT_EXP;



	/**
	 * 부서 이름
	 */
	public String PART_NAME;



    /**
	 * 부서 비밀번호
	 */
	public String PART_PWD;



    /**
	 * 부서 전화
	 */
	public String PART_P_NO;



    /**
	 * 지역 이름
	 */
	public String PART_GRCD_SQUA;



    /**
	 * 세부 업무시스템 코드
	 */
	public String UNIT_SYSTEM_ITEM_CODE;



    /**
	 * 세부 업무시스템 이름
	 */
	public String UNIT_SYSTEM_ITEM_NAME;



	/**
	 * TTS 무선 과금액;
	 */
	public int TTS_MESSAGE_MONEY_M = 0;



	/**
	 * TTS 유선 과금액;
	 */
	public int TTS_MESSAGE_MONEY_W = 0;



	/**
	 * VOICE 무선 과금액
	 */
	public int VOICE_MESSAGE_MONEY_M = 0;



	/**
	 * VOICE 유선 과금액
	 */
	public int VOICE_MESSAGE_MONEY_W = 0;



	/**
	 * FAX 주간 과금액
	 */
	public int FAX_MESSAGE_MONEY_D = 0;



	/**
	 * FAX 야간 과금액
	 */
	public int FAX_MESSAGE_MONEY_N = 0;



	@Override
	public String toString() {
		return "MsgUnitInfo [UNIT_CODE=" + UNIT_CODE + ", UNIT_SYSTEM_CODE="
				+ UNIT_SYSTEM_CODE + ", UNIT_SYSTEM_NAME=" + UNIT_SYSTEM_NAME
				+ ", DES_CODE=" + DES_CODE + ", MSG_MAX=" + MSG_MAX
				+ ", MSG_CNT=" + MSG_CNT + ", PRIORITY=" + PRIORITY
				+ ", SUB_CODE=" + SUB_CODE + ", OPT=" + OPT + ", VMSG_MAX="
				+ VMSG_MAX + ", VMSG_MAX_EXP=" + VMSG_MAX_EXP + ", VMSG_CNT="
				+ VMSG_CNT + ", VPRIORITY=" + VPRIORITY + ", VPRIORITY_EXP="
				+ VPRIORITY_EXP + ", VSUB_CODE=" + VSUB_CODE
				+ ", VSUB_CODE_EXP=" + VSUB_CODE_EXP + ", VOPT=" + VOPT
				+ ", VOPT_EXP=" + VOPT_EXP + ", PART_NAME=" + PART_NAME
				+ ", PART_PWD=" + PART_PWD + ", PART_P_NO=" + PART_P_NO
				+ ", PART_GRCD_SQUA=" + PART_GRCD_SQUA
				+ ", UNIT_SYSTEM_ITEM_CODE=" + UNIT_SYSTEM_ITEM_CODE
				+ ", UNIT_SYSTEM_ITEM_NAME=" + UNIT_SYSTEM_ITEM_NAME
				+ ", TTS_MESSAGE_MONEY_M=" + TTS_MESSAGE_MONEY_M
				+ ", TTS_MESSAGE_MONEY_W=" + TTS_MESSAGE_MONEY_W
				+ ", VOICE_MESSAGE_MONEY_M=" + VOICE_MESSAGE_MONEY_M
				+ ", VOICE_MESSAGE_MONEY_W=" + VOICE_MESSAGE_MONEY_W
				+ ", FAX_MESSAGE_MONEY_D=" + FAX_MESSAGE_MONEY_D
				+ ", FAX_MESSAGE_MONEY_N=" + FAX_MESSAGE_MONEY_N + "]";
	}
}
