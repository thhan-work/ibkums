package com.ibk.msg.web.manage;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.collections4.map.HashedMap;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.google.common.base.Preconditions;
import com.ibk.msg.common.dto.PaginationResponse;

@Component
public class ManageService {
	
	private static final Logger logger = LoggerFactory.getLogger(ManageService.class);

	@Autowired
	private ManageDao dao;
	
	private static String[] excelMapping = new String[] 
			{"bzwkNm", "bzwkIdnfr", "inptCmdCtnt", "rspblDvsnName", "rspblPsnName", "rspblPsnTelno", "emplDvsnNm"
					, "emplName", "liveYn", "sendDstic", "noticeObject", "msgAsblStsizCtnt", "smplMsgCtnt", "valdFrqnCtnt"
					, "dvlmYms", "interface", "funcTriInfo", "serviceIp", "servicePort", "simpleNotice", "tranEffeNotice"
					, "tranNoReason", "outptCmdCtnt", "custContIf", "synAsyn", "ifId", "targetIo", "serviceId", "userId"
					, "dataSavePath"};
	
	private static String[] headerNames = new String[]
			{"시스템명", "단위", "상세코드", "업무내용", "담당부서", "업무담당자", "담당자 연락처", "현업부서", "현업 담당자", 
				"활동여부", "발송매체", "통지대상", "메시지조립여부", "메시지형태", "발송주기 및 시간", "개발 적용일", "인터페이스", 
				"함수 / 트리거 / DB 정보", "서비스 IP", "서비스 PORT", "단순통지", "거래에 영향 있는 통지", "거래 안되는 사유", "비고", 
				"고객접촉", "IF 테이블", "동기/", "비동기", "IF ID", "타켓I/O", "서비스 ID", "UserID", "데이터저장경로"
			};

	public PaginationResponse findCodeGroupByPagination(CodeGroupSearchCondition searchCondition)
			throws Exception {
		Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
		Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");

		
		int totalCount = dao.findTotalCodeGroupCount(searchCondition);
		List<CodeGroup> branchStatisticsData = dao.findCodeGroup(searchCondition);

		return new PaginationResponse(searchCondition, totalCount, branchStatisticsData);
	}

	@SuppressWarnings("unchecked")
	public Set removeCodeGroup(String[] codeGroupId) {
//        Preconditions.checkArgument(emplIdArr.length > 0, "user id empty");
        Set resultSet = new HashSet();
        for (String codeGroupItem : codeGroupId) {
            dao.removeCodeGroup(codeGroupItem);
            resultSet.add(codeGroupItem);
        }
        return resultSet;
    }

    public String addCodeGroup(CodeGroup codeGroup) {
//        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getEmplId()), "emplId is empty");
//        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getUserLevel()), "UserLevel is empty");
//        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getEmplName()), "EmplName is empty");
//        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getBoCode()), "BoCode is empty");
//        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getEmplPosition()), "EmplPosition is empty");

        dao.addCodeGroup(codeGroup);
        return codeGroup.getCmmnCd();
    }

    public Object modifyCodeGroup(CodeGroup codeGroup) {
//        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getEmplId()), "emplId is empty");
//        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getUserLevel()), "UserLevel is empty");
//        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getEmplName()), "EmplName is empty");
//        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getBoCode()), "BoCode is empty");
//        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getEmplPosition()), "EmplPosition is empty");

        dao.modifyCodeGroup(codeGroup);
        return codeGroup.getCmmnCd();
    }

    public CodeGroup findDetailCodeGroup(String cmmnCd) {
        return dao.findDetailCodeGroup(cmmnCd);
    }
    
    public int findCodeGroupCount(String cmmnCd) {
        return dao.findCodeGroupCount(cmmnCd);
    }
    
	public Object findCodeGroup() {
		return dao.findAllCodeGroup();
	}
    
    
    
    
    public PaginationResponse findCodeByPagination(CodeSearchCondition searchCondition)
			throws Exception {
		Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
		Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");

		
		int totalCount = dao.findTotalCodeCount(searchCondition);
		List<Code> branchStatisticsData = dao.findCode(searchCondition);

		return new PaginationResponse(searchCondition, totalCount, branchStatisticsData);
	}

	@SuppressWarnings("unchecked")
	public Set removeCode(String[] keys) {
//        Preconditions.checkArgument(emplIdArr.length > 0, "user id empty");
        Set resultSet = new HashSet();
        for(int i=0,m=keys.length;i<m;i++) {
        	Map<Object, Object> param = new HashedMap<Object, Object>();
        	param.put("cmmnCd", keys[i].split("-")[0]);
        	param.put("dsplyNm", keys[i].split("-")[1]);
        	dao.removeCode(param);
            resultSet.add(param);
        }
        
        return resultSet;
    }

    public String addCode(Code code) {
//        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getEmplId()), "emplId is empty");
//        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getUserLevel()), "UserLevel is empty");
//        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getEmplName()), "EmplName is empty");
//        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getBoCode()), "BoCode is empty");
//        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getEmplPosition()), "EmplPosition is empty");

        dao.addCode(code);
        return code.getCmmnCd();
    }

    public Object modifyCode(Code code) {
//        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getEmplId()), "emplId is empty");
//        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getUserLevel()), "UserLevel is empty");
//        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getEmplName()), "EmplName is empty");
//        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getBoCode()), "BoCode is empty");
//        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getEmplPosition()), "EmplPosition is empty");

        dao.modifyCode(code);
        return code.getCmmnCd();
    }

    public Code findDetailCode(String cmmnCd, String dsplyNm) {
    	Map<Object, Object> param = new HashedMap<Object, Object>();
    	param.put("cmmnCd", cmmnCd);
    	param.put("dsplyNm", dsplyNm);
        return dao.findDetailCode(param);
    }
    
