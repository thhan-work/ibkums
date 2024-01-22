package com.ibk.msg.utils;

import java.text.SimpleDateFormat;
import java.util.Iterator;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ibk.msg.web.alimTalkTemplate.AlimTalkTemplate;
import com.ibk.msg.web.rcsTemplate.RcsTemplate;

public class RcsTemplateUtils {
	
	private static final Logger logger = LoggerFactory.getLogger(RcsTemplateUtils.class);
	
	//2.채널별버튼내용
			/* copy_tmp				복사하기				copy
			open_url				URL연결(외부 브라우저)	url
			dial_phone_number		전화걸기				tel
			show_location			지도보여주기(좌표)		coordinate
			search_locations		지도보여주기(쿼리)		query
			request_location_push	현재위치공유			position
			create_calendar_event	캘린더등록				calendar
//			compose_text_message	메시지작성				msg
			*/
			
			//String openUrl_tmp = "{\"action\": {\"urlAction\": { \"openUrl\": {\"url\": \"\" }},\"displayText\": \"\", \"postback\": {\"data\": \"open_url\" }}}";
	
	// 22.12.28 m1오류 발생으로 postback키값 주석처리(postback은 chatbot에서 사용하는 키로, chatbot사용안하는 관계로 제거)
	public static final String URL_TMP = "{\"action\": {\"urlAction\": { \"openUrl\": {\"url\": \"\" }},"
										    + "\"displayText\": \"\""
										    //+ "\"postback\": {\"data\": \"set_by_chatbot_open_url\" }"
										    + "}}";
	public static final String COPY_TMP = "{\"action\": {"
											+ "				\"clipboardAction\": {"
											+ "					\"copyToClipboard\": {\"text\": \"\" }"
											+ "				},"
											+ "				\"displayText\": \"\""
											//+ "				\"postback\": {\"data\": \"set_by_chatbot_copy_to_clipboard\"}"
											+ "				}"
											+ "		   }";
			// 
	public static final String TEL_TMP = "{\"action\": {"
											+ "				\"dialerAction\": {"
											+ "					\"dialPhoneNumber\": {\"phoneNumber\": \"\" }"
											+ "				},"
											+ "				\"displayText\": \"\" "
											//+ "				\"postback\": {\"data\": \"set_by_chatbot_dial_phone_number\"}"
											+ "				}"
											+ "		   }";
	public static final String COORDINATE_TMP = "{\"action\": {"
											+ "				\"mapAction\": {"
											+ "					\"showLocation\": { "
											+ "						\"location\" :{"
											+ "							\"latitude\": 0, \"longitude\": 0, \"label\" :\"\""
											+ "						},"
											+ "						\"fallbackUrl\":\"\""
											+ "					} "
											+ "				},"
											+ "				\"displayText\": \"\""
											//+ "				\"postback\": {\"data\": \"set_by_chatbot_show_location\" }"
											+ "				}"
											+ "		   }";
	public static final String QUERY_TMP = "{\"action\": {"
											+ "				\"mapAction\": {"
											+ "					\"showLocation\": {"
											+ "						\"location\": {"
											+ "							\"query\": \"\""
											+ "						},"
											+ "						\"fallbackUrl\": \"\""
											+ "					}"
											+ "				},"
											+ "				\"displayText\": \"\""
											//+ "				\"postback\": {\"data\": \"set_by_chatbot_search_locations\"}"
											+ "				}"
											+ "		   }";
	public static final String POSITION_TMP = "{\"action\": {"
											+ "					\"mapAction\": {"
											+ "						\"requestLocationPush\": { }"
											+ "					},"
											+ "					\"displayText\": \"\""
											//+ "					\"postback\": {"
											//+ "						\"data\": \"set_by_chatbot_request_location_push\""
											//+ "					}"
											+ "				}"
											+ "		   }";
	public static final String CALENDAR_TMP = "{\"action\": {"
											+ "				\"calendarAction\": {"
											+ "					\"createCalendarEvent\": {"
											+ "						\"startTime\": \"\", "
											+ "						\"endTime\": \"\", "
											+ "						\"title\": \"\",					"
											+ "						\"description\": \"\""
											+ "					}"
											+ "				},"
											+ "				\"displayText\": \"\""
											//+ "				\"postback\": {\"data\": \"set_by_chatbot_calendar_event\" }"
											//+ "				\"postback\": {\"data\": \"set_by_chatbot_create_calendar_event\" }"
											+ "				}"
											+ "		   }";
			
