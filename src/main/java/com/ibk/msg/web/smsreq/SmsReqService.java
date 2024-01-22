package com.ibk.msg.web.smsreq;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.base.Preconditions;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.ibk.msg.common.dto.PaginationResponse;
import com.ibk.msg.files.UploadedFile;
import com.ibk.msg.files.UploadedFileFactory;
import com.ibk.msg.utils.RcsTemplateUtils;
import com.ibk.msg.utils.TobeFileHandler;
import com.ibk.msg.web.manage.Code;
import com.ibk.msg.web.manage.ManageDao;

@Component
@PropertySources({
	@PropertySource("classpath:local.properties")
	, @PropertySource(value="classpath:${spring.profiles.active}.properties", ignoreResourceNotFound=true)
})
public class SmsReqService {
	private static final Logger logger = LoggerFactory.getLogger(SmsReqService.class);
	
	@Value("${upload.path.customers}")
	private String CUSTOMERS_UPLOADED_DIR;

	@Value("${upload.path.rcv}")
	private String TKMFILES_RCV_DIR;
	
	@Value("${upload.path.images}")
	private String IMAGES_UPLOADED_DIR;
	
	@Value("${upload.path.images.rcs}")
	private String IMAGES_RCS_UPLOADED_DIR;
	
	@Autowired
	private SmsReqDao dao;
	
	@Autowired
	private ManageDao manageDao;
	
	public String saveUploadedFile(MultipartFile uploadFile, String uploadedDir) {
	  if (uploadFile.isEmpty()) {
	    return null;
	  }
	  UploadedFile uploadedFile = UploadedFileFactory.getInstance(uploadFile);
	  return uploadedFile.save(uploadFile, uploadedDir);
	}
	
	/**
	 * 해당 일자 시간별 발송 총 건수 조회
	 * 
	 * @param requestData
	 * @return
	 */
	public HashMap<String, Object> getDateTotalCnt(Map<String, Object> requestData) {
		return dao.getDateTotalCnt(requestData);
	}

	/**
	 * 기안 해당 일자 시간별 저장된 발송 건수 조회
	 * 
	 * @param requestData
	 * @return
	 */
	public HashMap<String, Object> getDateSaveCnt(Map<String, Object> requestData) {
		//1. 해당 기안에 추가된 일자 조회
		List<String> saveDateList = dao.getSaveDateList(requestData);

		//2. 조회된 일자별 시간별 건수 조회
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		for(String date : saveDateList){
			HashMap<String, Object> pram = new HashMap<String, Object>();
			pram.put("date", date);
			pram.put("timeList", requestData.get("timeList"));
			pram.put("groupUniqNo", requestData.get("groupUniqNo"));
			pram.put("selectType", "save");
			
			HashMap<String, Object> selectMap = dao.getDateTotalCnt(pram);
			
			resultMap.put(date, selectMap);
		}
		return resultMap;
	}
	
	/**
	 * 승인자 조회
	 * 
	 * @param searchCondition
	 * @return
	 */
	public Object findByPagination(SmsReqEmployeeInfoSearchCondition searchCondition) throws Exception {
	    Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
	    Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");
	    
	    int totalCount = dao.findTotalCount(searchCondition);
	    List<SmsReqEmployeeInfo> users = dao.findEmployee(searchCondition);
	    return new PaginationResponse(searchCondition, totalCount, users);
	}

	/**
	 * 결재 올리기
	 * 
	 * @param smsReqData
	 * @throws FileNotFoundException 
	 */
	@Transactional(transactionManager = "ibkSmsTxManager")
	public void save(SmsReqData smsReqData) throws Exception{
		smsReqData.setPrcssStusDstic("A"); //결재진행중(A)
		
		// TODO 확인필요
		//2. 기안자 정보 발송 승인직원 등록에 추가(승인자 4단계)
//		T32Data t32Data = new T32Data();
//		t32Data.setEmplId(smsReqData.getEmplId());
//		t32Data.setAgreeType("4");
//		smsReqData.getConfirmEmp().add(t32Data);
		insertSmsReq(smsReqData);
	}
	
	/**
	 * 임시저장
	 * 
	 * @param smsReqData 
	 * @throws FileNotFoundException 
	 */
	@Transactional(transactionManager = "ibkSmsTxManager")
	public void saveTemp(SmsReqData smsReqData) throws Exception {
		smsReqData.setPrcssStusDstic("C"); // 임시저장 (C)
		insertSmsReq(smsReqData);
	}
	
	/**
	 * 발송승인요청
	 * @param smsReqData
	 * @throws Exception
	 */
	@Transactional(transactionManager = "ibkSmsTxManager")
	public void saveNoConfirm(SmsReqData smsReqData) throws Exception{
		smsReqData.setPrcssStusDstic("B"); // 발송승인대기(B)
		
		// 신규저장
		insertSmsReq(smsReqData);
		
		// 발송승인URL문자 단건 발송
		sendApprovalLms(smsReqData);
	}
	
	/**
	 * 발송승인URL문자 단건 발송
	 */
	private void sendApprovalLms(SmsReqData smsReqData) {
		
		// 1. 발송승인URL문자 단건 발송
		List<T32Data> t32List = smsReqData.getConfirmEmp();
		if(t32List.size() > 0){
			for(T32Data data : t32List){
				String addUrlEmplId = data.getEmplId();
				//문자 메시지 내용을 기안내용으로 변경
				smsReqData.setMsgCtnt(smsReqData.getGroupNm());
				smsReqData.setUmsMsgCtnt(smsReqData.getConfirmMessage() + addUrlEmplId);
				smsReqData.setRecvNoAddress(data.getEmplHpNo());
				//모든 기안내용은 LMS 이기때문에 LM으로 변경
				smsReqData.setMsgDstic("LM");
				//2. 발송테이블 insert2(기안 정보 문자 발송 및 url 전송)
				dao.testSend(smsReqData);
			}
		}
		
		// 2. T21 처리상태구분값 변경
		smsReqData.setPrcssStusDstic("I"); // 발송승인중(I)
		dao.updatePrcssStusDstic(smsReqData);
	}

