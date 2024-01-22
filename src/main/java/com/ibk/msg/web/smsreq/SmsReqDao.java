package com.ibk.msg.web.smsreq;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ibk.msg.config.database.IbkRepository;

@IbkRepository
public interface SmsReqDao {

	HashMap<String, Object> getDateTotalCnt(Map<String, Object> requestData);

	int findTotalCount(SmsReqEmployeeInfoSearchCondition searchCondition);
	List<SmsReqEmployeeInfo> findEmployee(SmsReqEmployeeInfoSearchCondition searchCondition);

	int saveT21(SmsReqData smsReqData);

	List<String> getSaveDateList(Map<String, Object> requestData);

	int saveT21_INFO(SmsReqData smsReqData);
	int saveT30(SmsReqData smsReqData);
	int saveT32(SmsReqData smsReqData);

	SmsReqData selectT21(SmsReqData smsReqData);
	List<T30Data> selectT30(SmsReqData smsReqData);
	List<T32Data> selectT32(SmsReqData smsReqData);
	List<T32Data> checkT32AgreeList(SmsReqData smsReqData);

	int updateT21(SmsReqData smsReqData);
	int updateT21_INFO(SmsReqData smsReqData);
	int deleteT30(SmsReqData smsReqData);
	
	int updateT28InputOrigin(HashMap<String, String> map);
	
	String getGroupUniqNo();

	byte[] getIMG();

	List<String> getSaveDateList2(Map<String, Object> requestData);

	int findAlimTalkTotalCount(AlimTalkSearchCondition searchCondition);

	List<AlimTalkInfo> findAlimTalk(AlimTalkSearchCondition searchCondition);

	int findRcsTemplateTotalCount(RcsTemplateSearchCondition searchCondition);
	
	AlimTalkInfo selectAlimTalkDetail(AlimTalkSearchCondition searchCondition);

	List<RcsTemplateInfo> findRcsTemplate(RcsTemplateSearchCondition searchCondition);

	int sendTargetListTotalCount(SendTargetSearchCondition searchCondition);

	List<SendTargetInfo> sendTargetList(SendTargetSearchCondition searchCondition);

	SendTargetMasterInfo selectTargetFileStatusChk(SendTargetMasterInfo param);

	T21Data getSmsDetail(String groupUniqNo);

	void insertImgTmpl(ImgTmplData imgTmplData);

	SmsReqData selectT21Info(SmsReqData smsReqData);

	void deleteT32(SmsReqData smsReqData);

	Map<String, Object> getRcsMsgbaseId(Map<String, Object> resultMap);

	ImgTmplData selectImgTmpl(ImgTmplData item);

	void updateImgTmpl(ImgTmplData item);

	int deleteSendTgt(SendTargetMasterInfo param);

	void deleteSendTgtMaster(SendTargetMasterInfo param);
	
	void testSend(SmsReqData smssendlist);

	void updatePrcssStusDstic(SmsReqData smsReqData);

	SendTargetInfo getReplaceVal(String groupUniqNo);

	void insertExcelBlob(FileUploadData item);

	SmsReqEmployeeInfo getUser(String emplId);

	boolean deleteImgTmpl(ImgTmplData item);

	void deleteFileUploadInfo(SendTargetMasterInfo param);

	void updateTgtT21(SendTargetMasterInfo param);

	void updateTgtT22(SendTargetMasterInfo param);
	
}

