package com.ibk.msg.web.rcsTemplate;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.commons.lang3.StringUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.base.Preconditions;
import com.ibk.msg.common.dto.PaginationResponse;
import com.ibk.msg.utils.RcsTemplateUtils;

@Component
public class RcsTemplateService {
	
	private static final Logger logger = LoggerFactory.getLogger(RcsTemplateService.class);
	
	/**
	 * RCS API 통신 여부
	 */
	@Value("${rcs.api.communication:true}") // properties에서 "rcs.api.communication"이 없을 경우  기본 "true" 설정
	private Boolean RCS_API_CMNCT;
	
	@Autowired
	private RcsTemplateDao dao;
	
	 public PaginationResponse findRcsTemplateByPagination(RcsTemplateSearchCondition searchCondition) throws Exception {
	    Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
	    Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");

	    int totalCount = dao.findTotalCount(searchCondition);
	    List<RcsTemplate> rcsTemplates = dao.findRcsTemplate(searchCondition);
	    	    								
	    return new PaginationResponse(searchCondition, totalCount, rcsTemplates);
	  }
	 
	 public List<RcsTemplate> findRcsTemplate(RcsTemplateSearchCondition searchCondition) throws Exception {
		 //searchCondition.setRcsApiCmnct(RCS_API_CMNCT);
		 return dao.findRcsTemplate(searchCondition);
	 }
	 
	 public List<Map<String, Object>> getRcsBizService(String cardType) throws Exception {
		 return dao.selectRcsBizService(cardType);
	 }
	 
	 @Transactional(transactionManager = "ibkSmsTxManager")
	 public Integer saveRcsTemplate(RcsTemplate param) throws Exception {
		 Boolean isCreate = StringUtils.isEmpty(param.getMsgbaseId());
			
			if(isCreate) {
				// 등록일 경우
				/* RCS_MSGBASE_REQ.MSGBASE_ID 규격
				 * # RBC API POST 등록 시: U[brandId]-[custTmpltId]
				 *                        custTmpltId – alphanumeric 25자
				 *   alphanumeric(25자_대소문자 모두 허용)
				 *
				 *   custTmpltId 어다인규칙 : "YmdHisX"(15자) + "alphanumeric"(10자)
				 */
				Map<String, Object> resultMap = dao.selectRcsTemplateDBYmd();
				//String today = (String)resultMap.get("TODAY");
				String sYmdhis = (String)resultMap.get("YMDHIS");
				
				Random rnd = new Random();
				StringBuffer buf = new StringBuffer();
				for(int i = 0; i < 10; i++){
					buf.append((char)((int)(rnd.nextInt(26))+97)); // 랜덤 한 소문자

					// rnd.nextBoolean() 는 랜덤으로 true, false 를 리턴. true일 시 랜덤 한 소문자를, false 일 시 랜덤 한 숫자를 StringBuffer 에 append 한다.
					/*
				    if(rnd.nextBoolean()){
				    	if(rnd.nextBoolean()){
					        buf.append((char)((int)(rnd.nextInt(26))+97)); // 랜덤 한 소문자
					    } else {
					    	buf.append((char)((int)(rnd.nextInt(26))+65));  // 랜덤 한 대문자
					    }
				    }else{
				        buf.append((rnd.nextInt(10)));
				    }
					 */
				}
				param.setMsgbaseId("U" + param.getBrId() +"-"+ sYmdhis +"X"+ buf.toString()); //  탬플릿 ID
				
				// 상태값 셋팅
				if(RCS_API_CMNCT == true) {
					// 새마을 금고 로직 참고
					param.setStatus("등록");
				} else {
					param.setStatus("저장");
					param.setApprResult("저장");
				}
				
			} else {
				// 수정일 경우 - 상태값 셋팅				
				if(RCS_API_CMNCT == true ) { //&& param.getStatus() != "등록"
					param.setStatus("03");
					param.setApprReason("");
					param.setApprResult("저장");
				} else {
					param.setStatus("저장");
					param.setApprResult("저장");
				}
				param.setApprReqUserId(null);
				param.setApprReqYmd(null);
				param.setApprDt(null);
			}
			
			param = setRcsData(param);
			
			//[수동일 경우에만 필요] RCS_MSGBASE_REQ 데이터를 RCS_MSGBASE로 데이터 셋팅
			RcsTemplateBase baseParam = new RcsTemplateBase(); 
			baseParam.setRcsTemplateBase(param);
			
			int result = 0;
			if(isCreate) {
				result = dao.insertRcsReq(param);
				if(RCS_API_CMNCT != true) {
					// 추가 - 수동일 경우
					baseParam.setStatus("저장");
					result = dao.insertRcsBase(baseParam);
				 }
				
			} else {
				result = dao.updateRcsReq(param);
				if(RCS_API_CMNCT != true) {
					// 수정 - 수동일 경우
					result = dao.updateRcsBase(baseParam);	
				}
			}
			
		 return result;
	 }
	 
