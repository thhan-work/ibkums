package com.ibk.msg.web.smsreq;

import java.util.List;
import java.util.Map;

import com.ibk.msg.web.smssendlist.SmsSendList;

import lombok.Data;

@Data
public class SmsReqData extends FileHeadData {

	// T21(TB_CMC_DRF002M)
	private String groupCoCd;                            // 그룹회사코드
	private String batchTagtUniqNo;                      // 배치대상고유번호
	private String bzwkChnlCd;                           // 업무채널코드
	private String bzwkIdnfr;                            // 업무식별자
	private String tmptUniqNo;                           // 템플릿고유번호          
	private String groupNm;					             // 기안명
	private String approvalYn;                           // 승인여부               
	private String prcssStusDstic;                       // 처리상태구분          
	private String requestsNumber;			             // 예상발송 건수
	private String sendPrityDstic;                       // 발송우선순위구분            
	private String pengagYms;				             // 발송시간 T21에 대한 대표시간(제일 빠른시간)
	private String expireScheduleYms;                    // 만료예정일시  
	private String sendStartYms;                         // 발송시작일시          
	private String sendExpireYms;                        // 발송만료일시
	private String sendProgressNumber;                   // 발송진행건수       
	private String scheduleDstic;                        // 스케줄구분       
	private String testYn;                               // 테스트여부                     
	private String inst;					             // 대상자 파일명
	private String recvRefusalYn;                        // 수신거부적용여부 
	private String regYms;                               // 등록일시               
	private String regEmpNo;                             // 등록직원번호                 
	private String sendEmpid;                            // 발송직원번호                
	private String sendBrncd;                            // 발송부점코드               
	private String sndrNoAddress;                        // 발신번호주소
	private String recvNoAddress;                        // 수신처번호주소
	private String filterLimitYn;                        // 필터제한여부
	private String testNo;                               // 테스트전화번호
	private String recvNoVar;                            // 수신번호변수
	private String progressStep;                         // 단계
	private String budgetConsultText;                    // 예산검토_협의내용
	private String sendPurpose;                          // 발송목적
	private String lawDeliberationYn;                    // 준법심의여부
	private String lawDeliberationText;                  // 준법심의_협의내용
	private String relDeptConsultText;                   // 유관부서협의_협의내용
	private String receiveAgreeCheckYn;                  // 수신동의체크
	private String duplicateCheckYn;                     // 중복체크여부
	
	// T22(T21_INFO)	                                 
	private String censorId;			                 // 심의필번호
	private String budgetNm;			                 // 예산합의서명
	private String modifyReason;		                 // 수정사유
	private String stopReason;		                     // 중지사유
	private String emplId;				                 // 직원아이디
	private String boCode;				                 // 업무코드
	private String seq1;				                 // MMS 템플릿 SEQ1
	private String seq2;				                 // MMS 템플릿 SEQ2
	private String seq3;				                 // MMS 템플릿 SEQ3
	private String successCount;		                 // 정상건수
	private String errorCount;			                 // 에러건수
	private String targetFilePath;	                     // 대상자파일명
	private String sendType;			                 // 발송업무 선택
	private String replaceVariableVal;	                 // 치환변수값
	private List<T30Data> sendDateInfo;		             // 발송시간별 건수
	private List<T32Data> confirmEmp;		             // 승인자
	private String agreeExistenceYn;		             // 2차,3차 승인자 존재 여부 확인
	private String kkoTmplCd;                            // 알림톡템플릿ID
	private String channelTmplId;                        // 채널별템플릿ID
	private String channelMsgStandard;                   // 채널별전문규격
	private String channelMsgText;                       // 채널별전문내용
	private String channelButtonText;                    // 채널별버튼내용
	private String channelOptionText;                    // 채널별옵션내용
	private String altMsgDiv;                            // 대체메시지구분
	private String altMsgTitle;                          // 대체메시지제목
	private String altMsgText;                           // 대체메시지내용
	private String targetFileId;                         // 대상자fileId
	                                                     
	//-----------custom-------------                     
	private String changeHeadDataYn;                     // 헤더 데이터 변경 여부 (Y: 변경, N: 동일)
	private boolean confirmCheck;                        // SMS대량발송 결재 없이 기안 등록 가능하게 수정
	private List<ImgTmplData> mmsImgList;                // mms 이미지정보 리스트
	private List<ImgTmplData> rcsImgList;                // rcs 이미지정보 리스트
	private List<List<Map<String, Object>>> btnInfoList; // 버튼정보 리스트
	private String cardType;                             // 카드타입1(Standalone/Carousel) 
	private String confirmMessage;                       // 기안정보(URL포함)
	
