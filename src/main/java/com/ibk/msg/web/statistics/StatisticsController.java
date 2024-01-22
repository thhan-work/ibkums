package com.ibk.msg.web.statistics;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ibk.msg.utils.ExcelCellDef;
import com.ibk.msg.utils.ExcelDef;
import com.ibk.msg.utils.ExcelExportUtil;
import com.ibk.msg.utils.ExcelMergeCellDef;
import com.ibk.msg.utils.ExcelSheetDef;
import com.ibk.msg.web.manage.Code;
import com.ibk.msg.web.manage.ManageService;

@Controller
public class StatisticsController {
	
	@Autowired
	private StatisticsService statisticsService;
	
	@Autowired
	private ManageService manageService;
	
	@GetMapping("/statistics-channel.ibk")
	public String statisticsChannel() {
		return "statistics/statistics-channel";
	}

	@GetMapping("/statistics-branch.ibk")
	public String statisticsBranch() {
		return "statistics/statistics-branch";
	}

	@GetMapping("/statistics-vendor.ibk")	
	public String statisticsVendor() {
		return "statistics/statistics-vendor";
	}

	@GetMapping("/statistics-failure.ibk")
	public String statisticsFailure() {
		return "statistics/statistics-failure";
	}

	@GetMapping("/statistics-send.ibk")
	public String statisticsSend() {
		return "statistics/statistics-send";
	}

	@GetMapping("/statistics-group.ibk")
	public String statisticsGroup() {
		return "statistics/statistics-group";
	}
	
	@RequestMapping(value="/statistics-branch", produces = {"application/json"})
	@ResponseBody
	public Object findBranchByPagination(BranchStatisticsSearchCondition searchCondition, HttpSession httpSession) throws Exception {
		return statisticsService.findBranchStatisticsByPagination(searchCondition);
	}

	@RequestMapping("/statistics-branch-excel.ibk")
	public void findBranchByExcel(HttpServletRequest request, BranchStatisticsSearchCondition searchCondition, HttpServletResponse response) throws Throwable {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");

		String fileName = String.format("영업점별통계(%s년%s월)_%s.xls"
				, searchCondition.getSearchYear(), searchCondition.getSearchMonth(), sdf.format(new Date()));
		
		String sheetName = String.format("영업점별통계 (%s년%s월)"
				, searchCondition.getSearchYear(), searchCondition.getSearchMonth());
		
		String title = String.format("영업점별통계 (%s년%s월)"
				, searchCondition.getSearchYear(), searchCondition.getSearchMonth());
		
		title += " / 본부부서 ["+("n".equals(searchCondition.getIncludeHead()) ? "미포함": "포함" )+"]";
		if (!"".equals(searchCondition.getBranchCode())) {
			title += " / 영업점 코드 ["+searchCondition.getBranchCode()+"]";
		}
		
		List<Map<Object, Object>> statisticsData = statisticsService.findBranchStatistics(searchCondition);

		String[] headerString = new String[] {
				"지역본부","영업점코드","영업점명","SMS","LMS", "MMS"
		};

		String[] dataString = new String[] {
				"DIST_HEADER","BRANCH_CODE","BRANCH_NAME","SMS","LMS", "MMS"
		};
		
		ExcelDef excelDef = new ExcelDef();
		excelDef.setFileName(fileName);
		
		ExcelSheetDef excelSheetDef = new ExcelSheetDef();
		excelSheetDef.convertMapDataToCellListAndAdd(sheetName, title, headerString, dataString, statisticsData);
		
		excelDef.addSheet(excelSheetDef);
		
		ExcelExportUtil.exportExcel(request, response, excelDef);
	}
	
	
	@RequestMapping(value="/statistics-channel", produces = {"application/json"})
	@ResponseBody
	public Object findChannelByPagination(ChannelStatisticsSearchCondition searchCondition, HttpSession httpSession) throws Exception {
		return statisticsService.findChannelStatisticsByPagination(searchCondition);
	}

