package com.ibk.msg.web.template;

import com.ibk.msg.utils.ImageTemplate;
import net.minidev.json.JSONArray;
import net.minidev.json.JSONObject;
import net.minidev.json.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

@Controller
@PropertySources({
	@PropertySource("classpath:local.properties")
	, @PropertySource(value="classpath:${spring.profiles.active}.properties", ignoreResourceNotFound=true)
})

public class TemplateController {

	private static final Logger logger = LoggerFactory.getLogger(TemplateController.class);

	@Autowired
	private TemplateService templateService;

	@Value("${upload.path.images}")
	private String IMAGES_UPLOADED_DIR;
	
	@Value("${upload.path.images.rcs}")
	private String IMAGES_RCS_UPLOADED_DIR;

	@GetMapping("/template-view.ibk")
	public String viewListJsp() {
		return "template/template_view";
	}

	@GetMapping("/template-list.ibk")
	public String statisticsChannel() {
		return "template/template_list";
	}

	private static AtomicInteger ai = new AtomicInteger();

	@RequestMapping(value="/template-list", produces = {"application/json"})
	@ResponseBody
	public Object tmplList(TemplateSearchCondition searchCondition) {
		logger.info("searchCondition {}" + searchCondition);
		Object tc = templateService.SelectAll(searchCondition);
		logger.info("tc {}" + tc);
		return tc;
	}

	@RequestMapping(value="/template-categoryList", produces = {"application/json"})
	@ResponseBody
	public Object tmplCategoryList(TemplateSearchCondition searchCondition) {
		logger.info("searchCondition {}" + searchCondition);
		Object tc = templateService.SelectCategory(searchCondition);
		logger.info("tc {}" + tc);
		return tc;
	}

	@RequestMapping("/template-regist-image")
	@ResponseBody
	public Object addImageFiles(MultipartHttpServletRequest request) {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat sdf2 = new SimpleDateFormat("HHmmssSSS");

		Map<String, Object> res = new HashMap<String, Object>();

		MultipartFile mpf = request.getFile("fileName");

		String originalFileName =  mpf.getOriginalFilename();
		int lastPos = originalFileName.lastIndexOf(".");
		String fileEx = originalFileName.substring(lastPos +1);

		if ( !(fileEx.equalsIgnoreCase("jpg") || fileEx.equalsIgnoreCase("jpeg")) ) {
			//TODO 실패처리
			res.put("result", false);
			res.put("error", "jpg나 jpeg 파일만 등록이 가능합니다.");
			return res;
		}

		String dirName = sdf.format(new Date());
		int seq = ai.incrementAndGet();
		if (seq == 999) {
			ai.set( 0);
		}
		String fileName = sdf2.format(new Date()) +"_"+ String.format("%03d", seq);

		String responsePath = "/" +  dirName  + "/" + fileName;
		String uploadPath = IMAGES_UPLOADED_DIR + "/" +  dirName ;
		String uploadFilePath = IMAGES_UPLOADED_DIR + "/" +  dirName + "/" + fileName;

		if (!new File(uploadPath).exists()) {
			new File(uploadPath).mkdirs();
		}

		try {
			mpf.transferTo(new File(uploadFilePath));
			res.put("result", true);
			res.put("filename", responsePath);
		} catch (Exception e) {
			res.put("result", false);
			res.put("error", e.toString());
			e.printStackTrace();
		}
		return res;
	}

	/**
	 * 업로드된 이미지 미리보기
	 * 22.06.16 RCS 구분값 추가
	 * @param filename
	 * @param isRcsFile
	 * @param response
	 * @param session
	 * @throws IOException
	 */
	@RequestMapping(value="/template-uploaded-img.ibk")
	@ResponseBody
	public void getTmplUploadedImage(@RequestParam(name="filename", required=true) String filename, @RequestParam(name="isRcsFile", required=false) String isRcsFile, HttpServletResponse response
			, HttpSession session) throws IOException {

		ByteArrayOutputStream baos = null;
		FileInputStream fis = null;
		
		// 2022.06.16 RCSMMS 이미지 업로드 경로 추가
		String filePath = IMAGES_UPLOADED_DIR + filename ;
		if("Y".equals(isRcsFile)) {
			filePath = IMAGES_RCS_UPLOADED_DIR + filename ;
		}
		
		filePath = filePath.replaceAll("\\.\\.", "");
		int lastPos = filePath.lastIndexOf(".");
		String fileEx = filePath.substring(lastPos +1);

		if ( !(fileEx.equalsIgnoreCase("jpg") || fileEx.equalsIgnoreCase("jpeg")) ) {
			//TODO 실패처리
			
			if("Y".equals(isRcsFile)) {
				if(!(fileEx.equalsIgnoreCase("png"))) {
					response.setContentType("image/jpeg");
					response.getOutputStream().write(1);
					return;
				}
			} else {
				response.setContentType("image/jpeg");
				response.getOutputStream().write(1);
				return;
			}
		}

		try {
			baos = new ByteArrayOutputStream();
			fis = new FileInputStream(filePath);

			byte[] buf = new byte[1024];
			int read = 0;

			while ((read=fis.read(buf, 0, buf.length)) != -1 ) {
				baos.write(buf, 0, read);
			}
			
			// 2022.06.16 RCSMMS PNG 확장자 추가
			response.setContentType("image/jpeg");
			if("png".equals(fileEx)) {
				response.setContentType("image/png");
			}
			
			response.getOutputStream().write(baos.toByteArray());
		} catch (IOException e) {
			logger.error("", e);
		} finally {
			if(fis != null) {
				fis.close();
			}
			if(baos != null) {
				baos.close();
			}
		}

	}