	/**
	 * 기안 신규 추가 (결재 올리기, 임시저장 공통)
	 * 22.07.18 기존 신규저장에서 수정 기능 추가
	 * @param smsReqData
	 * @throws FileNotFoundException 
	 */
	public void insertSmsReq(SmsReqData smsReqData) throws Exception{
		
		// 1. 파라미터 값 셋팅
		// 웹취약성 점검 수정
		if(StringUtils.lowerCase(StringUtils.defaultIfEmpty(smsReqData.getMsgCtnt(), "")).indexOf("<script>") >=0
				|| StringUtils.lowerCase(StringUtils.defaultIfEmpty(smsReqData.getMsgCtnt(), "")).indexOf("</script>") >=0
				|| StringUtils.lowerCase(StringUtils.defaultIfEmpty(smsReqData.getUmsMsgCtnt(), "")).indexOf("<script>") >=0
				|| StringUtils.lowerCase(StringUtils.defaultIfEmpty(smsReqData.getUmsMsgCtnt(), "")).indexOf("</script>") >=0
				) {
			throw new Exception("부적합한 내용이 포함되어 있습니다. 다시 확인하여 주십시요.");
		}
		
		// 2. 공통 파라미터 값 셋팅
		cmmnMsgFmtData(smsReqData, false);
		
		// 3. T21 저장
		SmsReqData result = dao.selectT21(smsReqData);
		if(result != null) {
			dao.updateT21(smsReqData);
		} else {
			dao.saveT21(smsReqData);
		}
		
		// 4. T21_INFO 기안 정보 추가
		SmsReqData resultInfo = dao.selectT21Info(smsReqData);
		if(resultInfo != null) {
			dao.updateT21_INFO(smsReqData);
		} else {
			dao.saveT21_INFO(smsReqData);
		}
		
		// 5. T30 발송 희망일 시간 별 건수 추가
		List<T30Data> t30List = smsReqData.getSendDateInfo();
		logger.debug("###T30DataList SIZE =" + t30List.size());
		if(t30List.size() > 0){
			for(T30Data data : t30List){
				data.setGroupUniqNo(smsReqData.getGroupUniqNo());
				data.setBzwkIdnfr(smsReqData.getBzwkIdnfr());
				data.setGroupCoCd("IBK");
				data.setScheduleTagtDstic("W");
				data.setSendStusDstic("Y");
				data.setScheduleDstic("W");
				data.setAlarmPeriodNumber("1000");
				data.setIntervalTime("60");
			}
			List<T30Data> list = dao.selectT30(smsReqData);

			if(CollectionUtils.isNotEmpty(list)){
				dao.deleteT30(smsReqData);
			}
			dao.saveT30(smsReqData);
		}

		// 6. T32 승인자 추가
		List<T32Data> t32List = smsReqData.getConfirmEmp();
		logger.debug("###T32DataList SIZE =" + t32List.size());
		if(t32List.size() > 0){
			for(T32Data data : t32List){
				data.setGroupUniqNo(smsReqData.getGroupUniqNo());
				data.setDrafterNm(smsReqData.getEmplId());
				data.setAgreeStatus("I"); // 승인상태(진행중 (I), 완료(G))
			}

			dao.deleteT32(smsReqData);

			//발송승인직원 목록에 있는 직원 전부 추가
			dao.saveT32(smsReqData);
		}
		
		// 7. T28 업로드 대상자 치환변수 값 수정
		String msgCtnt = smsReqData.getMsgCtnt();
		if(StringUtils.isNotEmpty(msgCtnt)) {
			updateT28InputOrigin(smsReqData);
		}
	}
	
	/**
	 * 기안 수정
	 * 
	 * @param smsReqData
	 */
	public void updateSmsReq(SmsReqData smsReqData){
		//0. T21 기안 정보 추가
		// 일반문자의 경우 업무식별자 규칙 CC_부서코드_직원번호
		String tranId = "CC" + smsReqData.getBoCode() + "_" +smsReqData.getEmplId();
		smsReqData.setBzwkIdnfr(tranId);
		smsReqData.setMsgDstic(smsReqData.getMsgDstic().toUpperCase().substring(0,2));
		
		//1-1. 추가로 등록 된 GROUP_UNIQ_NO 값 리턴 및 셋팅
		dao.updateT21(smsReqData); 

		//2. T21_INFO 기안 정보 추가
		dao.updateT21_INFO(smsReqData);
		
		//3-1. 기존 T30 발송 희망일 삭제
		dao.deleteT30(smsReqData);
		//3-2. T30 발송 희망일 시간 별 건수 추가
		List<T30Data> t30List = smsReqData.getSendDateInfo();
		logger.debug("###T30DataList SIZE =" + t30List.size());
		if(t30List.size() > 0){
			for(T30Data data : t30List){
				data.setGroupUniqNo(smsReqData.getGroupUniqNo());
				data.setBzwkIdnfr(smsReqData.getBzwkIdnfr());
				data.setGroupCoCd("IBK");
				data.setScheduleTagtDstic("W");
				data.setSendStusDstic("Y");
				data.setScheduleDstic("W");
				data.setAlarmPeriodNumber("1000");
				data.setIntervalTime("60");
			}
			
			dao.saveT30(smsReqData);
		}
	}
	
	/**
	 * 저장된 기안 정보 조회
	 * 
	 * @param smsReqData
	 */
	public SmsReqData selectSmsReq(SmsReqData smsReqData){
		SmsReqData result = new SmsReqData(); 
		
		result = dao.selectT21(smsReqData);	// 기안정보 조회
		
//		List<T30Data> t30List = dao.selectT30(smsReqData);		//발송희망을은 getDateSaveCnt() 사용
//		List<T32Data> t32List = dao.selectT32(smsReqData);		// 승인자 정보 조회
		
//		result.setConfirmEmp(t32List);
		
		return result;
	}
	
	/**
	 * 기본 페이지 셋팅
	 * 
	 * @return
	 */
	public void initPage(ModelAndView mav){
		//그룹유니크코드 채번
		String groupUniqNo = dao.getGroupUniqNo();
		mav.addObject("groupUniqNo", groupUniqNo);
		
		//START__###### 발송 단가 정보 조회
		List<Code> sendPriceLsit = manageDao.selectSendPrice();
		for(Code sendPrice : sendPriceLsit){
			mav.addObject(sendPrice.getDsplyNm(), sendPrice.getCdValue());
		}
		//END__###### 발송 단가 정보 조회
	}
	
	/**
	 * 대상자 파일 처리
	 * 
	 * @return
	 */
	public HashMap<String, Object> handleFile(MultipartFile uploadFile, String groupUniqNo,String sendType,String filePath, boolean dupCheck){
		return (HashMap<String, Object> )TobeFileHandler.hadleFile(uploadFile, groupUniqNo, sendType,filePath, dupCheck);
	}
	
