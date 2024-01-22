package com.ibk.msg.files;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.multipart.MultipartFile;

@Slf4j
public abstract class UploadedFile {

	public abstract Map<String, Object> verifyFile(MultipartFile uploadFile);

	public String save(MultipartFile uploadFile, String uploadedDir) {
		String fullPath = uploadedDir+"/" + uploadFile.getOriginalFilename();
		//    try {
		//      byte[] bytes = uploadFile.getBytes();
		//      Path path = Paths.get(fullPath);
		//      Files.write(path, bytes);
		//      return fullPath;
		//    } catch (IOException e) {
		//      log.error("target file exception", e);
		//      return null;
		//    }


		return fullPath;
	}

}
