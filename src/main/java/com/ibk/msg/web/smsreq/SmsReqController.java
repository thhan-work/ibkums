package com.ibk.msg.web.smsreq;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.concurrent.atomic.AtomicInteger;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.tika.Tika;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.base.Preconditions;
import com.ibk.msg.utils.TobeFileHandler;
import com.ibk.msg.web.common.CommonService;
import com.ibk.msg.web.manage.Code;

@Controller
@RequestMapping(value = "/campaign")
@PropertySources({
	@PropertySource("classpath:local.properties")
	, @PropertySource(value="classpath:${spring.profiles.active}.properties", ignoreResourceNotFound=true)
})
public class SmsReqController {
	private static final Logger logger = LoggerFactory.getLogger(SmsReqController.class);

	@Value("${upload.path.customers}")
	private String CUSTOMERS_UPLOADED_DIR;
	
	@Value("${upload.path.rcv}")
	private String TKMFILES_RCV_DIR;

	@Value("${upload.path.images}")
	private String IMAGES_UPLOADED_DIR;
	
	@Value("${upload.path.images.rcs}")
	private String IMAGES_RCS_UPLOADED_DIR;

	@Autowired
	private SmsReqService service;
	
	@Autowired
	private CommonService commonService;
	
	private static AtomicInteger ai = new AtomicInteger();

	@GetMapping(value= {"/smsreq.ibk", "/smsreq.ibk/{groupUniqNo}"})
	public ModelAndView viewCommissioned(HttpSession session, 
			@PathVariable(required=false) String groupUniqNo,
			@RequestParam(value="curStep", required=false) String curStep) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		// 22.06.28 공통코드 조회 추가(대상자검증결과코드)
		String[] arr = {"대상자검증결과코드"};
		HashMap<String, List<Code>> codeMap = commonService.selectCodeList(arr);
		mv.addObject("codeMap", codeMap);
		
		// 22.07.01 발송상세 조회 추가
		if(StringUtils.isNotEmpty(groupUniqNo)) {
			T21Data msgDetail = service.getSmsDetail(groupUniqNo);
			
			// 치환변수 맥스값 조회
			String replaceValJsonStr = service.getReplaceVal(groupUniqNo);
			
			ObjectMapper mapper = new ObjectMapper();
			mv.addObject("msgDetail", mapper.writeValueAsString(msgDetail));
			mv.addObject("groupUniqNo", groupUniqNo);
			mv.addObject("curStep", curStep);
			mv.addObject("replaceValJsonStr", replaceValJsonStr);
		} else {
			service.initPage(mv);
		}
		
		// 로그인한 사용자정보 조회
		String emplId = (String)session.getAttribute("EMPL_ID");
		SmsReqEmployeeInfo user = service.getUser(emplId);
		mv.addObject("emplId", emplId);
		mv.addObject("emplName", (String)session.getAttribute("EMPL_NAME"));
		mv.addObject("emplBoName", (String)session.getAttribute("EMPL_BONAME"));
		mv.addObject("emplBocode", (String)session.getAttribute("EMPL_BOCODE"));
		mv.addObject("emplHpNo", user.getEmplHpNo());
		
		mv.setViewName("campaign/sms-req/sms-req");
		// 22.07.18 주석처리
		// TODO : 기안부서 팀장을 조회 하여 값을 넣어 주어야 합니다.
		//mv.addObject("empPosition", "팀장");
		//mv.addObject("empName", "기팀장");
		//mv.addObject("empId", "foo");
		