	@RequestMapping(value="/template-regist", produces = {"application/json"})
	@ResponseBody
	public Object tmplRegist(TemplateSearchCondition searchCondition) throws IOException {

		ByteArrayOutputStream baos = null;
		FileInputStream fis = null;

		String filePath = IMAGES_UPLOADED_DIR + searchCondition.getIMAGE_PATH();
		try {
			baos = new ByteArrayOutputStream();
			fis = new FileInputStream(filePath);

			byte[] buf = new byte[1024];
			int read = 0;

			while ((read=fis.read(buf, 0, buf.length)) != -1 ) {
				baos.write(buf, 0, read);
			}
		} catch (IOException e) {
			logger.error("", e);
		} finally {
			if(fis != null) {
				fis.close();
			}
			if(baos != null) {
				baos.close();
			}
		}

		searchCondition.setIMG_CON(baos.toByteArray());

		Object tc = templateService.TmplRegist(searchCondition);
		return tc;
	}

	@RequestMapping(value="/template-img.ibk")
	@ResponseBody
	public void getTmplImage(@RequestParam(name="seq", required=true) int seq, HttpServletResponse response
			, HttpSession session) {
		try {
			TemplateDTO template = templateService.selectTemplateBySeq(seq);
			byte[] imageData = template.getIMGCON();
			String renderInfo = template.getMMSUSERDFNTCON();
			if (renderInfo == null || renderInfo.trim().equals("")) {
				response.setContentType("image/jpeg");
				response.getOutputStream().write(imageData);
			} else {
				ImageTemplate imgs = ImageTemplate.createInstanceFromImage(imageData);
				JSONParser parser = new JSONParser();
				JSONArray renderJsonArr = parser.parse(renderInfo, JSONArray.class);

				for(Object renderJson : renderJsonArr) {
					if (renderJson instanceof JSONObject) {
						JSONObject renderItem = (JSONObject) renderJson;

						if (renderItem.containsKey("fontFace")) {

							imgs.setFont(renderItem.get("fontFace").toString()
									,0
									,Integer.parseInt(renderItem.get("fontSize").toString())
									,renderItem.get("textColor1").toString());
							imgs.drawText(renderItem.get("varDisplayName").toString()
									,Integer.parseInt(renderItem.get("xPosition").toString())
									,Integer.parseInt(renderItem.get("yPosition").toString())+Integer.parseInt(renderItem.get("fontSize").toString()));
						} else {
							imgs.setFont(""
									,0
									,Integer.parseInt(renderItem.get("fontSize").toString())
									,renderItem.get("textColor1").toString());
							imgs.drawText(renderItem.get("varDisplayName").toString()
									,Integer.parseInt(renderItem.get("xPosition").toString())
									,Integer.parseInt(renderItem.get("yPosition").toString())+Integer.parseInt(renderItem.get("fontSize").toString()));
						}
					}
				}
				response.setContentType("image/jpeg");
				response.getOutputStream().write(imgs.getImage());	
			}

		} catch (Exception e) {
			logger.error("", e);
		}

	}

	@RequestMapping(value="/download-template-img.ibk")
	@ResponseBody
	public void getDownloadTmplImage(@RequestParam(name="seq", required=true) int seq
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session) {
		try {
			TemplateDTO template = templateService.selectTemplateBySeq(seq);
			byte[] imageData = template.getIMGCON();
			String filename = template.getIMGCTGYNM() + "_" + template.getIMGNM() + "_"  + template.getMMSIMGID() + "_" + template.getUSEYN() + ".jpg";
			String renderInfo = template.getMMSUSERDFNTCON();
			if (renderInfo == null || renderInfo.trim().equals("")) {
				response.setHeader("Content-Type", "application/binary");
				response.setHeader("Content-Disposition", "attachment; filename=" + getDisposition(filename, getBrowser(request)));
				ServletOutputStream sos=response.getOutputStream();
				sos.write(imageData);
				sos.close();
			} else {
				ImageTemplate imgs = ImageTemplate.createInstanceFromImage(imageData);
				JSONParser parser = new JSONParser();
				JSONArray renderJsonArr = parser.parse(renderInfo, JSONArray.class);

				for(Object renderJson : renderJsonArr) {
					if (renderJson instanceof JSONObject) {
						JSONObject renderItem = (JSONObject) renderJson;

						if (renderItem.containsKey("fontFace")) {

							imgs.setFont(renderItem.get("fontFace").toString()
									,0
									,Integer.parseInt(renderItem.get("fontSize").toString())
									,renderItem.get("textColor1").toString());
							imgs.drawText(renderItem.get("varDisplayName").toString()
									,Integer.parseInt(renderItem.get("xPosition").toString())
									,Integer.parseInt(renderItem.get("yPosition").toString())+Integer.parseInt(renderItem.get("fontSize").toString()));
						} else {
							imgs.setFont(""
									,0
									,Integer.parseInt(renderItem.get("fontSize").toString())
									,renderItem.get("textColor1").toString());
							imgs.drawText(renderItem.get("varDisplayName").toString()
									,Integer.parseInt(renderItem.get("xPosition").toString())
									,Integer.parseInt(renderItem.get("yPosition").toString())+Integer.parseInt(renderItem.get("fontSize").toString()));
						}
					}
				}
				response.setHeader("Content-Type", "application/binary");
				response.setHeader("Content-Disposition", "attachment; filename=" + getDisposition(filename, getBrowser(request)));
				ServletOutputStream sos=response.getOutputStream();
				sos.write(imgs.getImage());
				sos.close();
			}

		} catch (Exception e) {
			logger.error("", e);
		}

	}

