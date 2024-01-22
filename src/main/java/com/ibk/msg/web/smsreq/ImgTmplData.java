package com.ibk.msg.web.smsreq;

import lombok.Data;

/**
 * TABLE: TB_IMG_TMPL
 */
@Data
public class ImgTmplData {

	/** 이미지 시퀀스 */
	private int mmsImgId;
	/** 이미지타입(B:기본제공, I:개별작성, N:명함) */
	private String imgTypeCd;
	/** 이미지내용 */
	private byte[] imgCon;
	/** 이미지카테고리(계절, 명절 등 이미지 그룹명) */
	private String imgCtgyNm;
	/** 이미지명 */
	private String imgNm;
	/** 이미지 사용(활성) 여부 */
	private String useYn;
	/** 이미지 정렬을 위한 순번 */
	private int imgSqn;
	/** 사용자 정의 내용(이미지위에 텍스트 입력시 이용) */
	private String mmsUserDfntCon;
	/** 직원번호 */
	private String emn;
	/** 부서코드 */
	private String dvcd;
	/** 이미지 등록일자 */
	private String rgsnTs;
	/** 등록된 이미지 상태 변경일 */
	private String mdfcTs;
	/** 메시지유형 */
	private String msgDstic;
	
	//-----------custom-------------
	private String imgUploadPath;             // 이미지 업로드 경로
	private String csTitle;                   // 캐러설 제목
	private String csContents;                // 캐러셀 내용
	private boolean rcsYn;                    // rcs여부
}
