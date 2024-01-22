package com.ibk.msg.utils;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ExcelCellDef {

	private String type;
	
	private int row;
	private int column;
	
	private Object value;
	
}
