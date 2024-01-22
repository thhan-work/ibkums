package com.ibk.msg.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ExcelSheetDef {

	private String sheetName;

	private int leftMargin = 1;
	private int topMargin = 1;

	private List<ExcelCellDef> cellList = new ArrayList<ExcelCellDef>();
	private List<ExcelMergeCellDef> cellMergeList = new ArrayList<ExcelMergeCellDef>();

	private boolean autoResize = true;

	public void addCell(ExcelCellDef cellDef) {
		cellList.add(cellDef);
	}

	public void addCellMerge(ExcelMergeCellDef mergeCellDef) {
		cellMergeList.add(mergeCellDef);
	}

	public void convertMapDataToCellListAndAdd(String sheetName, String title, 
			String[] headerString, String[] dataString, List<Map<Object, Object>> data) {

		this.sheetName = sheetName;

		int rowPadding = topMargin;

		cellList.clear();
		cellMergeList.clear();

		// title
		if (title != null){
			ExcelMergeCellDef mergeCellDef = new ExcelMergeCellDef(rowPadding, rowPadding, leftMargin, leftMargin + headerString.length-1);
			cellMergeList.add(mergeCellDef);
			ExcelCellDef cellDef = new ExcelCellDef("title", rowPadding++, leftMargin, title);
			cellList.add(cellDef);
			rowPadding++;
		}

		// header
		if (headerString != null) {
			for(int col=0,colMax=headerString.length;col<colMax;col++) {
				Object value = headerString[col];
				ExcelCellDef cellDef = new ExcelCellDef("header", rowPadding, col+leftMargin, value);
				cellList.add(cellDef);
			}
			rowPadding++;
		}

		// data
		for(int row=0,rowMax=data.size();row<rowMax;row++) {
			Map<Object, Object> rowMap = data.get(row);
			for(int col=0,colMax=dataString.length;col<colMax;col++) {
				Object value = rowMap.get(dataString[col]);
				ExcelCellDef cellDef = new ExcelCellDef("data", row+rowPadding, col+leftMargin, value);
				cellList.add(cellDef);
			}
		}

	}
}