	 /**
	  * 데이터 포맷 셋팅 
	 * @param rcs RcsTemplate
	 * @return RcsTemplate
	 * @throws Exception
	 */
	public RcsTemplate setRcsData(RcsTemplate rcs) throws Exception {
		//RCS_MSGBASE_FORM 조회후 필요값 세팅
		 rcs = this.selectRcsForm(rcs);
		
		// FormattedString 값 세팅
		if("cell".equals(rcs.getCardType())) {
			rcs = this.setJsonCell(rcs);
		} else {
			rcs.setFormattedString( rcs.getFormattedString().replace("{{description}}", rcs.getMsgbaseDesc()));
		}

	 	//CONTENT, 버튼 정보, 이미지등 JSON 포맷으로 변경
		rcs = RcsTemplateUtils.RCSBtnStringToJson(rcs);
		
		return rcs;
	 }
	 
	 @Transactional(transactionManager = "ibkSmsTxManager")
	 public Integer deleteRcsTemplate(RcsTemplate param) throws Exception {
		//RCS_MSGBASE_REQ 데이터를 RCS_MSGBASE로 데이터 셋팅
		RcsTemplateBase baseParam = new RcsTemplateBase(); 
		baseParam.setRcsTemplateBase(param);
			
		 int result = 0;
		 result = dao.deleteRcsReq(param);
		 if(RCS_API_CMNCT != true) {
			 result = dao.deleteRcsBase(baseParam);	 
		 }
		 
		 return result;
	 }
	 
	 @Transactional(transactionManager = "ibkSmsTxManager")
	 public Integer approvalRcsTemplate(RcsTemplate param) throws Exception {
		 int result = 0;
		 
		 if(RCS_API_CMNCT == true) {
			 // 자동일 경우 
			 String status = param.getStatus();
			if(status.equals("승인요청 실패") || status.equals("반려") || status.equals("승인") || status.equals("승인완료")) {
				param.setApprReason("");//apprReason 값 초기화
				param.setStatus("03");//MTS 매뉴얼 참고
				param.setApprResult("저장");
				
				//해당 MSGBASE_ID가 기등록 이력이 있을경우 예외 처리
				RcsTemplateBase baseParam = new RcsTemplateBase();
				baseParam.setRcsTemplateBase(param);
				List<RcsTemplateBase> resultBaseList = dao.selectRcsTemplateBase(baseParam);
				 
				if(resultBaseList.size() > 0) {
					RcsTemplateBase resultBase = resultBaseList.get(0);
					if(resultBase.getApprResult().equals("승인")) {
						resultBase.setApprResult("승인대기(수정)");
					} else if(resultBase.getApprResult().equals("반려")) {
						resultBase.setApprResult("반려(수정)");
					}
					result = dao.approvalRcsBase(baseParam);
					 
				}
			} 
		} else {
			// 수동일 경우
			param.setStatus("승인완료");
			param.setApprResult("승인");
			 
			//RCS_MSGBASE_REQ 데이터를 RCS_MSGBASE로 데이터 셋팅
			RcsTemplateBase baseParam = new RcsTemplateBase();
			baseParam.setRcsTemplateBase(param);
			result = dao.approvalRcsBase(baseParam);
		 }
		 
		 result = dao.approvalRcsReq(param);
		 
		 return result;
	 }
		