		return mv;
	}

	@RequestMapping("/smsreq/download/sample/{type}")
	public void downloadBulkSampleFile(@PathVariable("type") String type, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String appPath = request.getServletContext().getRealPath("");
		String filePath="download/sms_request.xls";
		if(type.equalsIgnoreCase("extra")) {
			filePath="download/sms_request_extra.xls";
		}
		File downloadFile=new File(appPath+filePath);
		if(!downloadFile.exists()) {
			throw new IllegalArgumentException("download file is empty");
		}
		TobeFileHandler.downloadFile(downloadFile, request, response);
	}

	@PostMapping("/smsreq/file/images")
	@ResponseBody
	public Object addImageFiles(@RequestParam("file") MultipartFile uploadFile, HttpSession session) throws Exception {
		if (uploadFile.isEmpty()) {
			throw new IllegalArgumentException("upload file is empty");
		}
		String addFileFullPath = service.saveUploadedFile(uploadFile, IMAGES_UPLOADED_DIR);
		return getResponseUploadFiles(uploadFile, addFileFullPath);
	}

	@RequestMapping("/smsreq/file/getIMG/{groupUniqNo}")
	public Object getIMG(@PathVariable("groupUniqNo") String groupUniqNo, HttpSession session) throws Exception {
		SmsReqData rs =  service.getIMG(groupUniqNo);
		byte[] imageContent = (byte[]) rs.getImage1();
		final HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.IMAGE_JPEG);
		return new ResponseEntity<byte[]>(imageContent, headers, HttpStatus.OK);
	}

	/**
	 * 발송대상 엑셀 업로드
	 * @param uploadFile
	 * @param request
	 * @return
	 */
	@PostMapping("/smsreq/file/customers")
	@ResponseBody
	public Object addCustomerFiles(@RequestParam("file") MultipartFile uploadFile, HttpServletRequest request) {
		if (uploadFile.isEmpty()) {
			throw new IllegalArgumentException("upload file is empty");
		}

		String groupUniqNo = request.getParameter("groupUniqNo");
		String filePath = TKMFILES_RCV_DIR;
		HashMap<String, Object> result = (HashMap<String, Object>)TobeFileHandler.excelUpload(uploadFile, groupUniqNo, filePath);

		return result;
	}
	/**
	 * 임시저장
	 * @param smsReqData
	 * @param session
	 * @return
	 */
	@PostMapping("/smsreq/temp")
	@ResponseBody
	public Object saveTemp(@RequestBody SmsReqData smsReqData, HttpSession session) {
		logger.info("##SAVE_TEMP / SMSREQDATA="+smsReqData.toString());
		setAddressBySession(session, smsReqData);

		try {
			service.saveTemp(smsReqData);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return null;
	}

	/**
	 * 발송승인요청
	 * @param smsReqData
	 * @param session
	 * @return
	 */
	@PostMapping("/smsreq")
	@ResponseBody
	public Object save(@RequestBody SmsReqData smsReqData, HttpSession session) {
		logger.info("##SAVE / SMSREQDATA=" + smsReqData.toString());
		setAddressBySession(session, smsReqData);
		
		try {
			if(smsReqData.isConfirmCheck()){
				// 결재진행
				service.save(smsReqData);
			}else{
				// 결재없이 발송승인요청
				service.saveNoConfirm(smsReqData);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return null;
	}

	/**
	 * 발송 희망일 시간 별 전체 발송 건수 조회
	 * 
	 * @param requestData
	 * @param model
	 * @param httpSession
	 * @return
	 */
	@PostMapping("/smsreq/totalcnt")
	@ResponseBody
	public Object selectDateTotalCount(@RequestBody Map<String, Object> requestData, Model model, HttpSession httpSession){
		logger.info("##DATE="+requestData.get("date"));
		logger.info("##TIMELIST="+requestData.get("timeList"));

		HashMap<String, Object> result = service.getDateTotalCnt(requestData);
		return result;
	}

	@PostMapping("/smsreq/savecnt")
	@ResponseBody
	public Object selectDateSaveCount(@RequestBody Map<String, Object> requestData, Model model, HttpSession httpSession){
		logger.info("##GROUP_UNIQ_NO="+requestData.get("groupUniqNo"));
		logger.info("##TIMELIST="+requestData.get("timeList"));

		HashMap<String, Object> result = service.getDateSaveCnt(requestData);
		TreeMap<String, Object> treeResult = new TreeMap<String,Object>(result); // 오름차순 정렬
		logger.info("##RESULTLIST="+treeResult.toString());

		return treeResult; // {일자1 : {시간1:건수1, 시간2:건수2, ...}, 일자2 : {시간1:건수1, 시간2:건수2 ...}, ...} 
	}

	@PostMapping("/smsreq/savecnt2")
	@ResponseBody
	public Object selectDateSaveCount2(@RequestBody Map<String, Object> requestData, Model model, HttpSession httpSession){
		logger.info("##GROUP_UNIQ_NO="+requestData.get("groupUniqNo"));

		HashMap<String, Object> result = service.getDateSaveCnt2(requestData);
		TreeMap<String, Object> treeResult = new TreeMap<String,Object>(result); // 오름차순 정렬
		logger.info("##RESULTLIST="+treeResult.toString());

		return treeResult; // {일자1 : {시간1:건수1, 시간2:건수2, ...}, 일자2 : {시간1:건수1, 시간2:건수2 ...}, ...} 
	}


	@GetMapping("/smsreq/employee")
	@ResponseBody
	public Object findByPagination(SmsReqEmployeeInfoSearchCondition searchCondition, HttpSession session) throws Exception {
		searchCondition.setBoCode((String)session.getAttribute("EMPL_BOCODE"));
		return service.findByPagination(searchCondition);
	}
	
	/**
	 * 카카오알림톡 템플릿 목록 조회
	 * @param searchCondition
	 * @return
	 * @throws Exception
	 */
	@GetMapping("/smsreq/alimtalk")
	@ResponseBody
	public Object findAlimTalkByPagination(AlimTalkSearchCondition searchCondition) throws Exception {
		return service.findAlimTalkByPagination(searchCondition);
	}
	
	/**
	 * 카카오알림톡 템플릿  상세 조회
	 * @param searchCondition
	 * @return
	 * @throws Exception
	 */
	@PostMapping("/smsreq/alimtalkDtl")
	@ResponseBody
	public Object selectAlimTalkDetail(@RequestBody AlimTalkSearchCondition searchCondition) throws Exception {
		return service.selectAlimTalkDetail(searchCondition);
	}
	
	/**
	 * RCS템플릿 조회
	 * @param searchCondition
	 * @return
	 * @throws Exception
	 */
	@GetMapping("/smsreq/rcsTemplate")
	@ResponseBody
	public Object findRcsTemplateByPagination(RcsTemplateSearchCondition searchCondition) throws Exception {
		return service.findRcsTemplateByPagination(searchCondition);
	}
	
	/**
	 * 발송대상자 조회
	 * @param searchCondition
	 * @return
	 * @throws Exception
	 */
	@GetMapping("/smsreq/sendTargetList")
	@ResponseBody
	public Object findSendTargetListByPagination(SendTargetSearchCondition searchCondition) throws Exception {
		return service.findSendTargetListByPagination(searchCondition);
	}
	
	/**
	 * 업로드한 엑셀의 T26 처리상태 확인
	 * @param paramData - T26ID
	 * @param model
	 * @return string - json
	 * @exception Exception
	 */
	@PostMapping("/smsreq/targetFileStatusChk.do")
	@ResponseBody
	public Object targetDataChk(SendTargetMasterInfo param) throws Exception {
		return service.selectTargetFileStatusChk(param);
	}
	
	/**
	 * 발송대상자 삭제
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@PostMapping("/smsreq/deleteSendTgt")
	@ResponseBody
	public Object deleteSendTgt(@RequestBody SendTargetMasterInfo param) throws Exception {
		return service.deleteSendTgt(param);
	}
	
	private Object getResponseUploadFiles(
			@RequestParam("file") MultipartFile uploadFile,
			String addFileFullPath) throws Exception {
		if (StringUtils.isNotEmpty(addFileFullPath)) {
			Map<String, Object> resMap = new HashMap<>();
			resMap.put("fileName", uploadFile.getName());
			resMap.put("fileBLOB", uploadFile.getBytes());
			return resMap;
		} else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	/**
	 * 테스트 발송
	 * @param 
	 * @return
	 * @throws Exception
	 */
	@PostMapping("/smsreq/testSend")
	@ResponseBody
	public Map<String, Object> testSend(@RequestBody SmsReqData smsReqData, HttpSession session) throws Exception {
		setAddressBySession(session, smsReqData);
		Map<String, Object> resultMap = service.testSend(smsReqData);
		return resultMap;
	}
	
	/**
	 * 업로드대상자의(T28) 1번째 행의 치환변수값 조회
	 * @param 
	 * @return
	 * @throws Exception
	 */
	@PostMapping("/smsreq/getReplaceVal")
	@ResponseBody
	public String getReplaceVal(@RequestBody SmsReqData smsReqData, HttpSession session) throws Exception {
		setAddressBySession(session, smsReqData);
		
		String groupUniqNo = smsReqData.getGroupUniqNo();
		String replaceValJsonStr = service.getReplaceVal(groupUniqNo);
		
		return replaceValJsonStr;
	}
	
	/**
	 * MMS, RCS-MMS 이미지 업로드
	 * 이미지 BLOB값을 얻기 위한 업로드
	 * @param request
	 * @return
	 */
	@RequestMapping("/smsreq/uploadImage")
	@ResponseBody
	public Object uploadImage(MultipartHttpServletRequest request) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat sdf2 = new SimpleDateFormat("HHmmssSSS");

		Map<String, Object> res = new HashMap<String, Object>();
		
		// rcsType - N(MMS), MR(RCS Standalone), CR(RCS Carousel)
		String rcsType = request.getParameter("rcsType");
		MultipartFile mpf = request.getFile("fileName");
		
		// 1. 파일 체크
		if(mpf.isEmpty() || mpf.getSize() == 0) {
			res.put("result", false);
			res.put("error", "파일이 업로드되지 않았습니다.");
			return res;
		}
		
		String originalFileName =  mpf.getOriginalFilename();
		// 2022.07.27 IE 파일원본명 이슈 수정
		originalFileName = originalFileName.substring(originalFileName.lastIndexOf("\\") + 1);
		int lastPos = originalFileName.lastIndexOf(".");
		String fileEx = originalFileName.substring(lastPos +1);
		
		// 2. 파일크기 체크
		long maxImageSize = "N".equals(rcsType) ? 300000L : 1000000L; 
		String maxImageSizeStr = "N".equals(rcsType) ? "300KB" : "1MB";
		if(mpf.getSize() > maxImageSize) {
			res.put("result", false);
			res.put("error", "파일 용량은 "+ maxImageSizeStr +" 이하로 등록하시기 바랍니다.");
			return res;
		}
		
		// 3. 파일 픽셀크기 체크
		int width = "CR".equals(rcsType) ? 696 : 1000; 
		int height = "CR".equals(rcsType) ? 1569 : 1000;
		
		// 22.12.12 inputstream close 이슈 수정
		InputStream inputStream1 = mpf.getInputStream();
		BufferedImage bufferedImage = ImageIO.read(inputStream1);
	    if(bufferedImage.getWidth() >= width || bufferedImage.getHeight() > height){
	    	res.put("result", false);
			res.put("error", "파일의 픽셀크기는 "+ width +" X "+ height +"을 넘지 말아야 합니다.");
			return res;
	    }
	    
		// 4. 확장자 체크
	    InputStream inputStream2 = mpf.getInputStream();
		String mimeType = new Tika().detect(inputStream2);
		if ( !(mimeType.equalsIgnoreCase("image/jpg") || mimeType.equalsIgnoreCase("image/jpeg")) ) {
			if(!"N".equals(rcsType)) {
				if(!(mimeType.equalsIgnoreCase("image/png"))) {
					res.put("result", false);
					res.put("error", "jpg, jpeg, png 파일만 등록이 가능합니다.");
					return res;
				}
			} else {
				res.put("result", false);
				res.put("error", "jpg나 jpeg 파일만 등록이 가능합니다.");
				return res;
			}
		}
		
		// 5. 이미지 업로드
		String uploadDir = IMAGES_UPLOADED_DIR;
		if(!"N".equals(rcsType)) {
			uploadDir = IMAGES_RCS_UPLOADED_DIR;
		}

		String dirName = sdf.format(new Date());
		int seq = ai.incrementAndGet();
		if (seq == 999) {
			ai.set(0);
		}
		String fileName = sdf2.format(new Date()) +"_"+ String.format("%03d", seq);
		String responsePath = "/" + dirName + "/" + fileName + "." + fileEx;
		String uploadPath = uploadDir + "/"  +  dirName ;
		String uploadFilePath = uploadDir + responsePath;
		
		if (!new File(uploadPath).exists()) {
			new File(uploadPath).mkdirs();
		}
		
		try {
			File file = new File(uploadFilePath);
			mpf.transferTo(file);
			res.put("result", true);
			res.put("filename", responsePath);
			res.put("orgFileName", originalFileName);
		} catch (Exception e) {
			res.put("result", false);
			res.put("error", e.toString());
			e.printStackTrace();
		} finally {
			try {
		        if(inputStream1 != null) {
		        	inputStream1.close();
		        }
		        if(inputStream2 != null) {
		        	inputStream2.close();
		        }
			} catch(IOException ioe) {
				logger.error("[이미지 업로드 중 finally, IOException발생]");
			} catch(Exception e) {
				logger.error("[이미지 업로드 중 finally, Exception발생]");
			}
		}
		return res;
	}
	
	/**
	 * 대상자 엑셀 정보 저장
	 * @param 
	 * @return
	 * @throws Exception
	 */
	@PostMapping("/smsreq/insertExcelBlob")
	@ResponseBody
	public Object insertExcelBlob(@RequestBody FileUploadData item, HttpSession session) throws Exception {
		setAddressBySession(session, item);
		return service.insertExcelBlob(item);
	}
	
	/**
	 * 이미지 정보 저장
	 * @param 
	 * @return
	 * @throws Exception
	 */
	@PostMapping("/smsreq/insertImageBlob")
	@ResponseBody
	public Object insertImageBlob(@RequestBody ImgTmplData item, HttpSession session) throws Exception {
		setAddressBySession(session, item);
		return service.insertImageBlob(item);
	}
	
	/**
	 * 이미지 정보 삭제
	 * @param 
	 * @return
	 * @throws Exception
	 */
	@PostMapping("/smsreq/deleteImgFile")
	@ResponseBody
	public Object deleteImgFile(@RequestBody ImgTmplData item, HttpSession session) throws Exception {
		setAddressBySession(session, item);
		return service.deleteImgFile(item);
	}
	
	private void setAddressBySession(HttpSession session,Object obj) {
		if(obj instanceof SmsReqData)
		{
			SmsReqData changObj = (SmsReqData) obj;
			
			if(session.getAttribute("EMPL_ID") ==null) {
				Preconditions.checkArgument(false, "session empl_id is empty");  
			}else {
				changObj.setEmplId((String)session.getAttribute("EMPL_ID")); 
			}

			if(session.getAttribute("EMPL_BOCODE")==null) {
				//Preconditions.checkArgument(false, "session empl_bocode is empty");
			}else {
				changObj.setBoCode((String)session.getAttribute("EMPL_BOCODE"));
			} 
		} else if(obj instanceof FileUploadData) {
			FileUploadData changObj = (FileUploadData) obj;
			
			if(session.getAttribute("EMPL_ID") ==null) {
				Preconditions.checkArgument(false, "session empl_id is empty");  
			}else {
				changObj.setEmn((String)session.getAttribute("EMPL_ID")); 
			}

			if(session.getAttribute("EMPL_BOCODE") != null) {
				changObj.setDvcd((String)session.getAttribute("EMPL_BOCODE"));
			} 
		} else if(obj instanceof ImgTmplData) {
			ImgTmplData changObj = (ImgTmplData) obj;
			
			if(session.getAttribute("EMPL_ID") ==null) {
				Preconditions.checkArgument(false, "session empl_id is empty");  
			}else {
				changObj.setEmn((String)session.getAttribute("EMPL_ID")); 
			}

			if(session.getAttribute("EMPL_BOCODE") != null) {
				changObj.setDvcd((String)session.getAttribute("EMPL_BOCODE"));
			} 
		}
	}
}