    public List<Code> findDetailCodes(String cmmnCd) {
    	Map<Object, Object> param = new HashedMap<Object, Object>();
    	param.put("cmmnCd", cmmnCd);
        return dao.findDetailCodes(param);
    }
    
    public int findCodeCount(String cmmnCd, String dsplyNm) {
    	Map<Object, Object> param = new HashedMap<Object, Object>();
    	param.put("cmmnCd", cmmnCd);
    	param.put("dsplyNm", dsplyNm);
        return dao.findCodeCount(param);
    }


    
    public PaginationResponse findJobCodeByPagination(JobCodeSearchCondition searchCondition)
			throws Exception {
		Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
		Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");

		
		int totalCount = dao.findTotalJobCodeCount(searchCondition);
		List<JobCode> branchStatisticsData = dao.findJobCode(searchCondition);

		return new PaginationResponse(searchCondition, totalCount, branchStatisticsData);
	}

	@SuppressWarnings("unchecked")
	public Set removeJobCode(String[] jobCode) {
//        Preconditions.checkArgument(emplIdArr.length > 0, "user id empty");
        Set resultSet = new HashSet();
        for (String jobCodeItem : jobCode) {
            dao.removeJobCode(jobCodeItem);
            resultSet.add(jobCodeItem);
        }
        return resultSet;
    }

    public String addJobCode(JobCode jobCode) {
//        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getEmplId()), "emplId is empty");
//        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getUserLevel()), "UserLevel is empty");
//        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getEmplName()), "EmplName is empty");
//        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getBoCode()), "BoCode is empty");
//        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getEmplPosition()), "EmplPosition is empty");

        dao.addJobCode(jobCode);
        return jobCode.getBzwkIdnfr();
    }

    public Object modifyJobCode(JobCode jobCode) {
//        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getEmplId()), "emplId is empty");
//        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getUserLevel()), "UserLevel is empty");
//        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getEmplName()), "EmplName is empty");
//        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getBoCode()), "BoCode is empty");
//        Preconditions.checkArgument(StringUtils.isNoneBlank(userInfo.getEmplPosition()), "EmplPosition is empty");

        dao.modifyJobCode(jobCode);
        return jobCode.getBzwkIdnfr();
    }

    public JobCode findDetailJobCode(String bzwkIdfr) {
        return dao.findDetailJobCode(bzwkIdfr);
    }
    
    public int findJobCodeCount(String bzwkIdfr) {
        return dao.findJobCodeCount(bzwkIdfr);
    }
    
	public List<Map<Object, Object>> findJobCode() {
		return dao.findAllJobCode();
	}
	
	
	@Transactional(transactionManager = "dacomTxManager")
	public Object processJobCodeExcel(MultipartFile excelFile) {
		boolean headerProcessed = false;
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		int totCnt = 0;
		int dupCnt = 0;
		int insCnt = 0;
		logger.debug(excelFile.getOriginalFilename());
    	try {    		
    		InputStream inputStream = excelFile.getInputStream();
    		Workbook workbook = null;
    		if(excelFile.getOriginalFilename().endsWith("xlsx")) {
    			workbook = new XSSFWorkbook(inputStream);
    		} else {
    			workbook = new HSSFWorkbook(inputStream);
    		}
    		
    		try {
    			Sheet datatypeSheet = workbook.getSheetAt(0);
    			Iterator<Row> iterator = datatypeSheet.iterator();

    			while (iterator.hasNext()) {

    				Row currentRow = iterator.next();
    				Iterator<Cell> cellIterator = currentRow.iterator();
    				
    				int i = 0;
    				Map<String, Object> rowMap = new HashMap<String, Object>();
    				while (cellIterator.hasNext()) {
    					Cell currentCell = cellIterator.next();
    					
    					if (currentCell.getCellTypeEnum() == CellType.STRING) {
    						rowMap.put(excelMapping[i], currentCell.getStringCellValue().trim());
    					} else if (currentCell.getCellTypeEnum() == CellType.NUMERIC) {
    						rowMap.put(excelMapping[i], currentCell.getNumericCellValue());
    					}
    					i++;
    				}
    				
					if (!headerProcessed) {
						headerProcessed = true;
					} else {
						totCnt++;
						// check exists
						int count = dao.findJobCodeCount((String)rowMap.get("bzwkIdnfr"));
						if (count >= 1) {
							dupCnt++;
						} else {
							if (rowMap.get("liveYn") != null) {
								String liveYn = (String) rowMap.get("liveYn");
								if (liveYn.equals("활동")) {
									rowMap.put("liveYn", "Y");
								} else {
									rowMap.put("liveYn", "N");
								}
							}
							
							if (rowMap.get("synAsyn") != null) {
								String synAsyn = (String) rowMap.get("synAsyn");
								if (synAsyn.equals("동기")) {
									rowMap.put("synAsyn", "Y");
								} else {
									rowMap.put("synAsyn", "N");
								}
							}
							
							insCnt++;
							rowMap.put("groupCoCd", "IBK");
							rowMap.put("bzwkChnlCd", "IB");
							rowMap.put("bzwkGroupCd", "IB");
							// insert
							dao.addJobCode(rowMap);
						}
					}
    			}
    		} catch (Exception e) {
    			logger.error("", e);
    		} finally {
    			workbook.close();
    			inputStream.close();
    		}
    	} catch (FileNotFoundException e) {
    		logger.error("", e);
    	} catch (IOException e) {
    		logger.error("", e);
    	}
    	
    	result.put("totCnt", totCnt);
    	result.put("dupCnt", dupCnt);
    	result.put("insCnt", insCnt);
    	
		return result;
	}
}
