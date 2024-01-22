package com.ibk.msg.utils;

import org.apache.poi.ss.util.CellRangeAddress;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ExcelMergeCellDef {
	
	private int startRow;
	private int finishRow;
	
	private int startColumn;
	private int finishColumn;
	
	public CellRangeAddress getCellRangeAddress() {
		return new CellRangeAddress(startRow, finishRow, startColumn, finishColumn);
	}
}