	/**
	 * CONTENT, 버튼 정보, 이미지등 JSON 포맷으로 변경
	 * @param param RcsTemplate
	 * @return
	 * @throws Exception
	 */
	public static RcsTemplate RCSBtnStringToJson(RcsTemplate param) throws Exception{
		
		JSONObject btnJson = new JSONObject(param.getRcsBtnInfo());
		
		JSONArray btnJsonArr = new JSONArray();
		for(int i = 1; i <= 3; i++) {
			
			JSONObject url_json = new JSONObject(URL_TMP);
			JSONObject copy_json = new JSONObject(COPY_TMP);
			JSONObject tel_json = new JSONObject(TEL_TMP);
			JSONObject coordinate_json = new JSONObject(COORDINATE_TMP);
			JSONObject query_json = new JSONObject(QUERY_TMP);
			JSONObject position_json = new JSONObject(POSITION_TMP);
			JSONObject calendar_json = new JSONObject(CALENDAR_TMP);
			
			/* ibk_2022/WebContent/static/v2/js/custom.js 참조
			 * rcsBtnNm_[targetId]1 		ex) rcsBtnNm_rcsTmpltBtn1
			 * rcsBtn_[targetId]index_num	ex) rcsBtn_rcsTmpltBtn1_1 ~ 15
			 */
			String fixedNm = "rcsBtn";
			
			if(btnJson.length() == 0) continue;
			
			Iterator<String> iter = btnJson.keys();
			String targetStr = "_" + iter.next().toString().split("_")[1];
			String targetId = targetStr.substring(0, targetStr.length() - 1) + i;

			if(btnJson.has(fixedNm +"Action" + targetId) == false) continue;
			
			String paramAction = btnJson.getString(fixedNm +"Action" + targetId);
			
			String paramNm = fixedNm + "Nm" + targetId;
			String paramBtnNm = fixedNm + targetId;

			if ("copy".equals(paramAction)) {
				copy_json.getJSONObject("action").getJSONObject("clipboardAction").getJSONObject("copyToClipboard").put("text", btnJson.get(paramBtnNm + "_1"));
				copy_json.getJSONObject("action").put("displayText", btnJson.get(paramNm));
				
				btnJsonArr.put(copy_json);
			} else if ("url".equals(paramAction)) {
				url_json.getJSONObject("action").getJSONObject("urlAction").getJSONObject("openUrl").put("url", btnJson.get(paramBtnNm + "_2"));
				url_json.getJSONObject("action").put("displayText", btnJson.get(paramNm));
				
				btnJsonArr.put(url_json);
			} else if ("tel".equals(paramAction)) { //전화걸기
				tel_json.getJSONObject("action").getJSONObject("dialerAction").getJSONObject("dialPhoneNumber").put("phoneNumber", btnJson.get(paramBtnNm + "_3"));
				tel_json.getJSONObject("action").put("displayText", btnJson.get(paramNm));
				
				btnJsonArr.put(tel_json);
			} else if ("coordinate".equals(paramAction)) {  //지도보여주기(좌표)
				coordinate_json.getJSONObject("action").getJSONObject("mapAction").getJSONObject("showLocation").getJSONObject("location").put("latitude", btnJson.get(paramBtnNm + "_4"));
				coordinate_json.getJSONObject("action").getJSONObject("mapAction").getJSONObject("showLocation").getJSONObject("location").put("longitude", btnJson.get(paramBtnNm + "_5"));
				coordinate_json.getJSONObject("action").getJSONObject("mapAction").getJSONObject("showLocation").getJSONObject("location").put("label", btnJson.get(paramBtnNm + "_6"));
				coordinate_json.getJSONObject("action").getJSONObject("mapAction").getJSONObject("showLocation").put("fallbackUrl", btnJson.get(paramBtnNm + "_7"));
				coordinate_json.getJSONObject("action").put("displayText", btnJson.get(paramNm));
				
				btnJsonArr.put(coordinate_json);
			} else if ("query".equals(paramAction)) { //지도보여주기(쿼리)
				query_json.getJSONObject("action").getJSONObject("mapAction").getJSONObject("showLocation").getJSONObject("location").put("query", btnJson.get(paramBtnNm + "_8"));
				query_json.getJSONObject("action").getJSONObject("mapAction").getJSONObject("showLocation").put("fallbackUrl", btnJson.get(paramBtnNm + "_9"));
				query_json.getJSONObject("action").put("displayText", btnJson.get(paramNm));
				
				btnJsonArr.put(query_json);
			} else if ("position".equals(paramAction)) { //현재위치공유
				position_json.getJSONObject("action").put("displayText", btnJson.get(paramNm));
				
				btnJsonArr.put(position_json);
			} else if ("calendar".equals(paramAction)) { //캘린더등록
				String startTime = (String) btnJson.get(paramBtnNm + "_10");
				String endTime = (String) btnJson.get(paramBtnNm + "_11");
				startTime = dateFormat(startTime, "09");
				endTime = dateFormat(endTime, "09");
				
				calendar_json.getJSONObject("action").getJSONObject("calendarAction").getJSONObject("createCalendarEvent").put("startTime", startTime);
				calendar_json.getJSONObject("action").getJSONObject("calendarAction").getJSONObject("createCalendarEvent").put("endTime", endTime);
				calendar_json.getJSONObject("action").getJSONObject("calendarAction").getJSONObject("createCalendarEvent").put("title", btnJson.get(paramBtnNm + "_12"));
				calendar_json.getJSONObject("action").getJSONObject("calendarAction").getJSONObject("createCalendarEvent").put("description", btnJson.get(paramBtnNm + "_13"));
				calendar_json.getJSONObject("action").put("displayText", btnJson.get(paramNm));
				
				btnJsonArr.put(calendar_json);
			} 
			
		}
		
		//버튼내용 조립
        String formatStr = param.getFormattedString();
        JSONObject formatJson = new JSONObject(formatStr);
        
        if(btnJsonArr.length() > 0 ) {
        	formatJson.getJSONObject("RCSMessage").getJSONObject("openrichcardMessage").put("suggestions", btnJsonArr );
        }

        if(param.getMsgbaseDesc() != null) {
			if(formatJson.getJSONObject("RCSMessage").length() == 0) {
				formatJson.put("RCSMessage", new JSONObject());
				formatJson.getJSONObject("RCSMessage").put("openrichcardMessage", new JSONObject());
			}
		}
        param.setFormattedString( formatJson.toString().replace("\\/", "/"));
		return param;
		
	}