	 /**
	  * 스타일(cell) FormattedString 내용 세팅
	 * @param param RcsTemplate
	 * @return
	 * @throws Exception
	 */
	public RcsTemplate setJsonCell(RcsTemplate param) throws Exception {
		//스타일셀 가져오기
		JSONObject cell_json = new JSONObject(param.getFormattedString()); 
		
		JSONObject layout = cell_json.getJSONObject("RCSMessage").getJSONObject("openrichcardMessage").getJSONObject("layout"); //레이아웃가져오기
		JSONArray firstChildrenArr = layout.getJSONArray("children"); //1번 칠드런 가져오기
		JSONArray twoChildrenArr = firstChildrenArr.getJSONObject(1).getJSONArray("children"); //2번 칠드런 가져오기(셀내용이 두번째부터 있어서 처음거는패스)
		ArrayList<JSONObject> cellJsonArr = new ArrayList<JSONObject>();
		
		JSONObject paramCellJson = new JSONObject(param.getContentCell());
		int rowCnt = paramCellJson.getInt("cellCount"); //화면에서 넘어온 스타일셀 로우수

		int doubleRowCnt = rowCnt * 2; //JSON 베열개수 20개랑 맞추기위해서 두배로 늘려서 계산함(JSON은 라인배열 때문에 로우수가 10개 더많음) 
		int index = 0;
		
		for(int i = 0; i < doubleRowCnt; i++) {
			
			if(i % 2 == 0) {
				// 짝수일 경우  - 셀 입력값
				index = index + 1;
				JSONObject orientationObj = twoChildrenArr.getJSONObject(i); //한줄두줄 수Rr평세로 가져오기
				orientationObj.remove("widgetPolicy");
				
				// 수평 추가
				orientationObj.put("orientation", "horizontal");
				cellJsonArr.add(orientationObj);
				
				JSONArray threeChildrenArr = twoChildrenArr.getJSONObject(i).getJSONArray("children");
				// 셀 입력 한줄 두줄 값 (빈값도 허용하기 위함)
				int btnCellCount = paramCellJson.getInt("btnCell_" + index);
				for(int j = 0; j < btnCellCount; j++) {
					
					threeChildrenArr.getJSONObject(j).put("text", paramCellJson.getString("content_" + index + "_" + (j+1) )); //왼쪽셀 세팅
					if(paramCellJson.getString("content_"+ index +"_1_bold" ).toString().equals("bold")) {
						// bold 경우에만  데이터 추가
						threeChildrenArr.getJSONObject(j).put("textStyle", paramCellJson.getString("content_"+ index +"_"+ (j+1) +"_bold" )); // 글자 굵기
					}
					threeChildrenArr.getJSONObject(j).put("textSize", paramCellJson.getString("content_"+ index +"_"+ (j+1) +"_size")); //크기
					threeChildrenArr.getJSONObject(j).put("textColor", paramCellJson.getString("content_"+ index +"_"+ (j+1) +"_color")); // 색상
					threeChildrenArr.getJSONObject(j).put("textAlignment", paramCellJson.getString("content_"+ index +"_"+ (j+1) +"_align" )); //정렬
					
					threeChildrenArr.getJSONObject(j).remove("widgetPolicy");
					cellJsonArr.add(threeChildrenArr.getJSONObject(j)); //왼쪽셀 세팅 추가
				}
				
				if(btnCellCount != 2) {
					// 1단만 있을 경우 2단 부분 삭제
					RcsTemplateUtils.clearJson(threeChildrenArr.getJSONObject(1));
					cellJsonArr.remove(threeChildrenArr.getJSONObject(1));
				}
				
			} else {
				// 홀수일 경우 - 라인값
				JSONObject visibilityObj = twoChildrenArr.getJSONObject(i);
				visibilityObj.remove("widgetPolicy");
				//라인이 체크된경우만 라인은 갯수가 총9개 
				
				if( paramCellJson.getBoolean("line_" + index) == true ) {
					visibilityObj.put("visibility", "visible");
					cellJsonArr.add(visibilityObj);
				}
			}
		}
		
		// 세팅후 값이 없는 나머지 JSON 항목들 값 clean
		for(int i = doubleRowCnt; i < twoChildrenArr.length(); i++) {
			JSONObject threeChildrenArr = twoChildrenArr.getJSONObject(i);
			RcsTemplateUtils.clearJson(threeChildrenArr);
			cellJsonArr.remove(threeChildrenArr);
		}			
		logger.debug("cellJsonArr ==============" + cellJsonArr.toString());

		//스타일셀 조립
		param.setFormattedString( cell_json.toString().replace(",{}", "").replace("{}", "") );
		
		return param;
	}
	 
	/**
	 * 메시지 폼 조회 후 rcsTemplate 세팅
	 * @param param  resTemplate.msgbaseFormId 선택한 탬플릿 유형 ID
	 * @return
	 * @throws Exception
	 */
	public RcsTemplate selectRcsForm(RcsTemplate param) throws Exception {
		//RCS_MSGBASE_FORM 조회후 필요값 세팅
		RcsTemplateForm result = dao.selectRcsForm(param);
		
		param.setProductcode(result.getProductcode());
		param.setSpec(result.getSpec());
		param.setCardType(result.getCardType());
		param.setBizCondition(result.getBizCcondition());
		param.setBizCategory(result.getBizCategory());
		param.setBizService(result.getBizService());
		param.setPolicyInfo(result.getPolicyInfo());
		param.setGuideInfo(result.getGuideInfo());
		param.setFormParams(result.getFormParams());
		
		//CLOB처리
		// resultMap = this.clobConverMap(resultMap); 
		param.setFormattedString(result.getFormattedString());
		
		return param;
	}	
	
	
}