	@RequestMapping("/statistics-channel-excel.ibk")
	public void findChannelByExcel(HttpServletRequest request, ChannelStatisticsSearchCondition searchCondition, HttpServletResponse response) throws Throwable {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");

		String fileName = String.format("채널별통계(%s년%s월)_%s.xls"
				, searchCondition.getSearchYear(), searchCondition.getSearchMonth(), sdf.format(new Date()));
		
		String sheetName = String.format("채널별통계 (%s년%s월)"
				, searchCondition.getSearchYear(), searchCondition.getSearchMonth());
		
		String title = String.format("채널별통계 (%s년%s월)"
				, searchCondition.getSearchYear(), searchCondition.getSearchMonth());
		
		if (!"".equals(searchCondition.getJobCode())) {
			title += " / 단위업무코드 ["+searchCondition.getJobCode()+"]";
		}
		
		if (!"".equals(searchCondition.getMessageType())) {
			title += " / 메시지구분 ["+searchCondition.getMessageType()+"]";
		}
		
		List<Map<Object, Object>> statisticsData = statisticsService.findChannelStatistics(searchCondition);

		String[] headerString = new String[] {
				"메시지구분","단위업무코드","단위업무명","성공건수","발송건수"
		};

		String[] dataString = new String[] {
				"MSG_DSTIC","JOB_CODE","JOB_NAME","SUCCESS_NUMBER","REQUESTS_NUMBER"
		};
		
		ExcelDef excelDef = new ExcelDef();
		excelDef.setFileName(fileName);
		
		ExcelSheetDef excelSheetDef = new ExcelSheetDef();
		excelSheetDef.convertMapDataToCellListAndAdd(sheetName, title, headerString, dataString, statisticsData);
		
		excelDef.addSheet(excelSheetDef);
		
		ExcelExportUtil.exportExcel(request, response, excelDef);
	}
	
	
	
	@RequestMapping(value="/statistics-failure", produces = {"application/json"})
	@ResponseBody
	public Object findFailureByPagination(FailureStatisticsSearchCondition searchCondition, HttpSession httpSession) throws Exception {
		return statisticsService.findFailureStatisticsByPagination(searchCondition);
	}

	@RequestMapping("/statistics-failure-excel.ibk")
	public void findFailureByExcel(HttpServletRequest request, FailureStatisticsSearchCondition searchCondition, HttpServletResponse response) throws Throwable {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");

		String fileName = String.format("실패유형통계(%s년%s월)_%s.xls"
				, searchCondition.getSearchYear(), searchCondition.getSearchMonth(), sdf.format(new Date()));
		
		String sheetName = String.format("실패유형통계 (%s년%s월)"
				, searchCondition.getSearchYear(), searchCondition.getSearchMonth());
		
		String title = String.format("실패유형통계 (%s년%s월)"
				, searchCondition.getSearchYear(), searchCondition.getSearchMonth());
		
		if (!"".equals(searchCondition.getFailureCode())) {
			title += " / 실패코드 ["+searchCondition.getFailureCode()+"]";
		}
		
		if (!"".equals(searchCondition.getMessageType())) {
			title += " / 메시지구분 ["+searchCondition.getMessageType()+"]";
		}
		
		List<Map<Object, Object>> statisticsData = statisticsService.findFailureStatistics(searchCondition);

		String[] headerString = new String[] {
				"메시지구분","실패코드","실패내용","실패건수","벤더사"
		};

		String[] dataString = new String[] {
				"MSG_DSTIC","FAILURE_CODE","FAILURE_DESC","FAILURE_NUMBER","VENDOR"
		};
		
		ExcelDef excelDef = new ExcelDef();
		excelDef.setFileName(fileName);
		
		ExcelSheetDef excelSheetDef = new ExcelSheetDef();
		excelSheetDef.convertMapDataToCellListAndAdd(sheetName, title, headerString, dataString, statisticsData);
		
		excelDef.addSheet(excelSheetDef);
		
		ExcelExportUtil.exportExcel(request, response, excelDef);
	}
	
	
	@RequestMapping(value="/statistics-vendor", produces = {"application/json"})
	@ResponseBody
	public Object findVendorByPagination(VendorStatisticsSearchCondition searchCondition, HttpSession httpSession) throws Exception {
		return statisticsService.findVendorStatisticsByPagination(searchCondition);
	}

