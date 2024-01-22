package com.ibk.msg.utils;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedWriter;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.opencsv.CSVReader;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class TobeFileHandler {
	
	static public String getvoJson(Object object) {
		
		return new Gson().toJson(object);
	}
	
	static String checkFileSize(String fileExt,long fileSize) {
		  if("xls".equalsIgnoreCase(fileExt)||"xlsx".equalsIgnoreCase(fileExt)) {
			  if(fileSize>6500000) {
				  return "upload file is too big(size="+fileSize+")";
			  }
		  }else if("csv".equalsIgnoreCase(fileExt)) {
			  if(fileSize>8000000) {
				  return "upload file is too big(size="+fileSize+")";
			  }
		  }else {
			  return fileExt+" is not supported";
		  }
		
		return null;
	}
	
	static String extractFileExtension(MultipartFile uploadFile) {
		String fileExt=uploadFile.getOriginalFilename().substring(uploadFile.getOriginalFilename().lastIndexOf(".") + 1);
		return fileExt;
	}
	
	static String generateUniqueFileName(MultipartFile uploadFile,String groupUniqNo) {
		
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat dateFormat =new SimpleDateFormat("yyMMddHHmmss");
		String fileTime= dateFormat.format(calendar.getTime());
		
		String uploadFileName=uploadFile.getOriginalFilename();		
		// 파일명에 경로가 포함된 경우 고려
		if(uploadFileName.indexOf("/")>0||uploadFileName.indexOf("\\")>0) {
			if (uploadFileName.indexOf("/") > 0) {
				uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("/")+1);
			} else {
				uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			}
		}
		
		//그룹아이디+"."+YYMMDDHHmmss+"."+원파일명
		return groupUniqNo+"."+fileTime+"."+uploadFileName.substring(0, uploadFileName.lastIndexOf("."));
	}
	
	static public String saveFile(MultipartFile uploadFile, String uploadedDir) {
	    String fullPath = uploadedDir+"/" + uploadFile.getOriginalFilename();
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
	
	static public Map<String, Object> hadleFile(MultipartFile uploadFile,String groupUniqNo,String sendType,String filePath, boolean dupCheck){
		Map<String, Object> resultMap = new HashMap<>();
		String fileExt=extractFileExtension(uploadFile) ;
		String message=checkFileSize(fileExt,uploadFile.getSize());
		
		File path = new File(filePath);
		if (!path.exists()) {
			path.mkdirs();
		}
		
		int errCnt = 0;
		int totCnt = 0;
		
		String[] fieldName =  new String[] {"고객번호", "고객명", "휴대폰번호"};
		String[] extFieldName = null;
		int extFieldCnt=0;
		int[] byteMax=null;
		
		StringBuilder totalSB = new StringBuilder();//txt에 쓸 String 저장
		StringBuilder sb= new StringBuilder();
		
		File tmpFile=null;
		File newFile=null;
		
		Workbook wb=null;
		CSVReader reader =null;
		//FileOutputStream fop = null;
		Writer writer=null;
		if(message != null) {
			resultMap.put("message", message);
			return resultMap;
		}
		
		String uqiuName=generateUniqueFileName(uploadFile, groupUniqNo);
		if(uqiuName==null) {
			resultMap.put("message", "업로드 파일을 찾을 수 없습니다.");
			return resultMap;
		}
			
		List<HashMap<String,String>> displayList=new ArrayList<HashMap<String,String>>(30);
		Map<Integer, String> errMap = new HashMap<Integer, String>();
		Map<String, String> dupPhone = new HashMap<String, String>();
		if(fileExt.equalsIgnoreCase("xls")||fileExt.equalsIgnoreCase("xlsx")) {
			try {
				
				tmpFile = new File(filePath + System.getProperty("file.separator") +uqiuName+"."+fileExt);
				uploadFile.transferTo(tmpFile);
				
				wb=WorkbookFactory.create(tmpFile);
				Sheet sheet = wb.getSheetAt(0);
				Cell cell = null; 
				Row row = null;
				int rows = sheet.getPhysicalNumberOfRows();
				
				if (rows <=1) {									// 내용이 없는 빈 파일 
					log.error("target file exception", "내용이 없는 빈 파일");
					resultMap.put("message", "파일 내용이 비어있습니다.\n파일을 확인해주세요.");
					return resultMap;
				}
				
				/* 첫번째 Row의 Cell 개수 *주의 엑셀에 빈열이라도 서식이나, 스타일이 있으면 카운터 체크 대상*/
				int firRowCnt = sheet.getRow(0).getPhysicalNumberOfCells();  // 컬럼 명 갯수 
				log.debug("PhysicalNumberOfCells="+firRowCnt+",  LastCellNum="+sheet.getRow(0).getLastCellNum());
				row = sheet.getRow(0);
				for(int i = 0; i < firRowCnt; i++){  //컬럼명
					if(row.getCell(i)==null ||row.getCell(i).toString().trim().equals("")){
						firRowCnt = i;
						break;
					}
				}
				
				if (firRowCnt < 3) {							// 컬럼 수 오류 체크
					log.error("target file exception", "헤드 컬럼 최소 갯수 오류");
					resultMap.put("message", "파일 첫 줄 컬럼 포맷을 확인해 주세요.");
					return resultMap;
				}					
				
				if (firRowCnt > 10) {							// 컬럼 수 오류 체크
					log.error("target file exception", "헤드 컬럼 최대 갯수 오류");
					resultMap.put("message", "파일 첫 줄 컬럼 포맷을 확인해 주세요.\n[최대 10개]");
					return resultMap;
				}		
	
				// 공통 파일 컬럼 헤더 검사
				for(int i = 0; i < firRowCnt; i++){  //컬럼명 뽑아서 필드 네임 배열에 넣고 중복 체크
					if(row.getCell(i)==null ||row.getCell(i).toString().trim().equals("")){
							log.error("target file exception", "컬럼명 빈값 오류");
							resultMap.put("message", "컬럼 명은 비워 둘수 없습니다. 컬럼 명을 확인해주세요.");
							return resultMap;
					}
					
					String tempValue=row.getCell(i).toString().trim();
										
					if( i<3 && !fieldName[i].equals(tempValue)) {
						log.error("target file exception", "파일 헤드포맷 에러");
						resultMap.put("message", "파일 헤드 컬럼명을 확인해 주세요.");
						return resultMap;
					}

				}
				// 치환형 파일 컬럼 헤더 추가 작업
				if(firRowCnt > 3) {
					extFieldCnt=firRowCnt-3;
					extFieldName = new String[extFieldCnt];
					byteMax=new int[extFieldCnt];//각 칼럼의 맥스 바이트 값을 담을 인트형 배열 
					for(int b=0;b<extFieldCnt;b++ ){ //각 초기화 추후 치환 파일 용량 체크 를 위한 로직 
						byteMax[b]=0;
					}
					
					for(int i = 3; i < firRowCnt; i++){
						String tempValue=row.getCell(i).toString().trim();
						
						//헤더 한글 영문 숫자 _ 언더바만 허용 
						if(!Pattern.matches("([\\x{ac00}-\\x{d7af}a-zA-Z0-9_]+)",tempValue)){
							log.error("target file exception", "파일 헤드포맷 에러");
							resultMap.put("message", "파일 헤드 컬럼명에 지원하지않는 문자가 포함되어 있습니다.");
							return resultMap;
						}
						
						for(int j=0; j<3; j++){
							if(fieldName[j].equals(tempValue)){
								log.error("target file exception", "파일 헤드포맷 에러");
								resultMap.put("message", "중복된 컬럼명이 있습니다. 컬럼명을 확인해주세요.");
								return resultMap;
							}
						}
						
						for(int k=0; k<(i-3); k++){
							if(extFieldName[k].equals(tempValue)){
								log.error("target file exception", "파일 헤드포맷 에러");
								resultMap.put("message", "중복된 컬럼명이 있습니다. 컬럼명을 확인해주세요.");
								return resultMap;
							}
						}
						
						extFieldName[i-3] = tempValue;	
					}
				}
				
				newFile = new File(filePath + System.getProperty("file.separator") +uqiuName+".ibk");
				resultMap.put("realFileName", uqiuName+".ibk");
				writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(newFile), "EUC-KR"));
				//fop = new FileOutputStream(newFile);
	
				totCnt=0;
				for(int r=1; r<rows;r++) {
					row =sheet.getRow(r);
					if(firRowCnt<sheet.getRow(r).getPhysicalNumberOfCells()) {
						log.error("target file exception", "파일 헤드포맷 에러");
						resultMap.put("message", "파일 헤드 컬럼명을 확인해 주세요.");
						return resultMap;
					}
					if(row==null) {
						errMap.put(r+1, "NULL 값 에러");
						errCnt++;
						continue;
					}
					
					String[] tempValue = new String[firRowCnt];
					
					for(int c=0;c<firRowCnt;c++) {// Row의 Cell 데이터 처리 Loop 시작
						
						tempValue[c]="";
						if(row.getCell(c)==null) {
							tempValue[c]="";
						}else {
							cell=row.getCell(c);
							if (cell.getCellTypeEnum() == CellType.STRING) {
								tempValue[c]=cell.getStringCellValue().trim();
							}else if(cell.getCellTypeEnum() == CellType.NUMERIC) {
								if(!DateUtil.isCellDateFormatted(cell)){
									long data= (long)cell.getNumericCellValue();
									tempValue[c]=String.valueOf(data).trim();
								}
							}
						}
							
						//발송 업무 타입에 따른 필수 값 확인
						//마케팅 경우 첫번째(고객번호), 세번째(휴대폰번호) 필수 값, 비마케팅 경우 세번째 필수 값
						//0: 고객번호, 1: 고객명, 2: 휴대폰번호
						if(sendType.equalsIgnoreCase("m")) {
							if(c==0||c==1||c==2){
								if(!sendTargetValid(c, tempValue[c])){
									if(c==0){
										errMap.put(r+1, "고객번호 필수 값 에러");
									}else if(c==1){
										errMap.put(r+1, "고객명 값 길이 에러");
									}else if(c==2) {
										errMap.put(r+1, "휴대폰번호 필수 값 에러");
									}
									errCnt++;
									sb.setLength(0);
									break;
								}
							}
						}else {
							if(c==2) {
								if(!sendTargetValid(c, tempValue[c])) {
									errMap.put(r+1, "휴대폰번호 필수 값 에러");
									errCnt++;
									sb.setLength(0);
									break;
								}								
							}
						}
						
						if(c==2 && dupCheck) {
							if(dupPhone.containsKey(tempValue[c])) {
								errMap.put(r+1, "휴대폰 번호 중복");
								errCnt++;
								sb.setLength(0);
								break;
							}else {
								dupPhone.put(tempValue[c], null);
							}	
						}
						if(extFieldCnt>0 && c>=3) {
							if(tempValue[c].equals("")) {
								errMap.put(r+1, "치환 값 에러");
								errCnt++;
								sb.setLength(0);
								break;
							}else {
								byte[] byteLen=tempValue[c].trim().getBytes("EUC-KR");
								
								if(byteMax[c-fieldName.length]<byteLen.length){//추후에 치환 발송기안 바이트 제한 
									byteMax[c-fieldName.length]=byteLen.length;
								}
							}
						}
						
						//구분자 '|' 
						if (c>0 && (c)!=firRowCnt) {
							sb.append("|");	
						}
						// '\' 문자가 컬럼내용중 마지막에 들어오면 내용 치환이 꼬이는거 임시 조치 \가 들어오면 \+스페이스 한칸
						sb.append(tempValue[c].replace("\\", "\\ ").replace("|", "\\|").replace("\r\n", "\\n").replace("\r", "\\n").replace("\n", "\\n"));
						
					}// 셀 루프문 끝
					
					if((rows <= 21  || (  totCnt	< 10 || ((rows-1) - totCnt <= 10 )))&& sb.length()>0) { 
						HashMap<String, String> fhmlst=new LinkedHashMap<String, String>(firRowCnt+1);
						int cut=firRowCnt-extFieldCnt;
						for(int mi=0; mi<firRowCnt; mi++){							
							if(cut>0 && mi>=cut) {
								fhmlst.put(extFieldName[mi-cut], tempValue[mi]);
							}else {
								fhmlst.put(fieldName[mi], tempValue[mi]);
							}
						}
						displayList.add(fhmlst);
					} 
					if(sb.length()>0) {
						sb.append(System.getProperty("line.separator"));
						totalSB.append(sb.toString());
						sb.setLength(0);
						totCnt++;	
					}
				}//row 루푸문 끝
				
				writer.write(totalSB.toString());
				writer.flush();
				writer.close();
				wb.close();
				//fop.write(totalSB.toString().getBytes());
			} catch (EncryptedDocumentException e) {
				e.printStackTrace();
			} catch (InvalidFormatException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}finally {
				if(tmpFile!=null)tmpFile.delete();
				if (writer != null) {
					try {
						writer.flush();
						writer.close();
					} catch (Exception ignored) {
						log.debug(ignored.getMessage());
					} finally {
						writer = null;
					}
				}
				
				if (wb != null) {
					try {
						wb.close();
					} catch (Exception ignored) {
						log.debug(ignored.getMessage());
					} finally {
						wb = null;
					}
				}
			}
		}else if("csv".equalsIgnoreCase(fileExt)) {
			try {
				reader = new CSVReader(new InputStreamReader(new FileInputStream(tmpFile), "EUC-KR"));
				List<String[]> datas = reader.readAll();
				if (datas.size() <= 1) {
					log.error("target file exception", "내용이 없는 빈 파일");
					resultMap.put("message", "파일 내용이 비어있습니다.\n파일을 확인해주세요.");
					return resultMap;
				}
				Iterator<String[]> ite = datas.iterator();
				String[] rowValues=null;
				int firRowCnt=0;
				int row=1;
				if(ite.hasNext()) {
					rowValues=ite.next();
					if(rowValues!=null ) {
						firRowCnt=rowValues.length;
						if(firRowCnt<3) {
							log.error("target file exception", "헤드 컬럼 최소 갯수 오류");
							resultMap.put("message", "파일 첫 줄 컬럼 포맷을 확인해 주세요.");
							return resultMap;
						}

						String tempValue="";
						for(int i = 0; i < firRowCnt; i++){  //컬럼명
							if(rowValues[i]==null ||rowValues[i].trim().equals("")){
								log.error("target file exception", "헤드 컬럼 포맷 오류");
								resultMap.put("message", "파일 첫 줄 컬럼 포맷을 확인해 주세요.");
								return resultMap;
							}

							tempValue=rowValues[i].trim();
							if( i<3 && !fieldName[i].equals(tempValue)) {
								log.error("target file exception", "파일 헤드포맷 에러");
								resultMap.put("message", "파일 헤드 컬럼명을 확인해 주세요.");
								return resultMap;
							}

						}
						if(firRowCnt > 3) {
							extFieldCnt=firRowCnt-3;
							extFieldName = new String[extFieldCnt];
							byteMax=new int[extFieldCnt];//각 칼럼의 맥스 바이트 값을 담을 인트형 배열 
							for(int b=0;b<extFieldCnt;b++ ){ //각 초기화 추후 치환 파일 용량 체크 를 위한 로직 
								byteMax[b]=0;
							}
							
							for(int i = 3; i < firRowCnt; i++){
								tempValue=rowValues[i].trim();
								
								//헤더 한글 영문 숫자 _ 언더바만 허용 
								if(!Pattern.matches("([\\x{ac00}-\\x{d7af}a-zA-Z0-9_]+)",tempValue)){
									log.error("target file exception", "파일 헤드포맷 에러");
									resultMap.put("message", "파일 헤드 컬럼명에 지원하지않는 문자가 포함되어 있습니다.");
									return resultMap;
								}
								
								for(int j=0; j<3; j++){
									if(fieldName[j].equals(tempValue)){
										log.error("target file exception", "파일 헤드포맷 에러");
										resultMap.put("message", "중복된 컬럼명이 있습니다. 컬럼명을 확인해주세요.");
										return resultMap;
									}
								}
								for(int k=0; k<(i-3); k++){
									if(extFieldName[k].equals(tempValue)){
										log.error("target file exception", "파일 헤드포맷 에러");
										resultMap.put("message", "중복된 컬럼명이 있습니다. 컬럼명을 확인해주세요.");
										return resultMap;
									}
								}
								
								extFieldName[i-3] = tempValue;	
							}
						}
					}else {
						log.error("target file exception", "헤드 컬럼 포맷 오류");
						resultMap.put("message", "파일 첫 줄 컬럼 포맷을 확인해 주세요.");
						return resultMap;
					}
				}else {
					log.error("target file exception", "헤드 컬럼 포맷 오류");
					resultMap.put("message", "파일 첫 줄 컬럼 포맷을 확인해 주세요.");
					return resultMap;
				}
				newFile = new File(filePath + System.getProperty("file.separator") +uqiuName+".ibk");
				resultMap.put("realFileName", uqiuName+".ibk");
				writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(newFile), "EUC-KR"));
				totCnt=0;
				while (ite.hasNext()) {
					rowValues=ite.next();
					if(rowValues==null||rowValues.length==0) {
						row+=1;
						errMap.put(row, "빈 라인 존재");
						continue;
					}

					for(int c=0;c<firRowCnt;c++) {
						if(rowValues[c]==null) {
							row+=1;
							errMap.put(row, "알수 없는 빈 값 에러");
							errCnt++;
							sb.setLength(0);
							break;
						}else {
							if(sendType.equalsIgnoreCase("m")) {
								if(c==0 ) {
									if(!sendTargetValid(c, rowValues[c])) {
										row+=1;
										errMap.put(row, "고객번호 필수 값 에러");
										errCnt++;
										sb.setLength(0);
										break;
									}
								}
								if(c==1 ) {
									if(!sendTargetValid(c, rowValues[c])) {
										row+=1;
										errMap.put(row, "고객명 필수 값 에러");
										errCnt++;
										sb.setLength(0);
										break;
									}
								}
								if(c==2 ) {
									if(!sendTargetValid(c, rowValues[c])) {
										row+=1;
										errMap.put(row, "휴대폰번호 필수 값 에러");
										errCnt++;
										sb.setLength(0);
										break;
									}
								}
							}else {
								if(c==2 ) {
									if(!sendTargetValid(c, rowValues[c])) {
										row+=1;
										errMap.put(row, "휴대폰번호 필수 값 에러");
										errCnt++;
										sb.setLength(0);
										break;
									}
								}
							}
							
							if(c==2) {
								if(dupPhone.containsKey(rowValues[c])) {
									row+=1;
									errMap.put(row, "휴대폰 번호 중복");
									errCnt++;
									sb.setLength(0);
									break;
								}else {
									dupPhone.put(rowValues[c], null);
								}	
							}
							
							if(extFieldCnt>0 && c>=3) {
								if(rowValues[c].equals("")) {
									row+=1;
									errMap.put(row, "치환 값 에러");
									errCnt++;
									sb.setLength(0);
									break;
								}else {
									byte[] byteLen=rowValues[c].trim().getBytes("EUC-KR");
									
									if(byteMax[c-fieldName.length]<byteLen.length){//추후에 치환 발송기안 바이트 제한 
										byteMax[c-fieldName.length]=byteLen.length;
									}
								}
							}
							
							//구분자 '|' 처음과 끝에 제외  구분자 추가
							if (c>0 && (c)!=firRowCnt) {
								sb.append("|");	
							}
							// '\' 문자가 컬럼내용중 마지막에 들어오면 내용 치환이 꼬이는거 임시 조치 \가 들어오면 \+스페이스 한칸
							sb.append(rowValues[c].replace("\\", "\\ ").replace("|", "\\|").replace("\r\n", "\\n").replace("\r", "\\n").replace("\n", "\\n"));
						}//if(rowValues[c]==null) 끝 >> 컬럼 낱개 처리

					}//for(int c=0;c<firRowCnt;c++) 한 로우 컬럼 처리 끝					
					
					if((datas.size() <= 20  || (  totCnt < 10 || (datas.size() - totCnt < 10 ))) && sb.length()>0) { 
						HashMap<String, String> fhmlst=new LinkedHashMap<String, String>(firRowCnt+1);
						int cut=firRowCnt-extFieldCnt;
						for(int mi=0; mi<firRowCnt; mi++){							
							if(cut>0 && mi>=cut) {
								fhmlst.put(extFieldName[mi-cut], rowValues[mi]);
							}else {
								fhmlst.put(fieldName[mi], rowValues[mi]);
							}
						}
						displayList.add(fhmlst);
					}
					row+=1;
					if(sb.length()>0) {
						sb.append(System.getProperty("line.separator"));
						totalSB.append(sb.toString());
						sb.setLength(0);
						totCnt+=1;
					}
				}//while(ite.hasNext()) ends
				
				writer.write(totalSB.toString());
				writer.flush();
				writer.close();
				reader.close();
			}catch (EncryptedDocumentException e) {
				e.printStackTrace();
			} catch (FileNotFoundException e) {			
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(tmpFile!=null)tmpFile.delete();
				if (writer != null) {
					try {
						writer.flush();
						writer.close();
					} catch (Exception ignored) {
						log.debug(ignored.getMessage());
					} finally {
						writer = null;
					}
				}
				
				if (reader != null) {
					try {
						reader.close();
					} catch (Exception ignored) {
						log.debug(ignored.getMessage());
					} finally {
						reader = null;
					}
				}
			}
		}
		
		resultMap.put("fieldName", fieldName);
		resultMap.put("displayList", displayList);
		resultMap.put("errCnt", errCnt);
		resultMap.put("totCnt", totCnt);
		if(errCnt>0) {
			resultMap.put("errMap", errMap);
		}
		if(byteMax!=null) {
			resultMap.put("byteMax", byteMax);
		}
		if(extFieldName!=null) {
			resultMap.put("extFieldName", extFieldName);
		}
		return resultMap;
	}

