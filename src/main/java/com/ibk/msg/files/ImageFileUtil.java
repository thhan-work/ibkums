package com.ibk.msg.files;

import java.util.Map;
import org.springframework.web.multipart.MultipartFile;

public class ImageFileUtil extends UploadedFile {

	@Override
	public Map<String, Object> verifyFile(MultipartFile uploadFile) {
		return null;
	}
}