	@RequestMapping("/statistics-vendor-excel.ibk")
	public void findVendorByExcel(HttpServletRequest request, VendorStatisticsSearchCondition searchCondition, HttpServletResponse response) throws Throwable {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");

		String fileName = String.format("벤더사별통계(%s년%s월)_%s.xls"
				, searchCondition.getSearchYear(), searchCondition.getSearchMonth(), sdf.format(new Date()));
		
		String sheetName = String.format("벤더사별통계 (%s년%s월)"
				, searchCondition.getSearchYear(), searchCondition.getSearchMonth());
		
		String title = String.format("벤더사별통계 (%s년%s월)"
				, searchCondition.getSearchYear(), searchCondition.getSearchMonth());
		
		if (!"".equals(searchCondition.getVendor())) {
			title += " / 벤더사 ["+searchCondition.getVendor()+"]";
		}
		
		List<Map<Object, Object>> statisticsData = statisticsService.findVendorStatistics(searchCondition);
		List<Code> codes = manageService.findDetailCodes("발송단가");
		Map<String, Map<String, Double>> priceMap = new HashMap<String, Map<String, Double>>();
		Map<String, Double> lgPrice = new HashMap<String, Double>();
		lgPrice.put("SM", 0d);
		lgPrice.put("LM", 0d);
		lgPrice.put("MM", 0d);
		lgPrice.put("FX", 0d);
		
		Map<String, Double> ktPrice = new HashMap<String, Double>();
		ktPrice.put("SM", 0d);
		ktPrice.put("LM", 0d);
		ktPrice.put("MM", 0d);
		ktPrice.put("FX", 0d);
		
		priceMap.put("KT", ktPrice);
		priceMap.put("LG", lgPrice);
		
		for(Code code : codes) {
			String[] displyNm =  code.getDsplyNm().split("_");
			String vendor = displyNm[0];
			String msgDstic = displyNm[1];
			double cdValue = Double.parseDouble(code.getCdValue());
			
			priceMap.get(vendor).put(msgDstic, cdValue);
		}

		List<String> vendorList = new ArrayList<String>();
		for(Map<Object, Object> data : statisticsData) {
			String vendor = (String) data.get("VENDOR");
			if (!vendorList.contains(vendor)) {
				vendorList.add(vendor);
			}
		}
		
		ExcelDef excelDef = new ExcelDef();
		excelDef.setFileName(fileName);
		
		ExcelSheetDef excelSheetDef = new ExcelSheetDef();
		excelSheetDef.setSheetName(sheetName);
		
		excelSheetDef.addCellMerge(new ExcelMergeCellDef(1, 1, 1, 11));
		excelSheetDef.addCell(new ExcelCellDef("title", 1, 1, title));
		
		excelSheetDef.addCellMerge(new ExcelMergeCellDef(3, 4, 1, 1));
		excelSheetDef.addCell(new ExcelCellDef("header", 3, 1, "벤더사"));
		
		excelSheetDef.addCellMerge(new ExcelMergeCellDef(3, 3, 2, 3));
		excelSheetDef.addCell(new ExcelCellDef("header", 3, 2, "SMS"));
		
		excelSheetDef.addCellMerge(new ExcelMergeCellDef(3, 3, 4, 6));
		excelSheetDef.addCell(new ExcelCellDef("header", 3, 4, "LMS"));
		
		excelSheetDef.addCellMerge(new ExcelMergeCellDef(3, 3, 7, 8));
		excelSheetDef.addCell(new ExcelCellDef("header", 3, 7, "MMS"));
		
		excelSheetDef.addCellMerge(new ExcelMergeCellDef(3, 3, 9, 10));
		excelSheetDef.addCell(new ExcelCellDef("header", 3, 9, "FAX"));
		
		excelSheetDef.addCellMerge(new ExcelMergeCellDef(3, 4, 11, 11));
		excelSheetDef.addCell(new ExcelCellDef("header", 3, 11, "이용요금"));
		
		excelSheetDef.addCell(new ExcelCellDef("header", 4, 2, "발송건수"));
		excelSheetDef.addCell(new ExcelCellDef("header", 4, 3, "금액"));
		excelSheetDef.addCell(new ExcelCellDef("header", 4, 4, "구분"));
		excelSheetDef.addCell(new ExcelCellDef("header", 4, 5, "발송건수"));
		excelSheetDef.addCell(new ExcelCellDef("header", 4, 6, "금액"));
		excelSheetDef.addCell(new ExcelCellDef("header", 4, 7, "발송건수"));
		excelSheetDef.addCell(new ExcelCellDef("header", 4, 8, "금액"));
		excelSheetDef.addCell(new ExcelCellDef("header", 4, 9, "발송건수"));
		excelSheetDef.addCell(new ExcelCellDef("header", 4, 10, "금액"));
		
		int row = 5;
		for(String vendor : vendorList) {
			excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row+2, 1, 1));
			excelSheetDef.addCell(new ExcelCellDef("data", row, 1, vendor));
			excelSheetDef.addCell(new ExcelCellDef("data", row+3, 1, "소계"));
			