private static boolean isMobile(String mobile) {					
		boolean check = true;
		String mobile2=mobile.replaceAll("-", "");
		if (mobile2.length() > 0 && !mobile2.startsWith("01")) check = false;
		if (mobile2.length() < 9) check = false; 
		if (mobile2.length() > 11)check = false;
		for (int i = 0; i < mobile2.length(); i++) {
			if (!Character.isDigit(mobile2.charAt(i))) {
				check = false;
				break;
			}
		}
		return check;
	}
	 
 public static void downloadFile(File downloadFile,HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setHeader("Content-Type", "application/msexcel; charset=UTF-8");
		response.setContentLength((int) downloadFile.length());
		response.setHeader("Content-Disposition", "attachment; filename=" + getDisposition(downloadFile.getName(), getBrowser(request)));
//		Workbook wb=WorkbookFactory.create(downloadFile);
		ServletOutputStream sos=response.getOutputStream();
		byte[] buf = new byte[10240];
		int len = 0;
		DataInputStream dis = new DataInputStream(new FileInputStream(downloadFile));
		while((len = dis.read(buf))!=-1) {
			sos.write(buf, 0, len);
		}
		sos.flush();
//		wb.write(sos);
//		wb.close();
		sos.close();
	}
/* 
 * .doc       application/msword
    .docx     application/vnd.openxmlformats-officedocument.wordprocessingml.document
    .pdf
*/
 public static void downloadFile2(File downloadFile,HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setHeader("Content-Type", "application/pdf; charset=UTF-8");
		response.setContentLength((int) downloadFile.length());
		response.setHeader("Content-Disposition", "attachment; filename=" + getDisposition(downloadFile.getName(), getBrowser(request)));
		BufferedInputStream inStrem = new BufferedInputStream(new FileInputStream(downloadFile));
	    BufferedOutputStream outStream = new BufferedOutputStream(response.getOutputStream());
	      
	      byte[] buffer = new byte[1024];
	      int bytesRead = 0;
	      while ((bytesRead = inStrem.read(buffer)) != -1) {
	        outStream.write(buffer, 0, bytesRead);
	      }
	      outStream.flush();
	      inStrem.close();
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
	private static boolean sendTargetValid(int index, String value) throws UnsupportedEncodingException {
		if(index==0) {//고객번호
			if(value.trim().equals("")) {
				return false;
			}else if(value.trim().getBytes("euc-kr").length > 20) {
				return false;
			}
		}else if(index==1) {//고객명
			 if(value.trim().getBytes("euc-kr").length > 20) {
					return false;
			}
		}else if(index==2) {//휴대폰번호
			return isMobile(value);
		}else {
			return false;
		}
		return true;
	}
	
	/**
	 * 엑셀 파일 검증 시, 실패결과 리턴
	 * @param map
	 * @param file
	 * @param msg
	 * @return
	 */
	public static HashMap<String, Object> getFailResult(HashMap<String, Object> map, String msg) {
		map.put("result", "FAIL");
		map.put("message", msg);
		return map;
	}

	/**
	 * 22.09.21 발송대상자 엑셀업로드 추가
	 * @param uploadFile
	 * @param groupUniqNo
	 * @param filePath
	 * @return
	 */
	public static HashMap<String, Object> excelUpload(MultipartFile uploadFile, String groupUniqNo, String filePath) {
		HashMap<String, Object> resultMap = new HashMap<>();
		
		// 엑셀 파일 검증
		// 1. 엑셀 파일 확장자 체크
		String fileExt = extractFileExtension(uploadFile);
		if(!("xlsx".equals(fileExt) || "xls".equals(fileExt))) {
			return getFailResult(resultMap, "파일등록 확장자는 EXCEL(*.xls, *.xlsx)만 가능합니다.");
		}
		
		// 2. 엑셀 파일 사이즈 체크
		String message = checkFileSize(fileExt,uploadFile.getSize());
		if(message != null) {
			return getFailResult(resultMap, message);
		}
		
		// 3. 엑셀 데이터 포맷 체크
		File excelFile = null;
		Workbook wb = null;
		String uqiuName = generateUniqueFileName(uploadFile, groupUniqNo);
		
		// 엑셀 고정 헤더 값
		String[] fieldName =  new String[] {"고객명", "고객번호", "휴대폰번호"};
		String[] replcFldNm = null;
		
		try {
			
			File path = new File(filePath);
			if (!path.exists()) {
				path.mkdirs();
			}
			
			// 엑셀 업로드
			String fileNm = uqiuName + "." + fileExt;
			excelFile = new File(filePath + System.getProperty("file.separator") + fileNm);
			uploadFile.transferTo(excelFile);
			
			wb = WorkbookFactory.create(excelFile);
			Sheet sheet = wb.getSheetAt(0);
			Row row = null;
			int rows = sheet.getPhysicalNumberOfRows();
			
			// 3-1. 엑셀 빈파일 체크
			if (rows <= 1) {								 
				log.error("target file exception", "내용이 없는 빈 파일");
				return getFailResult(resultMap, "파일 내용이 비어있습니다.\n파일을 확인해주세요.");
			}
			
			// 3-2. 엑셀 최대 건수 체크
			if(rows > 1000000) {
				resultMap.put("message", "발송가능 총 건수가 100만 건을 초과하였습니다.\n메시지 발송 시스템의 부하가 발생할 수 있으니\nIT담당자에게 확인하시기 바랍니다.");
			}
			
			// 3-3. 헤더 컬럼 개수 체크 
			int firRowCnt = sheet.getRow(0).getPhysicalNumberOfCells();  // 컬럼 명 갯수 
			log.debug("PhysicalNumberOfCells="+firRowCnt+",  LastCellNum="+sheet.getRow(0).getLastCellNum());
			row = sheet.getRow(0);
			for(int i = 0; i < firRowCnt; i++){  //컬럼명
				if(row.getCell(i)==null ||row.getCell(i).toString().trim().equals("")){
					firRowCnt = i;
					break;
				}
			}
			
			// 헤더 최소 갯수 체크
			if (firRowCnt < 3) { 
				log.error("target file exception", "헤드 컬럼 최소 갯수 오류");
				return getFailResult(resultMap, "파일 첫 줄 컬럼 포맷을 확인해 주세요.");
			}					
			
			// 헤더 최대 갯수 체크
			if (firRowCnt > 10) { 
				log.error("target file exception", "헤드 컬럼 최대 갯수 오류");
				return getFailResult(resultMap, "파일 첫 줄 컬럼 포맷을 확인해 주세요.\n[최대 10개]");
			}		

			// 3-4. 헤더 빈값 및 필수값 체크
			for(int i = 0; i < firRowCnt; i++){  //컬럼명 뽑아서 필드 네임 배열에 넣고 중복 체크
				if(row.getCell(i)==null ||row.getCell(i).toString().trim().equals("")){
						log.error("target file exception", "컬럼명 빈값 오류");
						return getFailResult(resultMap, "컬럼 명은 비워 둘수 없습니다. 컬럼 명을 확인해주세요.");
				}
				
				String tempValue=row.getCell(i).toString().trim();
									
				if(i < 3 && Arrays.asList(fieldName).indexOf(tempValue) < 0) {
					log.error("target file exception", "파일 헤드포맷 에러");
					return getFailResult(resultMap, "파일 헤드 컬럼명을 확인해 주세요.");
				}

			}
			
			// 3-5. 치환형 헤더 값 유효성 검사
			int extFieldCnt = 0;
			if(firRowCnt > 3) {
				extFieldCnt = firRowCnt-3;
				replcFldNm = new String[extFieldCnt];
				
				for(int i = 3; i < firRowCnt; i++){
					String tempValue=row.getCell(i).toString().trim();
					
					//헤더 한글 영문 숫자 _ 언더바만 허용 
					if(!Pattern.matches("([\\x{ac00}-\\x{d7af}a-zA-Z0-9_]+)",tempValue)){
						log.error("target file exception", "파일 헤드포맷 에러");
						return getFailResult(resultMap, "파일 헤드 컬럼명에 지원하지않는 문자가 포함되어 있습니다.");
					}
					
					for(int j = 0; j < 3; j++){
						if(fieldName[j].equals(tempValue)){
							log.error("target file exception", "파일 헤드포맷 에러");
							return getFailResult(resultMap, "중복된 컬럼명이 있습니다.\n컬럼명을 확인해주세요.");
						}
					}
					
					for(int k = 0; k < (i-3); k++){
						if(replcFldNm[k].equals(tempValue)){
							log.error("target file exception", "파일 헤드포맷 에러");
							return getFailResult(resultMap, "중복된 컬럼명이 있습니다.\n컬럼명을 확인해주세요.");
						}
					}
					replcFldNm[i-3] = tempValue;	
				}
			}
			resultMap.put("fileNm", fileNm);
			resultMap.put("result", "SUCCESS");
		} catch (EncryptedDocumentException e) {
			e.printStackTrace();
		} catch (InvalidFormatException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (wb != null) {
				try {
					wb.close();
				} catch (Exception ignored) {
					log.debug(ignored.getMessage());
				} finally {
					wb = null;
				}
			}
			String result = resultMap.get("result").toString();
			if("FAIL".equals(result) && excelFile != null) {
				excelFile.delete();
			}
		}
		return resultMap;
	}
}