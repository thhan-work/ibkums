package com.ibk.msg.web.manage;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.multipart.MultipartFile;

import com.ibk.msg.utils.ExcelDef;
import com.ibk.msg.utils.ExcelExportUtil;
import com.ibk.msg.utils.ExcelSheetDef;
import com.ibk.msg.web.statistics.ChannelStatisticsSearchCondition;

@Controller
public class ManageController {
	
	@Autowired
	private ManageService manageService;

	@GetMapping("/manage-code.ibk")
	public String manageCode() {
		return "manage/manage-code";
	}
	
	@GetMapping("/manage-codegroup.ibk")
	public String manageCodeGroup() {
		return "manage/manage-codegroup";
	}
	
	@GetMapping("/manage-jobcode.ibk")
	public String manageJobCode() {
		return "manage/manage-jobcode";
	}
	
	@RequestMapping(value="/manage-codegroup", produces = {"application/json"}, method=RequestMethod.GET)
	@ResponseBody
	public Object findCodeGroupByPagination(CodeGroupSearchCondition searchCondition, HttpSession httpSession) throws Exception {
		return manageService.findCodeGroupByPagination(searchCondition);
	}
	
	@RequestMapping(value="/manage-codegroup-all", produces = {"application/json"}, method=RequestMethod.GET)
	@ResponseBody
	public Object findCodeGroupByPaginationAll(HttpSession httpSession) throws Exception {
		return manageService.findCodeGroup();
	}
	
	@GetMapping("/manage-codegroup/{cmmnCd}")
    @ResponseBody
    public Object findCodeGroupDetail(@PathVariable("cmmnCd") String cmmnCd) throws Exception {
        return manageService.findDetailCodeGroup(cmmnCd);
    }

    @PutMapping(value = "/manage-codegroup/{cmmnCd}", produces = {"application/json"})
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public Object modifyCodeGroup(@PathVariable("cmmnCd") String cmmnCd
            , @RequestBody CodeGroup codeGroup, HttpSession session) throws Exception {
    	codeGroup.setRegEmplId(getWriter(session));
    	codeGroup.setGroupCoCd("IBK");
        return manageService.modifyCodeGroup(codeGroup);
    }

    @DeleteMapping("/manage-codegroup/{cmmnCd}")
    @ResponseBody
    public Object removeCodeGroup(@PathVariable("cmmnCd") String[] cmmnCd) throws Exception {
        return manageService.removeCodeGroup(cmmnCd);
    }

    @PostMapping(value = "/manage-codegroup", produces = {"application/json"})
    @ResponseBody
    @ResponseStatus(HttpStatus.CREATED)
    public Object addCodeGroup(@RequestBody CodeGroup codeGroup, HttpSession session) throws Exception {
    	codeGroup.setRegEmplId(getWriter(session));
    	codeGroup.setGroupCoCd("IBK");
        return manageService.addCodeGroup(codeGroup);
    }
    
    @GetMapping("/manage-codegroup/{cmmnCd}/count")
    @ResponseBody
    public int getCodeGroupCount(@PathVariable("cmmnCd") String cmmnCd) throws Exception {
        return manageService.findCodeGroupCount(cmmnCd);
    }
    
    
    
    @RequestMapping(value="/manage-code", produces = {"application/json"}, method=RequestMethod.GET)
	@ResponseBody
	public Object findCodeByPagination(CodeSearchCondition searchCondition, HttpSession httpSession) throws Exception {
		return manageService.findCodeByPagination(searchCondition);
	}
	
	@GetMapping("/manage-code/{cmmnCd}/{dsplyNm}")
    @ResponseBody
    public Object findCodeDetail(@PathVariable("cmmnCd") String cmmnCd, @PathVariable("dsplyNm") String dsplyNm) throws Exception {
        return manageService.findDetailCode(cmmnCd, dsplyNm);
    }
	
	@GetMapping("/manage-code/{cmmnCd}")
    @ResponseBody
    public Object findCodeDetails(@PathVariable("cmmnCd") String cmmnCd) throws Exception {
        return manageService.findDetailCodes(cmmnCd);
    }

    @PutMapping(value = "/manage-code/{cmmnCd}/{dsplyNm}", produces = {"application/json"})
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public Object modifyCode(@PathVariable("cmmnCd") String cmmnCd, @PathVariable("dsplyNm") String dsplyNm
            , @RequestBody Code code, HttpSession session) throws Exception {
    	code.setRegEmplId(getWriter(session));
    	code.setGroupCoCd("IBK");
        return manageService.modifyCode(code);
    }

    @DeleteMapping("/manage-code/{key}")
    @ResponseBody
    public Object removeCode(@PathVariable("key") String[] keys) throws Exception {
        return manageService.removeCode(keys);
    }

    @PostMapping(value = "/manage-code", produces = {"application/json"})
    @ResponseBody
    @ResponseStatus(HttpStatus.CREATED)
    public Object addCode(@RequestBody Code code, HttpSession session) throws Exception {
    	code.setRegEmplId(getWriter(session));
    	code.setGroupCoCd("IBK");
    	code.setOrdr(0);
        return manageService.addCode(code);
    }
    
    @GetMapping("/manage-code/{cmmnCd}/{dsplyNm}/count")
    @ResponseBody
    public int getCodeCount(@PathVariable("cmmnCd") String cmmnCd, @PathVariable("dsplyNm") String dsplyNm) throws Exception {
        return manageService.findCodeCount(cmmnCd, dsplyNm);
    }
    
    
    
    
    