			excelSheetDef.addCell(new ExcelCellDef("data", row, 4, "KT"));
			excelSheetDef.addCell(new ExcelCellDef("data", row+1, 4, "LGT"));
			excelSheetDef.addCell(new ExcelCellDef("data", row+2, 4, "SKT"));
			
			
			excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row+2, 2, 2));
			excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row+2, 3, 3));
			excelSheetDef.addCell(new ExcelCellDef("data", row, 2, getData(statisticsData, vendor, "SM", null)));
			excelSheetDef.addCell(new ExcelCellDef("data", row, 3, getPrice(statisticsData, priceMap, vendor, "SM", null)));
			
			excelSheetDef.addCell(new ExcelCellDef("data", row, 5, getData(statisticsData, vendor, "LM", "KTF")));
			excelSheetDef.addCell(new ExcelCellDef("data", row+1, 5, getData(statisticsData, vendor, "LM", "LGT")));
			excelSheetDef.addCell(new ExcelCellDef("data", row+2, 5, getData(statisticsData, vendor, "LM", "SKT")));
			excelSheetDef.addCell(new ExcelCellDef("data", row, 6, getPrice(statisticsData, priceMap, vendor, "LM", "KTF")));
			excelSheetDef.addCell(new ExcelCellDef("data", row+1, 6, getPrice(statisticsData, priceMap, vendor, "LM", "LGT")));
			excelSheetDef.addCell(new ExcelCellDef("data", row+2, 6, getPrice(statisticsData, priceMap, vendor, "LM", "SKT")));
			
			excelSheetDef.addCell(new ExcelCellDef("data", row, 7, getData(statisticsData, vendor, "MM", "KTF")));
			excelSheetDef.addCell(new ExcelCellDef("data", row+1, 7, getData(statisticsData, vendor, "MM", "LGT")));
			excelSheetDef.addCell(new ExcelCellDef("data", row+2, 7, getData(statisticsData, vendor, "MM", "SKT")));
			excelSheetDef.addCell(new ExcelCellDef("data", row, 8, getPrice(statisticsData, priceMap, vendor, "MM", "KTF")));
			excelSheetDef.addCell(new ExcelCellDef("data", row+1, 8, getPrice(statisticsData, priceMap, vendor, "MM", "LGT")));
			excelSheetDef.addCell(new ExcelCellDef("data", row+2, 8, getPrice(statisticsData, priceMap, vendor, "MM", "SKT")));
			
			excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row+2, 9, 9));
			excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row+2, 10, 10));
			excelSheetDef.addCell(new ExcelCellDef("data", row, 9, getData(statisticsData, vendor, "FX", null)));
			excelSheetDef.addCell(new ExcelCellDef("data", row, 10, getPrice(statisticsData, priceMap, vendor, "FX", null)));
			
			excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row+2, 11, 11));
			excelSheetDef.addCell(new ExcelCellDef("data", row, 11, "-"));
			
			excelSheetDef.addCell(new ExcelCellDef("data", row+3, 4, "-"));
			excelSheetDef.addCell(new ExcelCellDef("data", row+3, 2, getData(statisticsData, vendor, "SM", null)));
			excelSheetDef.addCell(new ExcelCellDef("data", row+3, 3, getPrice(statisticsData, priceMap, vendor, "SM", null)));
			
			excelSheetDef.addCell(new ExcelCellDef("data", row+3, 5, getData(statisticsData, vendor, "LM", null)));
			excelSheetDef.addCell(new ExcelCellDef("data", row+3, 6, getPrice(statisticsData, priceMap, vendor, "LM", null)));
			
			excelSheetDef.addCell(new ExcelCellDef("data", row+3, 7, getData(statisticsData, vendor, "MM", null)));
			excelSheetDef.addCell(new ExcelCellDef("data", row+3, 8, getPrice(statisticsData, priceMap, vendor, "MM", null)));
			
			excelSheetDef.addCell(new ExcelCellDef("data", row+3, 9, getData(statisticsData, vendor, "FX", null)));
			excelSheetDef.addCell(new ExcelCellDef("data", row+3, 10, getPrice(statisticsData, priceMap, vendor, "FX", null)));
			
			excelSheetDef.addCell(new ExcelCellDef("data", row+3, 11, getPrice(statisticsData, priceMap, vendor, null, null)));
			
			row += 4;
		}		
		excelSheetDef.addCell(new ExcelCellDef("data", row, 1, "합계"));
		
		excelSheetDef.addCell(new ExcelCellDef("data", row, 4, "-"));
		excelSheetDef.addCell(new ExcelCellDef("data", row, 2, getData(statisticsData, null, "SM", null)));
		excelSheetDef.addCell(new ExcelCellDef("data", row, 3, getPrice(statisticsData, priceMap, null, "SM", null)));
		
		excelSheetDef.addCell(new ExcelCellDef("data", row, 5, getData(statisticsData, null, "LM", null)));
		excelSheetDef.addCell(new ExcelCellDef("data", row, 6, getPrice(statisticsData, priceMap, null, "LM", null)));
		
		excelSheetDef.addCell(new ExcelCellDef("data", row, 7, getData(statisticsData, null, "MM", null)));
		excelSheetDef.addCell(new ExcelCellDef("data", row, 8, getPrice(statisticsData, priceMap, null, "MM", null)));
		
		excelSheetDef.addCell(new ExcelCellDef("data", row, 9, getData(statisticsData, null, "FX", null)));
		excelSheetDef.addCell(new ExcelCellDef("data", row, 10, getPrice(statisticsData, priceMap, null, "FX", null)));
		
		excelSheetDef.addCell(new ExcelCellDef("data", row, 11, getPrice(statisticsData, priceMap, null, null, null)));
		
		excelDef.addSheet(excelSheetDef);
		
		ExcelExportUtil.exportExcel(request, response, excelDef);
	}
	
	private long getData(List<Map<Object, Object>> statisticsData, String vendor, String msgDstic, String telco) {
		long ret = 0;
		for(Map<Object, Object> data : statisticsData) {
			
			String vendorItem = (String) data.get("VENDOR");
			String msgDsticItem = (String) data.get("MSG_DSTIC");
			String telcoItem = (String) data.get("TELCO_CODE");
			long successNumber = ((BigDecimal) data.get("SUCCESS_NUMBER")).intValue();
			
			if (vendor != null && !vendor.equals(vendorItem)) {
				continue;
			}
			if (msgDstic != null && !msgDstic.equals(msgDsticItem)) {
				continue;
			}
			if (telco != null && !telco.equals(telcoItem)) {
				continue;
			}
			
			ret += successNumber;
		}
		
		return ret;
	}
	
	private double getPrice(List<Map<Object, Object>> statisticsData, Map<String, Map<String, Double>> priceMap, String vendor, String msgDstic, String telco) {
		double ret = 0;
		for(Map<Object, Object> data : statisticsData) {
			String vendorItem = (String) data.get("VENDOR");
			String msgDsticItem = (String) data.get("MSG_DSTIC");
			String telcoItem = (String) data.get("TELCO_CODE");
			long successNumber = ((BigDecimal) data.get("SUCCESS_NUMBER")).intValue();
			
			if (vendor != null && !vendor.equals(vendorItem)) {
				continue;
			}
			if (msgDstic != null && !msgDstic.equals(msgDsticItem)) {
				continue;
			}
			if (telco != null && !telco.equals(telcoItem)) {
				continue;
			}
			
			ret += ((double)successNumber) * priceMap.get(vendorItem).get(msgDsticItem); 
		}
		
		return ret;
	}


	@RequestMapping(value="/statistics-send", produces = {"application/json"})
	@ResponseBody
	public Object findSendByPagination(HttpSession httpSession) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		String yyyyMM = sdf.format(new Date());
		
		return statisticsService.findSend(yyyyMM);
	}
	
	@RequestMapping(value="/statistics-sendgroup", produces = {"application/json"})
	@ResponseBody
	public Object findSendGroupByPagination(HttpSession httpSession) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		String yyyyMM = sdf.format(new Date());
		
		return statisticsService.findSendGroup(yyyyMM);
	}
	
	@RequestMapping(value="/statistics-sendgroup-change", produces = {"application/json"})
	@ResponseBody
	public Object changeSendGroup(@RequestParam Map<String,Object> map, HttpSession httpSession) throws Exception {
		
		return statisticsService.changeSendGroup(map);
	}
}