	@RequestMapping(value="/download-all-template-img.ibk")
	@ResponseBody
	public void getDownloadAllTmplImage(HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session) {
		try {
			List<TemplateDTO> templateList = templateService.downloadSelectAll();

			// REMOVE ALL Image
			String basePath = IMAGES_UPLOADED_DIR + "/downloadAll/";
			File basePathFile = new File(basePath);
			if (basePathFile.exists()) {
				File[] images = basePathFile.listFiles();
				for(File image : images) {
					image.delete();
				}
			} else {
				basePathFile.mkdirs();
			}
			
			// Zip File
			ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(basePath + "allimages.zip"));
						
			for(TemplateDTO template : templateList) {
				String filename =  template.getIMGCTGYNM() + "_" + template.getIMGNM() + "_"  + template.getMMSIMGID() + "_" + template.getUSEYN() + ".jpg";
				//
				byte[] imageData = template.getIMGCON();
				String renderInfo = template.getMMSUSERDFNTCON();
				if (imageData == null) {
					continue;
				}
				if (renderInfo == null || renderInfo.trim().equals("")) {
					ZipEntry entry = new ZipEntry(filename);
					zos.putNextEntry(entry);
					zos.write(imageData);
					zos.flush();
				} else {
					ImageTemplate imgs = ImageTemplate.createInstanceFromImage(imageData);
					JSONParser parser = new JSONParser();
					JSONArray renderJsonArr = parser.parse(renderInfo, JSONArray.class);

					for(Object renderJson : renderJsonArr) {
						if (renderJson instanceof JSONObject) {
							JSONObject renderItem = (JSONObject) renderJson;

							if (renderItem.containsKey("fontFace")) {

								imgs.setFont(renderItem.get("fontFace").toString()
										,0
										,Integer.parseInt(renderItem.get("fontSize").toString())
										,renderItem.get("textColor1").toString());
								imgs.drawText(renderItem.get("varDisplayName").toString()
										,Integer.parseInt(renderItem.get("xPosition").toString())
										,Integer.parseInt(renderItem.get("yPosition").toString())+Integer.parseInt(renderItem.get("fontSize").toString()));
							} else {
								imgs.setFont(""
										,0
										,Integer.parseInt(renderItem.get("fontSize").toString())
										,renderItem.get("textColor1").toString());
								imgs.drawText(renderItem.get("varDisplayName").toString()
										,Integer.parseInt(renderItem.get("xPosition").toString())
										,Integer.parseInt(renderItem.get("yPosition").toString())+Integer.parseInt(renderItem.get("fontSize").toString()));
							}
						}
					}
					
					ZipEntry entry = new ZipEntry(filename);
					zos.putNextEntry(entry);
					zos.write(imgs.getImage());
					zos.flush();
				}
			}
			zos.closeEntry();
			zos.close();
			// Zip File Download
			response.setHeader("Content-Type", "application/binary");
			response.setHeader("Content-Disposition", "attachment; filename=" + getDisposition("allimages.zip", getBrowser(request)));
			
			ServletOutputStream sos=response.getOutputStream();
			FileInputStream fis = new FileInputStream(basePath + "allimages.zip");
			byte[] buf = new byte[1024 * 10];
			int len = 0;
			
			while((len = fis.read(buf))!=-1) {
				sos.write(buf, 0, len);
				sos.flush();
			}			
			fis.close();
			sos.close();

		} catch (Exception e) {
			logger.error("", e);
		}

	}

	@RequestMapping(value="/template-modify", produces = {"application/json"})
	@ResponseBody
	public Object tmplModify(TemplateSearchCondition searchCondition) {		
		Object tc = templateService.TmplModify(searchCondition);
		return tc;
	}

	@RequestMapping(value="/template-modifyInfo", produces = {"application/json"})
	@ResponseBody
	public Object tmplModifyInfo(TemplateSearchCondition searchCondition) {		
		Object tc = templateService.ModifyInfo(searchCondition);
		return tc;
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

}
