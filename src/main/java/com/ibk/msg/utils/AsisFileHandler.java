package com.ibk.msg.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.reflect.InvocationTargetException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.POIXMLException;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.web.multipart.MultipartFile;

import com.google.common.base.Preconditions;
import com.ibk.msg.common.dto.AsisFileDataForm;
import com.opencsv.CSVReader;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AsisFileHandler {
	static boolean checkFileSize(String fileExt, long fileSize) {
		if ("xls".equalsIgnoreCase(fileExt) || "xlsx".equalsIgnoreCase(fileExt)) {
			if (fileSize > 6500000) {
				throw new IllegalArgumentException("파일 크기 제한 초과하였습니다. [크기=" + fileSize + "]");
			}
		} else if ("csv".equalsIgnoreCase(fileExt)) {
			if (fileSize > 8000000) {
				throw new IllegalArgumentException("파일 크기 제한 초과하였습니다. [크기=" + fileSize + "]");
			}
		} else {
			throw new IllegalArgumentException("지원하지 않은 포맷입니다. [포맷="+fileExt+"]");
		}

		return true;
	}

	static String extractFileExtension(MultipartFile uploadFile) {
		String fileExt = uploadFile.getOriginalFilename()
				.substring(uploadFile.getOriginalFilename().lastIndexOf(".") + 1);
		return fileExt;
	}

	static String generateUniqueFileName(MultipartFile uploadFile, HttpSession httpSession) {
		String emplid = (String) httpSession.getAttribute("EMPL_ID");
		Preconditions.checkArgument(StringUtils.isNoneBlank(emplid), "세션 오류입니다.\n재 접속 바랍니다.");
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyMMddHHmmss");
		String fileTime = dateFormat.format(calendar.getTime());
		String fileExt = extractFileExtension(uploadFile);
		String uploadFileName = uploadFile.getOriginalFilename();
		if (uploadFileName.indexOf("/") > 0 || uploadFileName.indexOf("\\") > 0) {
			if (uploadFileName.indexOf("/") > 0) {
				uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("/")+1);
			} else {
				uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			}
		}

		String uFileName = uploadFileName.substring(0, uploadFileName.lastIndexOf(".")) + "." + emplid + fileTime + "."
				+ fileExt;
		return uFileName;
	}

	static boolean DecodingFile(String encodedFilePath, String saveFilePath) {
		return true;
	}

	static public String saveFile(MultipartFile uploadFile, String uploadedDir) {
		String fullPath = uploadedDir + "/" + uploadFile.getOriginalFilename();
		try {
			byte[] bytes = uploadFile.getBytes();
			Path path = Paths.get(fullPath);
			Files.write(path, bytes);
			return fullPath;
		} catch (IOException e) {
			log.error("target file exception", e);
			return null;
		}
	}

	static public List<AsisFileDataForm> hadleFile(MultipartFile uploadFile, HttpSession httpSession, String fileType) {

		String fileExt = extractFileExtension(uploadFile);
		checkFileSize(fileExt, uploadFile.getSize());
		String uqiuName = generateUniqueFileName(uploadFile, httpSession);
		if (uqiuName == null) {
			throw new IllegalArgumentException("파일명을 확인해 주세요.");
		}
			
		File tmpFile = new File(System.getProperty("java.io.tmpdir") + System.getProperty("file.separator") + uqiuName);
		try {
			uploadFile.transferTo(tmpFile);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		String uniqueKey = String.valueOf(System.currentTimeMillis());
		List<AsisFileDataForm> list = new ArrayList<AsisFileDataForm>();
		if (fileExt.equalsIgnoreCase("xls") || fileExt.equalsIgnoreCase("xlsx")) {
			try {
				Workbook wb = WorkbookFactory.create(tmpFile);
				Sheet sheet = wb.getSheetAt(0);
				Cell cell = null;
				Row row = null;
				int rows = sheet.getPhysicalNumberOfRows();
				if (rows < 1) { // 내용이 없는 빈 파일
					log.error("target file exception", "내용이 없는 빈 파일");
					throw new IllegalArgumentException("내용이 없는 파일입니다.");
				} else if (rows > 1000) {
					log.error("target file exception", "1000건 초과");
					throw new IllegalArgumentException("제한 건수(1000건) 초과 된 파일입니다..");
				}
				int cellCount = 0;
				if (fileType.equalsIgnoreCase("message")) {// 일반 SMS 보내기 양식
					cellCount = 2;
				} else if (fileType.equalsIgnoreCase("bulk") || fileType.equalsIgnoreCase("empnotice")) {// 파일 대량보내기 양식
					cellCount = 4;
				} else if (fileType.equalsIgnoreCase("addr")) {// 주소록 파일 업로드 양식
					cellCount = 5;
				} else {
					throw new IllegalArgumentException("지원하지 않는 파일 양식입니다.");
				}
				AsisFileDataForm fileDataForm = null;
				for (int r = 0; r < rows; r++) {
					row = sheet.getRow(r);
					if (row == null) {
						rows += 1;
						continue;
					}
					fileDataForm = new AsisFileDataForm();
					for (int c = 0; c < cellCount; c++) {// 셀 루프문 시작
						String value = "";
						if (row.getCell(c) != null) {
							cell = row.getCell(c);
							if (cell.getCellTypeEnum() == CellType.STRING) {
								value = cell.getStringCellValue().trim();
							} else if (cell.getCellTypeEnum() == CellType.NUMERIC) {
								if (!DateUtil.isCellDateFormatted(cell)) {
									long data = (long) cell.getNumericCellValue();
									value = String.valueOf(data).trim();
								}
							}
						}
						
						/*
						 * if(value.equals("")) { return null; }
						 */
						if (fileType.equalsIgnoreCase("message")) {// 일반 SMS 보내기 양식
							if (c == 0)
								fileDataForm.setName(value);
							if (c == 1) {
								value = value.replaceAll("-", "");
								if (!isMobile(value)) {
									throw new IllegalArgumentException((r+1)+"라인, 휴대전화번호를 확인 바랍니다.");
								}
								fileDataForm.setMobile(value);
							}
						} else if (fileType.equalsIgnoreCase("bulk") || fileType.equalsIgnoreCase("empnotice")) {// 파일대량보내기, 직원보내기
							if (c == 0) {
								value = value.replaceAll("-", "");
								if (!isMobile(value)) {
									throw new IllegalArgumentException((r+1)+"라인, 휴대전화번호를 확인 바랍니다.");
								}
								fileDataForm.setMobile(value);
							}
							if (c == 1) {
								if (value.trim().equals("")) {
									throw new IllegalArgumentException((r+1)+"라인, 메시지 내용이 없습니다.");
								}
								fileDataForm.setMsg1(value);
							}									
							if (c == 2) {
								fileDataForm.setMsg1(fileDataForm.getMsg1() + "" + value);
								int msgSize = fileDataForm.getMsg1().getBytes("euc-kr").length;
								if (msgSize > 2000)
									throw new IllegalArgumentException((r+1)+"라인, 메시지 길이 제한 초과하였습니다.");
								if (msgSize > 90) {
									fileDataForm.setMsg2("MMS");
								} else {
									fileDataForm.setMsg2("SMS");
								}
							}
							if (c == 3) {									
								if(fileDataForm.getMsg2().equals("SMS")) {
									fileDataForm.setMsg3("");
								}else {
									int titleSize = value.getBytes("euc-kr").length;
									if( titleSize>64)
										throw new IllegalArgumentException((r+1)+"라인, 메시지제목 길이["+titleSize+"]제한(64byte) 초과하였습니다.");
									if(titleSize>0) {
										fileDataForm.setMsg3(value);
									}else {
										fileDataForm.setMsg3("제목없음");
									}		
								}									
							}
						} else if (fileType.equalsIgnoreCase("addr")) {// 주소록 파일 업로드 양식
							if (c == 0) {
								if (value == null || value.equals("")) {
									throw new IllegalArgumentException((r+1)+"라인, 이름 값 확인 바랍니다");
								}
								if(isSpecial(value)) {
									throw new IllegalArgumentException((r+1)+"라인, 이름 값 확인 바랍니다");
								}
								fileDataForm.setName(value);
							}
							if (c == 1) {
								value = value.replaceAll("-", "");
								if (!isMobile(value)) {
									throw new IllegalArgumentException((r+1)+"라인, 휴대전화번호를 확인 바랍니다.");
								}
								fileDataForm.setMobile(value);
							}
							if (c == 2) {
								if (!isEmail(value)) {
									throw new IllegalArgumentException((r+1)+"라인, 이메일 주소를 확인 바랍니다.");
								}
								fileDataForm.setEmail(value);
							}
							if (c == 3) {
								value = value.replaceAll("-", "");
								if (!isFax(value)) {
									throw new IllegalArgumentException((r+1)+"라인, 팩스 주소를 확인 바랍니다.");
								}
								fileDataForm.setFax(value);
							}
							if (c == 4)
								if(isSpecial(value)) {
									throw new IllegalArgumentException((r+1)+"라인, 소속 값 확인 바랍니다");
								}
								if(value != null && value.equals("")){value = null;};
								fileDataForm.setDepartment(value);
						}
					} // 셀 루프문 끝
					fileDataForm.setCno(r + 1);
					fileDataForm.setUniquekey(uniqueKey);
					list.add(fileDataForm);
				} // row 루푸문 끝
			} catch (EncryptedDocumentException e) {
				e.printStackTrace();
				throw new IllegalArgumentException("암호화된 파일입니다.");
			} catch (InvalidFormatException e) {
				e.printStackTrace();
				throw new IllegalArgumentException("잘못된 파일 입니다.");
			} catch (POIXMLException e) {
				e.printStackTrace();
				throw new IllegalArgumentException("잘못된 파일 입니다.");
			} catch (IOException e) {
				e.printStackTrace();
				throw new IllegalArgumentException("파일 처리 오류");
			}
		} else if (fileExt.equalsIgnoreCase("csv")) {
			try {
				CSVReader reader = new CSVReader(new InputStreamReader(new FileInputStream(tmpFile), "EUC-KR"));
				List<String[]> datas = reader.readAll();
				
				if (datas.size() < 1) {
					log.error("target file exception", "내용이 없는 빈 파일");
					throw new IllegalArgumentException("내용이 없는 빈 파일입니다.");
				} else if (datas.size() > 1000) {
					log.error("target file exception", "1000건 초과");
					throw new IllegalArgumentException("제한 건수 1000건 초과 파일입니다.");
				}
				int cellCount = 0;
				if (fileType.equalsIgnoreCase("message")) {// 일반 SMS 보내기 양식
					cellCount = 2;
				} else if (fileType.equalsIgnoreCase("bulk") || fileType.equalsIgnoreCase("empnotice")) {// 파일 대량보내기 양식
					cellCount = 4;
				} else if (fileType.equalsIgnoreCase("addr")) {// 주소록 파일 업로드 양식
					cellCount = 5;
				} else {
					throw new IllegalArgumentException("지원하지 않은 파일 양식 입니다.");
				}
				AsisFileDataForm fileDataForm = null;
				Iterator<String[]> ite = datas.iterator();
				int row=1;
				while (ite.hasNext()) {
					int c = 0;
					fileDataForm = new AsisFileDataForm();
					for (String value : ite.next()) {
						if(value==null)value="";
						if (fileType.equalsIgnoreCase("message")) {// 일반 SMS 보내기 양식
							if (c == 0)
								fileDataForm.setName(value);
							if (c == 1) {
								value = value.replaceAll("-", "");
								if (!isMobile(value)) {
									throw new IllegalArgumentException((row)+"라인, 휴대전화번호를 확인 바랍니다.");
								}
								fileDataForm.setMobile(value);
							}
						} else if (fileType.equalsIgnoreCase("bulk") || fileType.equalsIgnoreCase("empnotice")) {// 파일대량보내기, 직원보내기
							if (c == 0) {
								value = value.replaceAll("-", "");
								if (!isMobile(value)) {
									throw new IllegalArgumentException((row)+"라인, 휴대전화번호를 확인 바랍니다.");
								}
								fileDataForm.setMobile(value);
							}
							if (c == 1) {
								if (value==null||value.trim().equals("")) {
									throw new IllegalArgumentException((row)+"라인, 메시지 내용이 없습니다.");
								}
								fileDataForm.setMsg1(value);
							}		
							if (c == 2) {
								fileDataForm.setMsg1(fileDataForm.getMsg1() + "" + value);
								int msgSize = fileDataForm.getMsg1().getBytes("euc-kr").length;
								if (msgSize > 2000)
									throw new IllegalArgumentException((row)+"라인, 메시지 길이 제한 초과하였습니다.");
								if (msgSize > 90) {
									fileDataForm.setMsg2("MMS");
								} else {
									fileDataForm.setMsg2("SMS");
								}
							}
							if (c == 3) {
								if(fileDataForm.getMsg2().equals("SMS")) {
									fileDataForm.setMsg3("");
								}else {
									int titleSize = value.getBytes("euc-kr").length;
									if( titleSize>64)
										throw new IllegalArgumentException((row)+"라인, 메시지제목 길이["+titleSize+"]제한(64byte) 초과하였습니다.");
									if(titleSize>0) {
										fileDataForm.setMsg3(value);
									}else {
										fileDataForm.setMsg3("제목없음");
									}		
								}			
							}
						} else if (fileType.equalsIgnoreCase("addr")) {// 주소록 파일 업로드 양식
							if (c == 0) {
								if (value == null || value.equals("")) {
									throw new IllegalArgumentException((row)+"라인, 이름 값 확인 바랍니다");
								}
								if(isSpecial(value)) {
									throw new IllegalArgumentException((row)+"라인, 이름 값 확인 바랍니다");
								}
								fileDataForm.setName(value);
							}
							if (c == 1) {
								value = value.replaceAll("-", "");
								if (!isMobile(value)) {
									throw new IllegalArgumentException((row)+"라인, 휴대전화번호를 확인 바랍니다.");
								}
								fileDataForm.setMobile(value);
							}
							if (c == 2) {
								if (!isEmail(value)) {
									throw new IllegalArgumentException((row)+"라인, 이메일 주소를 확인 바랍니다.");
								}
								fileDataForm.setEmail(value);
							}
							if (c == 3) {
								value = value.replaceAll("-", "");
								if (!isFax(value)) {
									throw new IllegalArgumentException((row)+"라인, 팩스 주소를 확인 바랍니다.");
								}
								fileDataForm.setFax(value);
							}
							if (c == 4)
								if(isSpecial(value)) {
									throw new IllegalArgumentException((row)+"라인, 소속 값 확인 바랍니다");
								}
								if(value != null && value.equals("")){value = null;};
								fileDataForm.setDepartment(value);
						}
						c++;
						if (c == cellCount)
							break;
					} // 행 데이터 처리
					fileDataForm.setCno(row);
					fileDataForm.setUniquekey(uniqueKey);
					list.add(fileDataForm);
					row++;
				}
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}

	static boolean isEmail(String email) {

		// String regex = "([0-9a-zA-Z_-]+)@([0-9a-zA-Z_-]+)(\\.[0-9a-zA-Z_-]+){1,2}";
		// ID에 .을 허용하는 정규식, [0-9a-zA-Z_-\\.]+ => 문법이 오류가 나서 아래와 같이 처리
		// .으로 시작할 수 없음
		String regex = "[0-9a-zA-Z_-]+(?:\\.|[0-9a-zA-Z_-]+)*@([0-9a-zA-Z_-]+)(\\.[0-9a-zA-Z_-]+){1,2}";

		return Pattern.matches(regex, email);
	}

	static boolean isMobile(String mobile) {
		// String regex = "^01(?:0|1|[6-9]{3})(?:\\d{3}|\\d{4})\\d{4}$";
		// return Pattern.matches(regex, mobile);

		boolean check = true;
		if (mobile.length() > 0 && !mobile.startsWith("01"))
			check = false;
		if (mobile.length() < 9)
			check = false;
		if (mobile.length() > 11)
			check = false;
		for (int i = 0; i < mobile.length(); i++) {
			if (!Character.isDigit(mobile.charAt(i))) {
				check = false;
				break;
			}
		}
		return check;
	}

	static boolean isFax(String fax) {
		String regex = "0\\d{1,2}[1-9]\\d{2,3}\\d{4}";
		return Pattern.matches(regex, fax);
	}
	
	static boolean isSpecial(String special) {
		Pattern pattern = Pattern.compile("[~!@#$%^&*(),.?\":{}|<>]");
        return pattern.matcher(special).find();
	}
}
