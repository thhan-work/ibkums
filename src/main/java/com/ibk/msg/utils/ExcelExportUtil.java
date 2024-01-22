package com.ibk.msg.utils;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public final class ExcelExportUtil {

	private static String getBrowser(HttpServletRequest request) { 
		String header = request.getHeader("User-Agent"); 
		if (header.indexOf("MSIE") > -1) { return "MSIE"; } 
		else if (header.indexOf("Chrome") > -1) { return "Chrome"; } 
		else if (header.indexOf("Opera") > -1) { return "Opera"; } 
		else if (header.indexOf("Trident/7.0") > -1){ 
			//IE 11 이상 //IE 버전 별 체크 >> Trident/6.0(IE 10) , Trident/5.0(IE 9) , Trident/4.0(IE 8) 
			return "MSIE"; 
		} 
		return "Firefox";
	}

	private static String getDisposition(String filename, String browser) throws Exception { 
		String encodedFilename = null; 
		if (browser.equals("MSIE")) { 
			encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20"); 
		} else if (browser.equals("Firefox")) { 
			encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\""; 
		} else if (browser.equals("Opera")) { 
			encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\""; 
		} else if (browser.equals("Chrome")) { 
			StringBuffer sb = new StringBuffer(); 
			for (int i = 0; i < filename.length(); i++) { 
				char c = filename.charAt(i); 
				if (c > '~') { 
					sb.append(URLEncoder.encode("" + c, "UTF-8"));
				} else { 
					sb.append(c); 
				} 
			} 
			encodedFilename = sb.toString(); 
		} else { 
			throw new RuntimeException("Not supported browser"); 
		} return encodedFilename; 
	}
	
	public static void exportExcel(HttpServletRequest request, HttpServletResponse response, ExcelDef excelDef) throws Exception {
		response.setHeader("Content-Type", "application/msexcel; charset=UTF-8");
		response.setHeader("Content-Disposition", "attachment; filename=" + getDisposition(excelDef.getFileName(), getBrowser(request)));
		
		Workbook wb=new HSSFWorkbook();
		
		Font fontTitle = wb.createFont();
		fontTitle.setBold(true);
		fontTitle.setFontHeightInPoints((short)15);
		//fontTitle.setColor(IndexedColors.WHITE.getIndex());
		
		Font font = wb.createFont();
		font.setBold(true);
		font.setFontHeightInPoints((short)10);
		
		Map<String, CellStyle> cellStyleMap = new HashMap<String, CellStyle>();
		
		CellStyle titleStyle = wb.createCellStyle();
		titleStyle.setFont(fontTitle);
		titleStyle.setAlignment(HorizontalAlignment.CENTER);
		titleStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		
		titleStyle.setBorderRight(BorderStyle.THIN);
		titleStyle.setBorderLeft(BorderStyle.THIN);
		titleStyle.setBorderTop(BorderStyle.THIN);
		titleStyle.setBorderBottom(BorderStyle.THIN);
		
		titleStyle.setFillForegroundColor(IndexedColors.PALE_BLUE.getIndex());
		titleStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		
		CellStyle headerStyle = wb.createCellStyle();
		headerStyle.setFont(font);
		//headerStyle.setBorderBottom(BorderStyle.THIN);
		headerStyle.setAlignment(HorizontalAlignment.CENTER);
		headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		
		headerStyle.setBorderRight(BorderStyle.THIN);
		headerStyle.setBorderLeft(BorderStyle.THIN);
		headerStyle.setBorderTop(BorderStyle.THIN);
		headerStyle.setBorderBottom(BorderStyle.THIN);
		headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
		headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND); 
		headerStyle.setWrapText(true);
		
		CellStyle dataStringStyle = wb.createCellStyle();		
		dataStringStyle.setAlignment(HorizontalAlignment.CENTER);
		dataStringStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		dataStringStyle.setWrapText(true);
		
		dataStringStyle.setBorderRight(BorderStyle.THIN);
		dataStringStyle.setBorderLeft(BorderStyle.THIN);
		dataStringStyle.setBorderTop(BorderStyle.THIN);
		dataStringStyle.setBorderBottom(BorderStyle.THIN);
		 
		
		CellStyle dataNumberStyle = wb.createCellStyle();		
		dataNumberStyle.setAlignment(HorizontalAlignment.RIGHT);
		dataNumberStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		dataNumberStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));
		
		dataNumberStyle.setBorderRight(BorderStyle.THIN);
		dataNumberStyle.setBorderLeft(BorderStyle.THIN);
		dataNumberStyle.setBorderTop(BorderStyle.THIN);
		dataNumberStyle.setBorderBottom(BorderStyle.THIN);
		 
		
		CellStyle dataNumberFloatStyle = wb.createCellStyle();		
		dataNumberFloatStyle.setAlignment(HorizontalAlignment.RIGHT);
		dataNumberFloatStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		dataNumberFloatStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0.00"));
		
		dataNumberFloatStyle.setBorderRight(BorderStyle.THIN);
		dataNumberFloatStyle.setBorderLeft(BorderStyle.THIN);
		dataNumberFloatStyle.setBorderTop(BorderStyle.THIN);
		dataNumberFloatStyle.setBorderBottom(BorderStyle.THIN);
		 
		
		cellStyleMap.put("titleStringStyle", titleStyle);
		cellStyleMap.put("titleNumberFloatStyle", titleStyle);
		cellStyleMap.put("titleNumberStyle", titleStyle);
		
		cellStyleMap.put("headerStringStyle", headerStyle);
		cellStyleMap.put("headerNumberFloatStyle", headerStyle);
		cellStyleMap.put("headerNumberStyle", headerStyle);
		
		cellStyleMap.put("dataNumberFloatStyle", dataNumberFloatStyle);
		cellStyleMap.put("dataNumberStyle", dataNumberStyle);
		cellStyleMap.put("dataStringStyle", dataStringStyle);
				
		List<ExcelSheetDef> excelSheetList = excelDef.getExcelSheetList();
		for(ExcelSheetDef sheetDef : excelSheetList) {
			int rowMax = 0;
			int colMax = 0;
			
			Sheet sheet=wb.createSheet(sheetDef.getSheetName());
			
			
			List<ExcelCellDef> cellList = sheetDef.getCellList();
			
			ArrayList<Integer> cellListRowNumArr = new ArrayList<>();
			
			for(ExcelCellDef cellDef : cellList) {
				int row = cellDef.getRow();
				int col = cellDef.getColumn();
				
				if (colMax < col) {
					colMax = col;
				}
				
				if (rowMax < row) {
					rowMax = row;
					cellListRowNumArr.add(row);
				}
			}
			
			ArrayList<Integer>  excludeCellListRowNumArr = new ArrayList<>();
			
			for(int i=1; i<rowMax; i++) {
				boolean val = cellListRowNumArr.contains(i);
				
				if(!val) {
					excludeCellListRowNumArr.add(i);
				}
			}
 				
			for(int rowN = 0; rowN <= rowMax; rowN++) {
				Row row = sheet.createRow(rowN);
				int excludeRow = 0;
				boolean isExcludeRow = false;
				
				for(int i=0; i<excludeCellListRowNumArr.size(); i++) {
					excludeRow = excludeCellListRowNumArr.get(i);
				
					if(rowN == excludeRow) {
						isExcludeRow = true;
						break;
					} else {
						isExcludeRow = false;
					}
				}
				
				if(!isExcludeRow) {
					for(int colN = 0; colN <= colMax; colN++) {
						Cell cell = row.createCell(colN);
						cell.setCellType(CellType.STRING);
						cell.setCellValue("");
						row.getCell(colN).setCellStyle(cellStyleMap.get("headerNumberStyle"));
					}
				}
			}
			
			
			List<ExcelMergeCellDef> cellMergeList = sheetDef.getCellMergeList();
			for(ExcelMergeCellDef cellMergeDef : cellMergeList) {
				//sheet.addMergedRegion(cellMergeDef.getCellRangeAddress());
				
				// 2022.06.29 신규 추가
				sheet.addMergedRegion(new CellRangeAddress(cellMergeDef.getStartRow(), cellMergeDef.getFinishRow(), cellMergeDef.getStartColumn(), cellMergeDef.getFinishColumn()));
			}

			
			for(ExcelCellDef cellDef : cellList) {
				Row row=sheet.getRow(cellDef.getRow());
				Cell cell = row.getCell(cellDef.getColumn());
				
				Object value = cellDef.getValue();
				String type = cellDef.getType();
				
				if (type.equals("title")) {
					row.setHeight((short) 700);
				}
				
				if (type.equals("header")) {
					row.setHeight((short) 550);
				}
				
				if (type.equals("data")) {
					row.setHeight((short) 550);
				}
				
				if (value == null) {
					value = "";
				}
				
				if (value instanceof Integer) {
					cell.setCellStyle(cellStyleMap.get(type + "NumberStyle"));
					cell.setCellValue((Integer)value);	
					cell.setCellType(CellType.NUMERIC);
				} else if (value instanceof Double) {
					cell.setCellStyle(cellStyleMap.get(type + "NumberFloatStyle"));
					cell.setCellValue((Double)value);	
					cell.setCellType(CellType.NUMERIC);
				} else if (value instanceof Short) {
					cell.setCellStyle(cellStyleMap.get(type + "NumberStyle"));
					cell.setCellValue((Short)value);	
					cell.setCellType(CellType.NUMERIC);
				} else if (value instanceof Float) {
					cell.setCellStyle(cellStyleMap.get(type + "NumberFloatStyle"));
					cell.setCellValue((Float)value);	
					cell.setCellType(CellType.NUMERIC);
				} else if (value instanceof Long) {
					cell.setCellStyle(cellStyleMap.get(type + "NumberStyle"));
					cell.setCellValue((Long)value);	
					cell.setCellType(CellType.NUMERIC);
				} else {
					cell.setCellStyle(cellStyleMap.get(type + "StringStyle"));
					cell.setCellValue(value.toString());
					cell.setCellType(CellType.STRING);
				}
			}
			
			if (sheetDef.isAutoResize()) {
				for(int colNo = 0; colNo<=colMax; colNo++) {
					sheet.autoSizeColumn(colNo);
					
					// 2022.06.29 컬럼 넓이 조정 추가
					sheet.setColumnWidth(colNo, (sheet.getColumnWidth(colNo))+ 2560);
				}
			}
		}
		
		ServletOutputStream sos=response.getOutputStream();
		
		wb.write(sos);
		wb.close();
		sos.close();
		
	}
	
	public static void exportExcel(HttpServletRequest request, HttpServletResponse response
			, String fileName, String sheetName
			, String[] headerString, String[] dataString, List<Map<Object, Object>> data) throws Exception {
		
		response.setHeader("Content-Type", "application/msexcel; charset=UTF-8");
		response.setHeader("Content-Disposition", "attachment; filename=" + getDisposition(fileName, getBrowser(request)));
		
		HSSFWorkbook wb=new HSSFWorkbook();
		HSSFSheet st=wb.createSheet(sheetName);		
		
		HSSFRow row=st.createRow(0);
		int colIdx=0;
		HSSFCell cel;

		HSSFFont font = wb.createFont();
		font.setBold(true);
		font.setFontHeightInPoints((short)10);
		
		HSSFCellStyle headerStyle = wb.createCellStyle();
		headerStyle.setFont(font);
		headerStyle.setBorderBottom(BorderStyle.THIN);
		
		headerStyle.setAlignment(HorizontalAlignment.CENTER);
		headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		
		
		HSSFCellStyle dataStringStyle = wb.createCellStyle();		
		dataStringStyle.setAlignment(HorizontalAlignment.CENTER);
		dataStringStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		
		HSSFCellStyle dataNumberStyle = wb.createCellStyle();		
		dataNumberStyle.setAlignment(HorizontalAlignment.RIGHT);
		dataNumberStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		dataNumberStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));
		
		HSSFCellStyle dataNumberFloatStyle = wb.createCellStyle();		
		dataNumberFloatStyle.setAlignment(HorizontalAlignment.RIGHT);
		dataNumberFloatStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		dataNumberFloatStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0.00"));
		
		st.setColumnWidth(0, 2000);
		for(int colNo = 1, colMax = headerString.length +1; colNo<colMax; colNo++) {
			st.setColumnWidth(colNo, 6000);
			st.autoSizeColumn(colNo);
		}
		
		cel=row.createCell(colIdx++);
		row=st.createRow(1);
		colIdx = 0;		
		
		cel=row.createCell(colIdx++);
		for(String headerItem : headerString) {
			cel=row.createCell(colIdx++);
			cel.setCellStyle(headerStyle);
			cel.setCellType(CellType.STRING);
			cel.setCellValue(headerItem);
		}
		
		for(int r=0,l=data.size(); r<l; r++){
			row=st.createRow(r+2);
			colIdx=0;
			cel=row.createCell(colIdx++);
			for(String dataItem : dataString) {
				cel=row.createCell(colIdx++);
				Object value = data.get(r).get(dataItem);
				if (value == null) {
					value = "";
				}
				
				if (value instanceof Integer) {
					cel.setCellStyle(dataNumberStyle);
					cel.setCellType(CellType.NUMERIC);
					cel.setCellValue((Integer)value);	
				} else if (value instanceof Double) {
					cel.setCellStyle(dataNumberFloatStyle);
					cel.setCellType(CellType.NUMERIC);
					cel.setCellValue((Double)value);	
				} else if (value instanceof Short) {
					cel.setCellStyle(dataNumberStyle);
					cel.setCellType(CellType.NUMERIC);
					cel.setCellValue((Short)value);	
				} else if (value instanceof Float) {
					cel.setCellStyle(dataNumberFloatStyle);
					cel.setCellType(CellType.NUMERIC);
					cel.setCellValue((Float)value);	
				} else if (value instanceof Long) {
					cel.setCellStyle(dataNumberStyle);
					cel.setCellType(CellType.NUMERIC);
					cel.setCellValue((Long)value);	
				} else {
					cel.setCellStyle(dataStringStyle);
					cel.setCellType(CellType.STRING);
					cel.setCellValue(value.toString());
				}
			}					
		}
		
		for(int colNo = 0, colMax = headerString.length +1; colNo<colMax; colNo++) {
			st.autoSizeColumn(colNo);
		}

		ServletOutputStream sos=response.getOutputStream();

		wb.write(sos);
		wb.close();
		sos.close();
	}
}
