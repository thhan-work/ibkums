package com.ibk.msg.web.smsreq;

import lombok.Data;

/**
 * TABLE: TB_FILE_UPLOAD
 */
@Data
public class FileUploadData {
	/** 파일시퀀스 */
	private int fileId;
	/** 파일원본명 */
	private String fileOrgNm;
	/** 파일명 */
	private String fileNm;
	/** 파일내용 */
	private byte[] fileCon;
	/** 직원번호 */
	private String emn;
	/** 부서코드 */
	private String dvcd;
	/** 등록일자 */
	private String rgsnTs;
}