	public int updateT28InputOrigin(SmsReqData smsReqData) {
		String groupUniqNo=smsReqData.getGroupUniqNo();
		if(groupUniqNo==null||groupUniqNo.trim().equals("")) {
			return -1;
		}
		FileHeadData fdata = new FileHeadData().smsReqDataToFileHeadData(smsReqData);
		String jData=TobeFileHandler.getvoJson(fdata);
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("hdata", jData);
		map.put("groupUniqNo", groupUniqNo);
		
		return dao.updateT28InputOrigin(map);
	}
	
	public void targetFileHandler(SmsReqData smsReqData) throws FileNotFoundException {
		if(smsReqData.getTargetFilePath()!=null && !smsReqData.getTargetFilePath().equals("")) {
			StringBuilder sb= new StringBuilder();
			sb.append((smsReqData.getGroupUniqNo()==null?"":smsReqData.getGroupUniqNo())+"|");
			sb.append((smsReqData.getMsgDstic()==null?"":smsReqData.getMsgDstic())+"|");
			sb.append((smsReqData.getSndrTelno()==null?"":smsReqData.getSndrTelno())+"|");
			sb.append((smsReqData.getMsgCtnt()==null?"":smsReqData.getMsgCtnt().replaceAll("\r\n", "\\\\r\\\\n").replaceAll("\n", "\\\\n"))+"|");
			sb.append((smsReqData.getUmsMsgCtnt()==null?"":smsReqData.getUmsMsgCtnt().replaceAll("\r\n", "\\\\r\\\\n").replaceAll("\n", "\\\\n"))+"|");
			sb.append((smsReqData.getImageCount()==null?"0":smsReqData.getImageCount())+"|");
			sb.append((smsReqData.getImagePath1()==null?"":smsReqData.getImagePath1())+"|");
			sb.append((smsReqData.getImagePath2()==null?"":smsReqData.getImagePath2())+"|");
			sb.append(smsReqData.getImagePath3()==null?"":smsReqData.getImagePath3());
			if(smsReqData.getReplaceVariableVal()!=null&&!smsReqData.getReplaceVariableVal().trim().equals("")) {
				JsonParser jsonParser = new JsonParser();
				JsonObject jo = (JsonObject)jsonParser.parse(smsReqData.getReplaceVariableVal());
				Set<String> keySet=jo.keySet();
				
				Iterator<String> iter=keySet.iterator();
				while(iter.hasNext()) {
					sb.append("|"+iter.next());
				}
			}
			sb.append(System.getProperty("line.separator"));
			
			File f=new File(CUSTOMERS_UPLOADED_DIR+File.separator+smsReqData.getTargetFilePath());
			if(f.exists()&&f.isFile()) {
				File rcvf=new File(TKMFILES_RCV_DIR);
				if(!rcvf.exists()) {
					rcvf.mkdirs();
				}
				FileInputStream fis=null;
				BufferedReader br =null;
				//FileOutputStream fos =null;
				Writer writer = null;
				try {
					fis = new FileInputStream(f);
					br = new BufferedReader(new InputStreamReader(fis,"EUC-KR"));
					String line = "";
					while( (line = br.readLine()) != null){
					 	sb.append(line);
					 	sb.append(System.getProperty("line.separator"));
					}
					br.close();
					fis.close();
					f.delete();
					writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(new File(TKMFILES_RCV_DIR+File.separator+smsReqData.getTargetFilePath())), "EUC-KR"));
					writer.write(sb.toString());
					writer.flush();
					writer.close();
				} catch (FileNotFoundException e) {
					e.printStackTrace();
				} catch(IOException e) {
					e.printStackTrace();
				}finally {
					if(writer!=null) {
						try {
							writer.close();
							writer=null;
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
					if(br!=null) {
						try {
							br.close();
							br=null;
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
					if(fis!=null) {
						try {
							fis.close();
							fis=null;
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
				}
			}else {			
					throw new  FileNotFoundException();
			}
		}
	}

	public SmsReqData getIMG(String groupUniqNo) {
		SmsReqData r = new SmsReqData();
		r.setGroupUniqNo(groupUniqNo);
		return dao.selectT21(r);
	}

	public HashMap<String, Object> getDateSaveCnt2(Map<String, Object> requestData) {
		//1. 해당 기안에 추가된 일자 조회
		List<String> saveDateList = dao.getSaveDateList2(requestData);

		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		if(saveDateList.size() > 0){
			List<String> timeList = new ArrayList<String>();
			for(String yms : saveDateList){
				timeList.add(yms.substring(8,12));
			}
			
			//2. 조회된 일자별 시간별 건수 조회
			for(String date : saveDateList){
				HashMap<String, Object> pram = new HashMap<String, Object>();
				pram.put("date", date.substring(0, 8));
				pram.put("timeList", timeList);
				pram.put("groupUniqNo", requestData.get("groupUniqNo"));
				pram.put("selectType", "save");
				
				HashMap <String, Object> selectMap = dao.getDateTotalCnt(pram);
				
				selectMap.put("timeList", timeList);
				
				resultMap.put(date.substring(0, 8), selectMap);
			}
		}
		return resultMap;
	}
	
	/**
	 * 카카오알림톡 템플릿 목록 조회
	 * @param searchCondition
	 * @return
	 */
	public Object findAlimTalkByPagination(AlimTalkSearchCondition searchCondition) {
		Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
	    Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");
	
	    int totalCount = dao.findAlimTalkTotalCount(searchCondition);
	    List<AlimTalkInfo> list = dao.findAlimTalk(searchCondition);
	    return new PaginationResponse(searchCondition, totalCount, list);
	}
	
	/**
	 * 카카오알림톡 템플릿 상세 조회
	 * @param searchCondition
	 * @return
	 */
	public Object selectAlimTalkDetail(AlimTalkSearchCondition searchCondition) {
		return dao.selectAlimTalkDetail(searchCondition);
	}
	
	/**
	 * rcs 템플릿 조회
	 * @param searchCondition
	 * @return
	 */
	public Object findRcsTemplateByPagination(RcsTemplateSearchCondition searchCondition) {
		Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
	    Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");
	
	    int totalCount = dao.findRcsTemplateTotalCount(searchCondition);
	    List<RcsTemplateInfo> list = dao.findRcsTemplate(searchCondition);
	    return new PaginationResponse(searchCondition, totalCount, list);
	}
	
	/**
	 * 발송대상자 조회
	 * @param searchCondition
	 * @return
	 */
	public Object findSendTargetListByPagination(SendTargetSearchCondition searchCondition) {
		Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
	    Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");
	
	    int totalCount = dao.sendTargetListTotalCount(searchCondition);
	    List<SendTargetInfo> list = dao.sendTargetList(searchCondition);
	    return new PaginationResponse(searchCondition, totalCount, list);
	}

	/**
	 * 업로드한 엑셀의 T26 처리상태 확인
	 * @param param
	 * @return
	 */
	public SendTargetMasterInfo selectTargetFileStatusChk(SendTargetMasterInfo param) {
		SendTargetMasterInfo info = dao.selectTargetFileStatusChk(param);
		return info;
	}
	
	/**
	 * 발송 상세 조회
	 * @param param
	 * @return
	 */
	public T21Data getSmsDetail(String groupUniqNo) {
		return dao.getSmsDetail(groupUniqNo);
	}

	public Map<String, Object> getRcsMsgbaseId(Map<String, Object> resultMap) {
		return dao.getRcsMsgbaseId(resultMap);
	}
	
	/**
	 * 발송대상자 삭제
	 * @param param
	 * @return
	 */
	@Transactional(transactionManager = "ibkSmsTxManager")
	public Map<String, Object> deleteSendTgt(SendTargetMasterInfo param) {
		Map<String, Object> resultMap = new HashMap<>();
		String result = "FAIL";
		
		// 1. TB_FILE_UPLOAD삭제
		dao.deleteFileUploadInfo(param);
		
		// 2. T26 대상자 마스터 삭제
		dao.deleteSendTgtMaster(param);
		
		// 3. T28 대상자 목록 삭제
		dao.deleteSendTgt(param);
		
		// 4. T21 대상자 관련 정보 수정
		dao.updateTgtT21(param);
		
		// 5. T22 대상자 관련 정보 수정 및 4단계 정보 초기화
		dao.updateTgtT22(param);
		
		// 6. T30 발송슼케줄 삭제
		SmsReqData smsReqData = new SmsReqData();
		smsReqData.setGroupUniqNo(param.getTargetId());
		dao.deleteT30(smsReqData);
		
		result = "SUCCESS";
		resultMap.put("result", result);
		return resultMap;
	}

	/**
	 * 테스트 발송
	 * @param 
	 * @return
	 */
	public Map<String, Object> testSend(SmsReqData smsReqData) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		
		//웹취약성 점검 수정
		if(StringUtils.lowerCase(StringUtils.defaultIfEmpty(smsReqData.getMsgCtnt(), "")).indexOf("<script>") >=0
				|| StringUtils.lowerCase(StringUtils.defaultIfEmpty(smsReqData.getMsgCtnt(), "")).indexOf("</script>") >=0
				|| StringUtils.lowerCase(StringUtils.defaultIfEmpty(smsReqData.getUmsMsgCtnt(), "")).indexOf("<script>") >=0
				|| StringUtils.lowerCase(StringUtils.defaultIfEmpty(smsReqData.getUmsMsgCtnt(), "")).indexOf("</script>") >=0
				) {
			resultMap.put("success", "false");
			resultMap.put("message", "부적합한 내용이 포함되어 있습니다. 다시 확인하여 주십시요.");
			return resultMap;
		}
		
		String sResult = "";
		
		try {
			cmmnMsgFmtData(smsReqData, true);
			
			//치환 변수 존재 시 메시지 내용 치환하여 테스트 문자 발송
			if(!smsReqData.getTargetReplaceVal().equals("")) {
				String newMsgCtnt=null;
				if(smsReqData.getMsgDstic().equals("SM") || smsReqData.getMsgDstic().equals("SR")) {
					newMsgCtnt=var2message(smsReqData.getMsgCtnt(), jsonToMap(smsReqData.getTargetReplaceVal())).toString();
					smsReqData.setMsgCtnt(newMsgCtnt);
				}else {
					newMsgCtnt=var2message(smsReqData.getUmsMsgCtnt(), jsonToMap(smsReqData.getTargetReplaceVal())).toString();
					smsReqData.setUmsMsgCtnt(newMsgCtnt);
				}
			}
			
			List<T32Data> testSenderList = smsReqData.getTestSenderList();
			
			if(testSenderList != null) {
				for(int i=0; i < testSenderList.size(); i++) {
					String recvNoAddress = testSenderList.get(i).getEmplHpNo();
					smsReqData.setRecvNoAddress(recvNoAddress);
					
					//1. 발송테이블 insert(실제 문자 발송 내역 )
					dao.testSend(smsReqData);
				}
				
				resultMap.put("success", "true");
			} else {
				resultMap.put("success", "false");
			}
			
//			String sTempMessage = resultMap.get("공통뷰파일내용").toString();
		 	/*String sTempTelNo = (String)resultMap.get("테스트수신전화번호");
			String sTempName = (String)resultMap.get("테스트고객명");
			String sTempVal1 = (String)resultMap.get("테스트변수1");
			String sTempVal2 = (String)resultMap.get("테스트변수2");
			String sTempVal3 = (String)resultMap.get("테스트변수3");
			String sTempVal4 = (String)resultMap.get("테스트변수4");
			String sTempVal5 = (String)resultMap.get("테스트변수5");

			resultMap.put("수신처전화번호", sTempTelNo);
			resultMap.put("수신번호주소", sTempTelNo);
			resultMap.put("고객명", sTempName);//!!
			resultMap.put("고객식별자", "");//PUSH 용

 			if (sTempMessage.indexOf("\\${고객명}")>=0) {
 				sTempMessage = sTempMessage.replace("\\${고객명}", sTempName);
 			}

 			if (sTempMessage.indexOf("\\${변수1}")>=0) {
 				sTempMessage = sTempMessage.replace("\\${변수1}", sTempVal1);
 			}

 			if (sTempMessage.indexOf("\\${변수2}")>=0) {
 				sTempMessage = sTempMessage.replace("\\${변수2}", sTempVal2);
 			}

 			if (sTempMessage.indexOf("\\${변수3}")>=0) {
 				sTempMessage = sTempMessage.replace("\\${변수3}", sTempVal3);
 			}

 			if (sTempMessage.indexOf("\\${변수4}")>=0) {
 				sTempMessage = sTempMessage.replace("\\${변수4}", sTempVal4);
 			}
 			if (sTempMessage.indexOf("\\${변수5}")>=0) {
 				sTempMessage = sTempMessage.replace("\\${변수5}", sTempVal5);
 			}*/
		 	
//			String msgDstic = smsReqData.getMsgDstic();
//		 	JSONObject jsonInput = new JSONObject();
//			JSONObject jsonData = new JSONObject();
//			JSONObject jsonObj = new JSONObject();
//
//			jsonObj.put("메시지종류", msgDstic);
//			jsonData.put("data", jsonObj);
//			jsonData.put("완성전문", sTempMessage);
//			jsonInput.put("input", jsonData);
		 	
			// RCS LMS/MMS 는 메시지제목을 "메시지내용" 필드에 입력해준다.
//		    if ("LR".equals(msgDstic) || "MR".equals(msgDstic)) {
//		    	resultMap.put("메시지내용", resultMap.get("메시지제목"));
//		    }
//		    resultMap.put("UMS메시지내용", resultMap.get("CONTENT").toString());                     // RCS는 SMS/LMS/MMS 모두 120 Byte 를 초과할수 있으므로 "UMS메시지내용" 필드에 입력해준다.
//		    resultMap.put("치환변수값", jsonInput.toString());
//
//		    resultMap.put("검증결과코드", "00");
//		    resultMap.put("거래구분", "UMSWEB0001");
//		    resultMap.put("발신처전화번호", resultMap.get("발신번호"));
		 	
		    //insert 41 테스트발송 (예약시간은 현재시간+1분후 발송)
			/*int resultInsert = cmnSqlSessionService.insert(resultMap, "ums.myBatis.mappers.rcsSend.insertTSUCSSU41_TestSend");
			if (resultInsert <= 0) {
				customMsg = "[1000001 오류가 있습니다. 담당자에게 문의 바랍니다.(T41 TestSend INSERT ERROR)]";
				throw new Exception(customMsg);
			}*/
		 	
			// 테발 성공시 프론트에서 SUCC 라는 값을 가지고 성공 여부 멘트를 출력합니다. SUCC 라는 성공 멘트가 변경될 겅우에는 프론트의 성공 구분자도 변경 해야 합니다.
		} catch (RuntimeException e) {
	 		if(logger.isDebugEnabled()) e.printStackTrace();
	 		logger.error("[테스트발송 시, RuntimeException 에러 발생]", e.getMessage());
	 		resultMap.put("success", "false");
	 		sResult = "테스트 발송중 오류가 발생했습니다. 관리자에게 문의 바랍니다.";
	 	} catch (Exception e) {
	 		logger.error("[테스트발송 시, Exception 에러 발생]", e.getMessage());
	 		resultMap.put("success", "false");
	 		sResult = "테스트 발송중 오류가 발생했습니다.";
	 	} finally {
	 		resultMap.put("message", sResult+ resultMap.get("customMsg"));
	 	}
		return resultMap;
	}
	
	/**
	 * 업로드대상자(T28) 1번째 행의 치환변수 값 구하기
	 * @return
	 * @throws Exception 
	 */
	public String getReplaceVal(String groupUniqNo) throws Exception {
		String jsonStr = null;
		
		// 업로드대상자(T28)에서 치환변수 값 조회
		SendTargetInfo sendTargetInfo = dao.getReplaceVal(groupUniqNo);
		
		// JSON STRING에서 고객명, 치환변수 값만 추출
		if(sendTargetInfo != null) {
			
			String replaceVariableVal = sendTargetInfo.getReplaceVariableVal();
			if(replaceVariableVal != null) {
				
				String[] fieldName =  new String[] {"고객번호", "휴대폰번호"};
				JsonParser parser = new JsonParser();
				JsonObject jsonObj = (JsonObject) parser.parse(replaceVariableVal);
				JsonObject newObj = new JsonObject();
				
				Iterator<String> keys = jsonObj.keySet().iterator();

				while (keys.hasNext()) {
					String key = keys.next();
					
					if(!Arrays.asList(fieldName).contains(key)) {
						// value의 byte 계산
						String value = jsonObj.get(key).getAsString();
						int byteLen = value.getBytes("EUC-KR").length;
						newObj.addProperty(key, Integer.toString(byteLen));
					}
				}
				jsonStr = newObj.toString();
			}
		}
		
		return jsonStr;
	}
	
	/**
	 * 메시지발송, 테스트발송 공통 매개변수
	 * @param smsReqData
	 * @param httpSession
	 * @param type
	 * @return
	 * @throws Exception 
	 */
	public void cmmnMsgFmtData(SmsReqData smsReqData, boolean isTestSend) throws Exception {
		// 발송부점코드
		String emplBoCode = smsReqData.getBoCode();
		String sTempDeptCd = "_UNKNOWN_";
		if (emplBoCode != null && !emplBoCode.equals("")) {
			sTempDeptCd = emplBoCode;
		}
		smsReqData.setSendBrncd(sTempDeptCd);
		
		// 업무채널코드, 업무식별자
		// 대량문자 업무식별자 규칙 > 문자-마케팅(CM101), 비마케팅(CM100) / 알림톡-CM103 / RCS-CM104
		String msgDstic = smsReqData.getMsgDstic();
		String tranId = "";
		if("KM".equals(msgDstic)) {
			tranId = "CM103";
		} else if(msgDstic.endsWith("M")) {
			if ("marketing".equals(smsReqData.getSendType().trim())) {
				tranId = "CM101";
			} else {
				tranId = "CM100";
			}
		} else if(msgDstic.endsWith("R")){
			tranId = "CM104";
		}
		
		smsReqData.setBzwkIdnfr(tranId);
		smsReqData.setGroupCoCd("IBK");
		smsReqData.setBzwkChnlCd("BK");
		smsReqData.setScheduleDstic("W"); // 채널 과 웹 구분자 ( D : 채널, W : 웹)
		
		// 발신처번호
		String sndrTelno = smsReqData.getSndrTelno();
		sndrTelno = sndrTelno.replace("-", "");
		smsReqData.setSndrTelno(sndrTelno);
		
		// 이미지 시퀀스 추가
		int idx = 0;
		List<ImgTmplData> mmsImgList = smsReqData.getMmsImgList();
		if(CollectionUtils.isNotEmpty(mmsImgList)) {
			for(ImgTmplData data: mmsImgList) {
				String mmsImgIdStr = null;
				if(data != null) {
					// 이미지 등록(이미지 시퀀스 얻기)
					mmsImgIdStr = String.valueOf(this.insertImageBlob(data));
				}
				if(idx == 0) {
					smsReqData.setSeq1(mmsImgIdStr);
				} else if(idx == 1) {
					smsReqData.setSeq2(mmsImgIdStr);
				} else {
					smsReqData.setSeq3(mmsImgIdStr);
				}
				idx++;
			}
		}
		
		// RCS 추가 파라미터 셋팅
		if(msgDstic.endsWith("R")) {
			
			// 채널별 전문내용, 채널별 옵션내용, 채널별 버튼 내용 JSON 포맷으로 변경
			RCSStringToJson(smsReqData);
		}
	}
	
	/**
	 * RCS JSON규격 생성
	 * @param smsReqData
	 * @throws Exception
	 */
	public void RCSStringToJson(SmsReqData smsReqData) throws Exception{
		String msgDstic = smsReqData.getMsgDstic();
		List<ImgTmplData> rcsImgList = smsReqData.getRcsImgList();
		int iSlideCnt = rcsImgList == null ? 0 : rcsImgList.size();
		
		// 1. 채널별전문내용
		String chnlCntns = "{"
				+ "  \"brandId\":\"\","
				+ "  \"expiryOption\":\"2\","	// "2" 고정
				+ "  \"header\": \"\","			// "0" (광고) 표시없음 / "1" (광고) 표시
				+ "  \"footer\": \"\","			//수신거부 전화번호
				+ "  \"copyAllowed\":\"1\","	//"1" (복사허용)  고정
				+ "  \"serviceType\":\"\"," 	// SR : SMS / LR : LMS / ST : MMS StandAlone Tall / SM : MMS StandAlone Medium / CS : Carousel Small / CM : Carousel Medium
				+ "  \"extraTitle\":[],"		//메시지 제목 배열 (배열 순서대로 2 ~ 6 카드에 대한 데이터)
				+ "  \"extraDescription\":[],"	//메시지내용 배열 (배열 순서대로 2 ~ 6 카드에 대한 데이터)
				+ "  \"vButton\":{}"			//템플릿 (TR) 발송시 가변 버튼 관련 Key : Value
				+ "}";
		JSONObject chnlCntns_json = new JSONObject(chnlCntns);

		// 2. 채널별옵션내용 (MMS 이미지정보)
		JSONArray jsonArray1 = new JSONArray(); // 이미지 명
		JSONArray jsonArray2 = new JSONArray(); // 캐러셀 제목 2~6 슬라이드
		JSONArray jsonArray3 = new JSONArray(); // 캐러셀 내용 2~6 슬라이드
		JSONArray jsonArray4 = new JSONArray(); // 20220.10.06 이미지 시퀀스 추가
		String chnlOpt = "{"
				+ "  \"etc\": {"
				+ "    \"slideCount\": \"\","
				+ "    \"mediaPaths\": [],"
				+ "    \"imgSeqs\": []"
				+ "  }"
				+ "}";
		JSONObject chnlOpt_json = new JSONObject(chnlOpt);
		String serviceType = msgDstic;
		String sChnlTmpltID = "";
		String cardType = smsReqData.getCardType();
				
		if("SR".equals(msgDstic)) {
			sChnlTmpltID = "SS000000";
		} else if("LR".equals(msgDstic)) {
			sChnlTmpltID = "SL000000";
		} else if("MR".equals(msgDstic)){
			if("Standalone".equals(cardType)) {
				serviceType = "SM";
				sChnlTmpltID = "SMwThM00";
				if(CollectionUtils.isNotEmpty(rcsImgList)) {
					// 이미지 등록(이미지 시퀀스 얻기)
					int mmsImgId =  this.insertImageBlob(rcsImgList.get(0));
					
					// 값 셋팅
					jsonArray1.put(0, rcsImgList.get(0).getImgNm());
					jsonArray4.put(0, mmsImgId);
				}
				chnlOpt_json.getJSONObject("etc").put("slideCount", "1");
				chnlOpt_json.getJSONObject("etc").put("mediaPaths", jsonArray1);
				chnlOpt_json.getJSONObject("etc").put("imgSeqs", jsonArray4);

			} else if("Carousel".equals(cardType)) {
				serviceType = "CM";
				sChnlTmpltID = "CMwMhM0"+iSlideCnt+"00";
				
				// 슬라이드1은 메시지 제목, 메시지 내용 컬럼에 셋팅하고, 슬라이드2부터 채널별전문내용에 json 포맷에 값 셋팅. 
				if(CollectionUtils.isNotEmpty(rcsImgList)) {
					int i = 0;
					for(ImgTmplData item : rcsImgList) {
						// 이미지 등록(이미지 시퀀스 얻기)
						int mmsImgId =  this.insertImageBlob(item);
						
						// 값 셋팅
						jsonArray1.put(i, item.getImgNm());
						jsonArray4.put(i, mmsImgId);
						if(i != 0) {
							jsonArray2.put(item.getCsTitle()); //제목
							jsonArray3.put(item.getCsContents()); //내용
						}
						i++;
					}
					// 슬라이드1의 메시지내용,메시지제목 셋팅
					smsReqData.setUmsMsgCtnt(rcsImgList.get(0).getCsContents());
					smsReqData.setMsgCtnt(rcsImgList.get(0).getCsTitle());
				}
				
				chnlOpt_json.getJSONObject("etc").put("slideCount", Integer.toString(iSlideCnt));
				chnlOpt_json.getJSONObject("etc").put("mediaPaths", jsonArray1);
				chnlOpt_json.getJSONObject("etc").put("imgSeqs", jsonArray4);
				
				// 슬라이드2~6의 메시지내용,메시지제목 셋팅
				chnlCntns_json.put("extraTitle", jsonArray2);
				chnlCntns_json.put("extraDescription", jsonArray3);
			}
		}
		
		chnlCntns_json.put("serviceType", serviceType);
		
		// 수신거부 적용여부 셋팅
		String recvNoVar = smsReqData.getRecvNoVar();
		if ("Y".equals(smsReqData.getRecvRefusalYn())) {
			String rejectNo = (recvNoVar == null )? "080-894-3517": recvNoVar;
			chnlCntns_json.put("header", "1"); //광고 수록 여부
			chnlCntns_json.put("footer", rejectNo); //수신거부전화번호.
		} else {
			chnlCntns_json.put("header", "0");
			chnlCntns_json.put("footer", "");
		}
		
		smsReqData.setChannelMsgStandard("JS");
		smsReqData.setChannelTmplId(sChnlTmpltID);
		// 22.09.01 mediapath slash issue수정
		smsReqData.setChannelMsgText(chnlCntns_json.toString().replace("\\/", "/"));
		smsReqData.setChannelOptionText(chnlOpt_json.toString().replace("\\/", "/"));

		// 3.채널별버튼내용
		JSONArray suggestionsList = new JSONArray();
		List<List<Map<String, Object>>> btnInfoList = smsReqData.getBtnInfoList();
		if(CollectionUtils.isNotEmpty(btnInfoList)) {
			for(List<Map<String, Object>> arr : btnInfoList) {
				JSONArray btnList = new JSONArray();
				if(CollectionUtils.isNotEmpty(arr)) {
					for(Map<String, Object> item : arr) {
						JSONObject openUrl_json = new JSONObject(RcsTemplateUtils.URL_TMP);
						JSONObject copy_json = new JSONObject(RcsTemplateUtils.COPY_TMP);
						JSONObject dial_json = new JSONObject(RcsTemplateUtils.TEL_TMP);
						JSONObject show_json = new JSONObject(RcsTemplateUtils.COORDINATE_TMP);
						JSONObject search_json = new JSONObject(RcsTemplateUtils.QUERY_TMP);
						JSONObject location_json = new JSONObject(RcsTemplateUtils.POSITION_TMP);
						JSONObject calendar_json = new JSONObject(RcsTemplateUtils.CALENDAR_TMP);
						
						String btnAction = item.get("btnAction").toString();
						String btnNm = item.get("btnNm").toString();
						if ("url".equals(btnAction)) {
							openUrl_json.getJSONObject("action").getJSONObject("urlAction").getJSONObject("openUrl").put("url", item.get("info1"));
							openUrl_json.getJSONObject("action").put("displayText", btnNm);
							btnList.put(openUrl_json);
						} else if ("copy_to_clipboard".equals(btnAction)) {
							copy_json.getJSONObject("action").getJSONObject("clipboardAction").getJSONObject("copyToClipboard").put("text", item.get("info1"));
							copy_json.getJSONObject("action").put("displayText", btnNm);
							btnList.put(copy_json);
						} else if ("tel".equals(btnAction)) { //전화걸기
							dial_json.getJSONObject("action").getJSONObject("dialerAction").getJSONObject("dialPhoneNumber").put("phoneNumber", item.get("info1"));
							dial_json.getJSONObject("action").put("displayText", btnNm);
							btnList.put(dial_json);
						} else if ("show_location".equals(btnAction)) {  //지도보여주기(좌표)
							show_json.getJSONObject("action").getJSONObject("mapAction").getJSONObject("showLocation").getJSONObject("location").put("latitude", item.get("info1"));
							show_json.getJSONObject("action").getJSONObject("mapAction").getJSONObject("showLocation").getJSONObject("location").put("longitude", item.get("info2"));
							show_json.getJSONObject("action").getJSONObject("mapAction").getJSONObject("showLocation").getJSONObject("location").put("label", item.get("info3"));
							show_json.getJSONObject("action").getJSONObject("mapAction").getJSONObject("showLocation").put("fallbackUrl", item.get("info4"));
							show_json.getJSONObject("action").put("displayText", btnNm);
							btnList.put(show_json);
						} else if ("search_locations".equals(btnAction)) { //지도보여주기(쿼리)
							search_json.getJSONObject("action").getJSONObject("mapAction").getJSONObject("showLocation").getJSONObject("location").put("query", item.get("info1"));
							search_json.getJSONObject("action").getJSONObject("mapAction").getJSONObject("showLocation").put("fallbackUrl", item.get("info2"));
							search_json.getJSONObject("action").put("displayText", btnNm);
							btnList.put(search_json);
						} else if ("request_location_push".equals(btnAction)) { //현재위치공유
							location_json.getJSONObject("action").put("displayText", btnNm);
							btnList.put(location_json);
						} else if ("create_calendar_event".equals(btnAction)) { //캘린더등록
							String startTime = (String) item.get("info1");
							String endTime = (String) item.get("info2");
							startTime = dateFormat(startTime, "09");
							endTime = dateFormat(endTime, "09");
							calendar_json.getJSONObject("action").getJSONObject("calendarAction").getJSONObject("createCalendarEvent").put("startTime", startTime);
							calendar_json.getJSONObject("action").getJSONObject("calendarAction").getJSONObject("createCalendarEvent").put("endTime", endTime);
							calendar_json.getJSONObject("action").getJSONObject("calendarAction").getJSONObject("createCalendarEvent").put("title", item.get("info3"));
							calendar_json.getJSONObject("action").getJSONObject("calendarAction").getJSONObject("createCalendarEvent").put("description", item.get("info4"));
							calendar_json.getJSONObject("action").put("displayText", btnNm);
							btnList.put(calendar_json);
						}
					}
				}
				String suggestions_init = "{}";
				JSONObject suggestions_json = new Gson().fromJson(suggestions_init, JSONObject.class);
				
				if(btnList.length() > 0) {
					suggestions_json.put("suggestions", btnList);
				}
				suggestionsList.put(suggestions_json);
			}
			smsReqData.setChannelButtonText(suggestionsList.toString().replace("\\/", "/"));
		} else {
			smsReqData.setChannelButtonText("");
		}
	}
	
	/*
	 * 일정 등록 버튼 날짜 포맷 설정
	 * @return string
	 * @exception Exception
	 * */
	public String dateFormat(String date, String gmt) throws Exception{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		SimpleDateFormat sdf09 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss+09:00");
		// HH:mm => HH:mm:ss+09:00 
		if (gmt.equals("09")) {
			date = sdf09.format(sdf.parse(date)).replace(" ","T");			
		}
		// HH:mm:ss+09:00 => HH:mm
		else if (gmt.equals("00")) {
			date = date.replace("T", " ");
			if(checkDate(date)) {
				date = sdf.format(sdf09.parse(date));
			}else {
				date = date+" 00:00";
			}
		}
		return date;
	}
	
	 public static boolean checkDate(String checkDate) {
        try {
        	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss+09:00"); //검증할 날짜 포맷 설정
        	sdf.setLenient(false); //false일경우 처리시 입력한 값이 잘못된 형식일 시 오류가 발생
        	sdf.parse(checkDate); //대상 값 포맷에 적용되는지 확인
            return true;
        } catch (Exception e) {
            return false;
        }
    }
	 
	 /**
	 * 
	 * 치환 메시지 조립
	 * 
	 * @param msgContent, replaceValue
	 * @return replaceMsgContent
	 */
	public  StringBuffer var2message(String template , HashMap hash) 
	{
		StringBuffer retBuf = new StringBuffer(template);
		if ( retBuf == null ) return null;
		
		// 2022.05.10 Null 체크 추가
		if ( hash != null ) {
			Set cols = hash.keySet() ;
			Iterator itr = cols.iterator() ;
			// 템플릿에 변수가 남아 있는 조건을 추가하여, 불필요한 템플릿 검사 횟수를 줄임.
			while( itr.hasNext()  && retBuf.indexOf("${")!=-1   )
			{
				
				String Key = itr.next().toString();
				//			템플릿 내 $문자와의 혼동을 방지하기 위해 새로운 변수 패턴  ${변수명}을 사용한다.
				String newKey = "${" + Key + "}";				
				String Value = hash.get(Key).toString();
				//Convert VarField to VarValue
				int sbIdx = 0;
				int sbCnt = 0;
				int pos= 0; //변수값에 ${} 변수 포멧을 쓰는 경우. 무한루프가 되는 버그 패치( 2017.02.28 kbcard )
				for (int i = 0 ; (sbIdx = retBuf.indexOf(newKey,pos))!= -1 && i < 4096 ; i++)
				{
					//retBuf.replace(sbIdx, sbIdx + NAME_VAL_SIZE(6), Value);
					retBuf.replace(sbIdx, sbIdx + newKey.length(), Value);
					pos = sbIdx + Value.length();
					sbCnt++;
				}
				//if (sbCnt==0) return null;
			}
		}

		//if (retBuf.indexOf("$VAL")!=-1) return null;
		if (retBuf.indexOf("${")!=-1) return null;


		return retBuf;
	}
	
	public HashMap<String, String> jsonToMap(String json){
		ObjectMapper mapper = new ObjectMapper();
		HashMap<String,String> map = new HashMap<String,String>(15);
		//return (HashMap<String,String>) new Gson().fromJson(json, map.getClass());
		
		HashMap<String, String> result = new HashMap<>();
		try {
			result = mapper.readValue(json, map.getClass());
			return result;
		} catch(Exception e) {
			logger.error("[테스트발송 시, Exception 에러 발생]", e.getMessage());
		}
		
		return result;
	}

	/**
	 * 대상자 엑셀 정보 저장
	 * @param smsReqData
	 * @return
	 */
	public Map<String, Object> insertExcelBlob(FileUploadData item) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		String result = "FAIL";
		ByteArrayOutputStream baos = null;
		FileInputStream fis = null;
		
		try {
			// 1. 엑셀 BLOB값 셋팅
			String filePath = TKMFILES_RCV_DIR + System.getProperty("file.separator") + item.getFileNm();
			
			baos = new ByteArrayOutputStream();
			fis = new FileInputStream(filePath);

			byte[] buf = new byte[1024];
			int read = 0;

			while ((read=fis.read(buf, 0, buf.length)) != -1 ) {
				baos.write(buf, 0, read);
			}
			
			item.setFileCon(baos.toByteArray());
			
			// 2. 대상자 엑셀 정보 저장
			dao.insertExcelBlob(item);
			
			result = "SUCCESS";
			resultMap.put("fileId", item.getFileId());
		} catch(IOException e) {
			logger.error("[대상자 엑셀 정보 저장 시, IOException발생]", e.getMessage());
			throw new Exception(e);
		} catch(Exception e) {
			logger.error("[대상자 엑셀 정보 저장 시, Exception발생]", e.getMessage());
			throw new Exception(e);
		} finally {
			try {
		        fis.close();
		        baos.close();
			} catch(IOException ioe) {
				logger.error("[대상자 엑셀 정보 저장 finally, IOException발생]");
			} catch(Exception e) {
				logger.error("[대상자 엑셀 정보 저장 finally, Exception발생]");
			}
		}
		resultMap.put("result", result);
		return resultMap;
	}
	
	/**
	 * 이미지 저장
	 * @param item
	 * @return
	 * @throws Exception
	 */
	public int insertImageBlob(ImgTmplData item) throws Exception {
		ByteArrayOutputStream baos = null;
		FileInputStream fis = null;
		int mmsImgId = 0;
		
		try {
			int detailMmsImgId = item.getMmsImgId();
			
			if(detailMmsImgId > 0) {
				return detailMmsImgId;
			}
			// 1. 이미지 바이트 값 구하기
			boolean isRcs = item.isRcsYn();
			String filePath = IMAGES_UPLOADED_DIR + item.getImgUploadPath();
			String msgDstic = isRcs ? "MR" : "MM";
			if(isRcs) {
				filePath = IMAGES_RCS_UPLOADED_DIR + item.getImgUploadPath();
			}
			
			baos = new ByteArrayOutputStream();
			fis = new FileInputStream(filePath);

			byte[] buf = new byte[1024];
			int read = 0;

			while ((read=fis.read(buf, 0, buf.length)) != -1 ) {
				baos.write(buf, 0, read);
			}
			
			// 2-2. 파라미터 셋팅
			item.setImgSqn(1);
			item.setImgCon(baos.toByteArray());
			item.setImgTypeCd("B"); // 기본제공(B)
			item.setMsgDstic(msgDstic);
			
			// 2-3. 이미지 등록
			dao.insertImgTmpl(item);
			
			mmsImgId = item.getMmsImgId();
		} catch(IOException e) {
			logger.error("[이미지 저장 시, IOException발생]", e.getMessage());
			throw new Exception(e);
		} catch(Exception e) {
			logger.error("[이미지 저장 시, Exception발생]", e.getMessage());
			throw new Exception(e);
		} finally {
			try {
		        fis.close();
		        baos.close();
			} catch(IOException ioe) {
				logger.error("[이미지 저장 finally, IOException발생]");
			} catch(Exception e) {
				logger.error("[이미지 저장 finally, Exception발생]");
			}
		}
		
		return mmsImgId;
	}
	
	/**
	 * 사용자정보 조회
	 * @param emplId
	 * @return
	 */
	public SmsReqEmployeeInfo getUser(String emplId) {
		return dao.getUser(emplId);
	}

	public Map<String, Object> deleteImgFile(ImgTmplData item) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		String result = "FAIL";
		
		try {
			/*// 1. 이미지 BLOB 데이터 조회
			ImgTmplData data = dao.selectImgTmpl(item);
			
			// 2. 이미지 BLOB 데이터 삭제
			if(data != null) {
				dao.deleteImgTmpl(item);
			}*/
			
			// 이미지 파일 삭제
			boolean isRcs = item.isRcsYn();
			String filePath = IMAGES_UPLOADED_DIR + item.getImgUploadPath();
			if(isRcs) {
				filePath = IMAGES_RCS_UPLOADED_DIR + item.getImgUploadPath();
			}
			
			File file = new File(filePath);
			if (file.exists()) {
				if(file.delete()){
					result = "SUCCESS";
				}
			}
		} catch(Exception e) {
			logger.error("[이미지 삭제 시, Exception발생]", e.getMessage());
			throw new Exception(e);
		}
		resultMap.put("result", result);
		return resultMap;
	}
}