	/**
	 * 일정 등록 버튼 날짜 포맷 설정
	 * @param date
	 * @param gmt
	 * @return
	 * @throws Exception
	 */
	public static String dateFormat(String date, String gmt) throws Exception{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		SimpleDateFormat sdf09 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss+09:00");
		// HH:mm => HH:mm:ss+09:00 
		if (gmt.equals("09")) {
			date = sdf09.format(sdf.parse(date)).replace(" ","T");			
		}
		// HH:mm:ss+09:00 => HH:mm
		else if (gmt.equals("00")) {
			date = date.replace("T", " ");
//						if(checkDate(date)) {
//							date = sdf.format(sdf09.parse(date));
//						}else {
//							date = date+" 00:00";
//						}
		}
		return date;
	}
		
	/**
	 * 일정 등록 버튼 날짜 포맷 설정
	 * @return JSONObject
	 * @exception Exception
	 * */
	 public static void clearJson(JSONObject json) {
	    if (json.length() > 0) {
	        String[] keysArr = new String[json.length()];

	        int counter = 0;
	        for (Iterator<String> iter = json.keys(); iter.hasNext();) {
	        	keysArr[counter++] = iter.next();
	        }

	        for (String key : keysArr) {
	        	json.remove(key);
	        }
	            
	    }
	}
	 
	/**
	 * 알림톡 버튼 저장 포맷 변경
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public static AlimTalkTemplate AlimTalkBtnStringToJson(AlimTalkTemplate param) throws Exception{
		JSONObject btnJson = new JSONObject(param.getBtnInfo());
		
		JSONArray btnJsonArr = new JSONArray();
		for(int i = 1; i <= 5; i++) {
			
			JSONObject json = new JSONObject();
			
			/* ibk_2022/WebContent/static/v2/js/custom.js 참조
			 * rcsBtnNm_[targetId]1 		ex) rcsBtnNm_alimTalkTmpltBtn1
			 * rcsBtn_[targetId]_[index_num]	ex) rcsBtn_alimTalkTmpltBtn1_1 ~ 6
			 */
			String fixedNm = "rcsBtn";
			
			if(btnJson.length() == 0) continue;
			
			Iterator<String> iter = btnJson.keys();
			String targetStr = "_" + iter.next().toString().split("_")[1];
			String targetId = targetStr.substring(0, targetStr.length() - 1) + i;

			if(btnJson.has(fixedNm +"Type" + targetId) == false) continue;
			
			String paramAction = btnJson.getString(fixedNm +"Type" + targetId);
			
			String paramNm = fixedNm + "Nm" + targetId;
			String paramBtnNm = fixedNm + targetId;

			json.put("name", btnJson.get(paramNm));
			json.put("type", paramAction);
			
			if ("WL".equals(paramAction)) {
				addJson( json, "url_mobile", (String) btnJson.get(paramBtnNm + "_1"));
				addJson( json, "url_pc", (String) btnJson.get(paramBtnNm + "_2"));
			} else if ("AL".equals(paramAction)) {
				addJson( json, "url_mobile", (String) btnJson.get(paramBtnNm + "_3"));
				addJson( json, "scheme_android", (String) btnJson.get(paramBtnNm + "_4"));
				addJson( json, "scheme_ios", (String) btnJson.get(paramBtnNm + "_5"));
				addJson( json, "url_pc", (String) btnJson.get(paramBtnNm + "_6"));
			} 
			
			btnJsonArr.put(json);
		}		
	
		// sample 데이터에서 여러개 데이터라도 [] 개념 없어 삭제
        param.setBtnInfo( btnJsonArr.toString().replace("[", "").replace("]", "")); 
		return param;
	}
	
	private static void addJson(JSONObject json, String key, String value) throws JSONException {
		if(value != null && value.length() > 0 ) {
			json.put(key, value);
		}
	}
 

}