	// 테스트 발송 파람(확인필요)
	private String targetReplaceVal;
	private int fileCnt;
	private List<T32Data> testSenderList;		         // 테스트발송대상자들
	
	//
	public SmsReqData SmsSendListToSmsReqData(SmsSendList smsSendList){
		SmsReqData smsReqData = new SmsReqData();
		smsReqData.setGroupCoCd(smsSendList.getGroupCoCd());
		smsReqData.setGroupUniqNo(smsSendList.getGroupUniqNo());				
		smsReqData.setBatchTagtUniqNo(smsSendList.getBatchTagtUniqNo());
		smsReqData.setBzwkChnlCd(smsSendList.getBzwkChnlCd());
		smsReqData.setBzwkIdnfr(smsSendList.getBzwkIdnfr());
		smsReqData.setTmptUniqNo(smsSendList.getTmptUniqNo());
		smsReqData.setGroupNm(smsSendList.getGroupNm());					
		smsReqData.setMsgDstic(smsSendList.getMsgDstic());					
		smsReqData.setApprovalYn(smsSendList.getApprovalYn());
		smsReqData.setPrcssStusDstic(smsSendList.getPrcssStusDstic());
		smsReqData.setRequestsNumber(String.valueOf(smsSendList.getRequestsNumber()));			
		smsReqData.setSendPrityDstic(smsSendList.getSendPrityDstic());
		smsReqData.setPengagYms(smsSendList.getPengagYms());				
		smsReqData.setExpireScheduleYms(smsSendList.getExpireScheduleYms());
		smsReqData.setSendStartYms(smsSendList.getSendStartYms());
		smsReqData.setSendExpireYms(smsSendList.getSendExpireYms());
		smsReqData.setSendProgressNumber(smsSendList.getSendProgressNumber());
		smsReqData.setScheduleDstic(smsSendList.getScheduleDstic());
		smsReqData.setTestYn(smsSendList.getTestYn());
		smsReqData.setInst(smsSendList.getInst());							
		smsReqData.setRecvRefusalYn(smsSendList.getRecvRefusalYn());
		smsReqData.setRegYms(smsSendList.getRegYms());
		smsReqData.setRegEmpNo(smsSendList.getRegEmpNo());
		smsReqData.setSendEmpid(smsSendList.getSendEmpid());
		smsReqData.setSendBrncd(smsSendList.getSendBrncd());
		smsReqData.setSndrTelno(smsSendList.getSndrTelno());					
		smsReqData.setSndrNoAddress(smsSendList.getSndrNoAddress());
		smsReqData.setRecvNoAddress(smsSendList.getRecvNoAddress());
		smsReqData.setFilterLimitYn(smsSendList.getFilterLimitYn());
		smsReqData.setTestNo(smsSendList.getTestNo());
		smsReqData.setRecvNoVar(smsSendList.getRecvNoVar());
		smsReqData.setCensorId(smsSendList.getCensorId());			
		smsReqData.setBudgetNm(smsSendList.getBudgetNm());			
		smsReqData.setModifyReason(smsSendList.getModifyReason());		
		smsReqData.setStopReason(smsSendList.getStopReason());		
		smsReqData.setEmplId(smsSendList.getEmplId());				
		smsReqData.setBoCode(smsSendList.getBoCode());				
		smsReqData.setImageCount(smsSendList.getImageCount());		
		smsReqData.setImagePath1(smsSendList.getImagePath1());		
		smsReqData.setImagePath2(smsSendList.getImagePath2());		
		smsReqData.setImagePath3(smsSendList.getImagePath3());		
		smsReqData.setSuccessCount(smsSendList.getSuccessCount());		
		smsReqData.setErrorCount(smsSendList.getErrorCountNumber());			
		smsReqData.setTargetFilePath(smsSendList.getTargetFilePath());	
		smsReqData.setMsgCtnt(smsSendList.getMsgCtnt());			
		smsReqData.setUmsMsgCtnt(smsSendList.getUmsMsgCtnt());		
		smsReqData.setSendType(smsSendList.getSendType());			
		smsReqData.setReplaceVariableVal(smsSendList.getReplaceVariableVal());	 
		smsReqData.setSendDateInfo(smsSendList.getSendDateInfo());	 
		smsReqData.setConfirmEmp(smsSendList.getConfirmEmp());	 		
//		smsReqData.setAgreeExistenceYn(smsSendList.getAgreeExistenceYn());			
		smsReqData.setChangeHeadDataYn(smsSendList.getChangeHeadDataYn());
		return smsReqData;
	}
}
