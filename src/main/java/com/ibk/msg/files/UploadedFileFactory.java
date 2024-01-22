package com.ibk.msg.files;

import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

@Slf4j
public class UploadedFileFactory {

	public static UploadedFile getInstance(MultipartFile uploadedFile) {
		if (uploadedFile == null) {
			return null;
		}
		String uploadedFileName = uploadedFile.getOriginalFilename();
		if (StringUtils.isEmpty(uploadedFileName)) {
			return null;
		}
		int lastPos = uploadedFileName.lastIndexOf(".");
		String fileEx = uploadedFileName.substring(lastPos +1);
		if (StringUtils.equals(fileEx, "xls")) {
			return new ExcelFileUtil();
		}else if(StringUtils.equals(fileEx, "xlsx")){
			return new ExcelFileUtil();
		}else if(StringUtils.equals(fileEx, "csv")){
			return new CsvFileUtil();
		}else if(StringUtils.equals(fileEx, "txt")){
			return new TxtFileUtil();
		}else if(StringUtils.contains("jpg|gif|png", fileEx)){
			return new ImageFileUtil();
		}else{
			return new CommonFileUtil();
		}
	}

}
