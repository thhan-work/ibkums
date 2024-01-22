package com.ibk.msg.utils;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class ExcelDef {

	private String fileName;
	
	private List<ExcelSheetDef> excelSheetList = new ArrayList<ExcelSheetDef>();
	
	public void addSheet(ExcelSheetDef sheetDef) {
		excelSheetList.add(sheetDef);
	}
}
