package com.ibk.msg.web.rcsBrand;

import lombok.Data;

@Data
public class RcsBrand {
	private String rnum;
	
	private String brId;                                 /* BR_ID			         브랜드ID		*/
	private String brNm;                                 /* BR_NM                    브랜드명		*/
	private String brKey;                                /* BR_KEY								*/
	private String agencyId;                             /* AGENCY_ID		*/
	private String useYn;                                /* USE_YN                   사용여부		*/
	private String status;                                /* STATUS                   displayed: 전시, paused: 검색 안됨, 메시지 전송 가능, 단말은 brandhome은 안보이고 연락처로 보임(P2P)		*/
	private String regDt;                                /* REG_DT                   등록일시		*/
	private String updateDt;                             /* UPDATE_DT                수정일시		*/
	private String apprCh;                               /* APPR_CH		*/
	private String apprReqYmd;                          /* APPR_REQ_YMD             요청일시		*/
	private String apprYmd;                              /* APPR_YMD                 승인일		*/
	private String apprReason;                           /* APPR_REASON		*/
	private String profileImgFileId;                   /* PROFILE_IMG_FILE_ID      RBC에서 전달 해 주는 프로필 파일 아이디		*/
	private String bgImgFileId;                        /* BG_IMG_FILE_ID           RBC에서 전달 해 주는 배경 파일 아이디		*/
	private String bizCateGrp;                          /* BIZ_CATE_GRP             카테고리1		*/
	private String bizCateCd;                           /* BIZ_CATE_CD              카테고리2		*/
	private String cate3;                                 /* CATE3                    카테고리3		*/
	private String tel;                                   /* TEL                      전화번호		*/
	private String addrRegnNo;                          /* ADDR_REGN_NO             우편번호		*/
	private String addrMngNo;                           /* ADDR_MNG_NO              주소		*/
	private String addrDtl;                              /* ADDR_DTL                 상세주소		*/
	private String email;                                 /* EMAIL                    이메일		*/
	private String url;                                   /* URL                      홈페이지주소		*/
	private String apiKey;                               /* API_KEY                  api key		*/
	private String description;                           /* DESCRIPTION              브랜드 설명		*/
	private String callbackName;                         /* CALLBACK_NAME            대표전화번호		*/
	private String brand_profilePath;                    /* BRAND_PROFILE_PATH       프로필 파일 저장 위치		*/
	private String subnumCertificatePath;               /* SUBNUM_CERTIFICATE_PATH  가입증명 파일 저장 위치		*/
	private String brandBackgroundPath;                 /* BRAND_BACKGROUND_PATH    배경 파일 저장 위치		*/
	private String chatbots;                              /* CHATBOTS                 발신번호 리스트		*/
	private String subTitle;                             /* SUB_TITLE                발신번호명		*/
	private String brandProfile;                         /* BRAND_PROFILE            프로필 파일 명		*/
	private String brandBackground;                      /* BRAND_BACKGROUND         배경 파일 명		*/
	private String subnumCertificate;                    /* SUBNUM_CERTIFICATE       가입증명 파일 명		*/
	private String menus;                                 /* MENUS                    메뉴정보		*/
	private String emplId; // 직원번호
}                                                             

