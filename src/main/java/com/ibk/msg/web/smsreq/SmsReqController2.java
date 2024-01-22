package com.ibk.msg.web.smsreq;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
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
import org.springframework.web.servlet.ModelAndView;

import com.google.common.base.Preconditions;
import com.ibk.msg.utils.TobeFileHandler;

@Controller
@PropertySources({
	@PropertySource("classpath:local.properties")
	, @PropertySource(value="classpath:${spring.profiles.active}.properties", ignoreResourceNotFound=true)
})
public class SmsReqController2 {
	private static final Logger logger = LoggerFactory.getLogger(SmsReqController.class);

	@Value("${upload.path.customers}")
	private String CUSTOMERS_UPLOADED_DIR;

	@Value("${upload.path.images}")
	private String IMAGES_UPLOADED_DIR;

	@Autowired
	private SmsReqService service;

	@GetMapping("/smsreq2.ibk")
	public ModelAndView viewCommissioned() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("sms-req/sms-req-info");
		// TODO : 기안부서 팀장을 조회 하여 값을 넣어 주어야 합니다.
		modelAndView.addObject("empPosition", "팀장");
		modelAndView.addObject("empName", "기팀장");
		modelAndView.addObject("empId", "foo");

		service.initPage(modelAndView);    

		return modelAndView;
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

	/*  @PostMapping("/smsreq/file/customers")
  @ResponseBody
  public Object addCustomerFiles(@RequestParam("file") MultipartFile uploadFile, HttpSession session) {
    if (uploadFile.isEmpty()) {
      throw new IllegalArgumentException("upload file is empty");
    }
    String addFileFullPath = service.saveUploadedFile(uploadFile, CUSTOMERS_UPLOADED_DIR);
    // TODO : 세션이 필요 할지도 모름니다. 임시저장 때문에? 취소 때문에?
    session.setAttribute("targetFile", addFileFullPath);
    return getResponseUploadFiles(uploadFile, addFileFullPath);
  }*/
	@PostMapping("/smsreq/file/customers")
	@ResponseBody
	public Object addCustomerFiles(@RequestParam("file") MultipartFile uploadFile, HttpServletRequest request) {
		if (uploadFile.isEmpty()) {
			throw new IllegalArgumentException("upload file is empty");
		}

		String groupUniqNo=   request.getParameter("groupUniqNo");
		String sendType=   request.getParameter("sendType");//m or g
		boolean dupCheck = true;
		String filePath=   CUSTOMERS_UPLOADED_DIR;
		HashMap<String, Object> result = service.handleFile(uploadFile, groupUniqNo,sendType,filePath, dupCheck);

		return result;
	}
	// TODO : 임시 저장 로직 
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

	// TODO : 결제 의뢰 로직 
	@PostMapping("/smsreq")
	@ResponseBody
	public Object save(@RequestBody SmsReqData smsReqData, HttpSession session) {
		logger.info("##SAVE / SMSREQDATA=" + smsReqData.toString());
		setAddressBySession(session, smsReqData);

		try {
			if(smsReqData.isConfirmCheck()){
				service.save(smsReqData);
			}else{
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
	public Object findByPagination(SmsReqEmployeeInfoSearchCondition searchCondition) throws Exception {
		return service.findByPagination(searchCondition);
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
		}
	}

}