    @RequestMapping(value="/manage-jobcode", produces = {"application/json"}, method=RequestMethod.GET)
	@ResponseBody
	public Object findJobCodeByPagination(JobCodeSearchCondition searchCondition, HttpSession httpSession) throws Exception {
		return manageService.findJobCodeByPagination(searchCondition);
	}
	
	@RequestMapping(value="/manage-jobcode-all", produces = {"application/json"}, method=RequestMethod.GET)
	@ResponseBody
	public Object findJobCodeByPaginationAll(HttpSession httpSession) throws Exception {
		return manageService.findJobCode();
	}
	
	@GetMapping("/manage-jobcode/{bzwkIdfr}")
    @ResponseBody
    public Object findJobCodeDetail(@PathVariable("bzwkIdfr") String bzwkIdfr) throws Exception {
        return manageService.findDetailJobCode(bzwkIdfr);
    }

    @PutMapping(value = "/manage-jobcode/{bzwkIdfr}", produces = {"application/json"})
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public Object modifyJobCode(@PathVariable("bzwkIdfr") String bzwkIdfr
            , @RequestBody JobCode jobCode, HttpSession session) throws Exception {
    	jobCode.setGroupCoCd("IBK");
    	jobCode.setBzwkChnlCd("IB");
    	jobCode.setBzwkGroupCd("IB");
        return manageService.modifyJobCode(jobCode);
    }

    @DeleteMapping("/manage-jobcode/{bzwkIdfr}")
    @ResponseBody
    public Object removeJobCode(@PathVariable("bzwkIdfr") String[] bzwkIdfr) throws Exception {
        return manageService.removeJobCode(bzwkIdfr);
    }

    @PostMapping(value = "/manage-jobcode", produces = {"application/json"})
    @ResponseBody
    @ResponseStatus(HttpStatus.CREATED)
    public Object addJobCode(@RequestBody JobCode jobCode, HttpSession session) throws Exception {
    	jobCode.setGroupCoCd("IBK");
    	jobCode.setBzwkChnlCd("IB");
    	jobCode.setBzwkGroupCd("IB");
        return manageService.addJobCode(jobCode);
    }
    
    @GetMapping("/manage-jobcode/{bzwkIdfr}/count")
    @ResponseBody
    public int getJobCodeCount(@PathVariable("bzwkIdfr") String bzwkIdfr) throws Exception {
        return manageService.findJobCodeCount(bzwkIdfr);
    }
    
    @PostMapping("/manage-jobcode-upload")
    @ResponseBody
    public Object singleFileUpload(@RequestParam("excelFile") MultipartFile excelFile, HttpSession httpSession) {

    	if (excelFile.isEmpty()||excelFile.getSize()==0) {
    		throw new IllegalArgumentException("upload file is empty");
    	}
    	
    	return manageService.processJobCodeExcel(excelFile);
    }
    
    @RequestMapping("/manage-jobcode-excel.ibk")
	public void findChannelByExcel(HttpServletRequest request, ChannelStatisticsSearchCondition searchCondition, HttpServletResponse response) throws Throwable {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd HHmmss");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HHmmss");

		String fileName = "서비스목록 SMS ("+ sdf.format(new Date()) + ").xls";
		String sheetName = "서비스목록 SMS ("+sdf2.format(new Date())+")";
		
		List<Map<Object, Object>> jobCodeData = manageService.findJobCode();

		String[] headerString = new String[] {"시스템명", "단위 상세코드", "업무내용", "담당부서", "업무담당자", "담당자 연락처", "현업부서", "현업 담당자", 
				"활동여부", "발송매체", "통지대상", "메시지조립여부", "메시지형태", "발송주기 및 시간", "개발 적용일", "인터페이스", 
				"함수 / 트리거 / DB 정보", "서비스 IP", "서비스 PORT", "단순통지", "거래에 영향 있는 통지", "거래 안되는 사유", "비고", 
				"고객접촉 IF 테이블", "동기 / 비동기", "IF ID", "타켓I/O", "서비스 ID", "UserID", "데이터저장경로"
			};

		String[] dataString = new String[] {"BZWK_NM", "BZWK_IDNFR", "INPT_CMD_CTNT", "RSPBL_DVSN_NAME", "RSPBL_PSN_NAME", "RSPBL_PSN_TELNO"
				, "EMPL_DVSN_NM", "EMPL_NAME", "LIVE_YN", "SEND_DSTIC", "NOTICE_OBJECT", "MSG_ASBL_STSIZ_CTNT", "SMPL_MSG_CTNT"
				, "VALD_FRQN_CTNT", "DVLM_YMS", "INTERFACE", "FUNC_TRI_INFO", "SERVICE_IP", "SERVICE_PORT", "SIMPLE_NOTICE"
				, "TRAN_EFFE_NOTICE", "TRAN_NO_REASON", "OUTPT_CMD_CTNT", "CUST_CONT_IF", "SYN_ASYN", "IF_ID", "TARGET_IO"
				, "SERVICE_ID", "USER_ID", "DATA_SAVE_PATH"};
		
		ExcelDef excelDef = new ExcelDef();
		excelDef.setFileName(fileName);
		
		ExcelSheetDef excelSheetDef = new ExcelSheetDef();
		excelSheetDef.setLeftMargin(0);
		excelSheetDef.setTopMargin(0);
		excelSheetDef.convertMapDataToCellListAndAdd(sheetName, null, headerString, dataString, jobCodeData);
		
		excelDef.addSheet(excelSheetDef);
		
		ExcelExportUtil.exportExcel(request, response, excelDef);
	}

    
    private String getWriter(HttpSession session) {
        return (String) session.getAttribute("EMPL_NAME");
    }
    
    
    
}
