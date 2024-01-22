package com.ibk.msg.web.message;

import java.io.File;
import java.io.StringReader;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.multipart.MultipartFile;

import com.google.common.base.Preconditions;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;
import com.google.gson.stream.JsonReader;
import com.ibk.msg.common.dto.AsisFileDataForm;
import com.ibk.msg.utils.TobeFileHandler;
import com.ibk.msg.web.address.Address;
import com.ibk.msg.web.address.AddressSearchCondition;
import com.ibk.msg.web.address.AddressService;
import com.ibk.msg.web.address.Contact;
import com.ibk.msg.web.message.model.MessageDto;

@Controller
public class MessageController {
	
	private static final Logger logger = LoggerFactory.getLogger(MessageController.class);

	@Autowired
	private MessageService messageService;
	@Autowired
	private AddressService addressService;

	@RequestMapping("/message.ibk")
	public String viewListJsp(HttpSession httpSession, Model model) {
		
		return "generalSend/send-general";
	}
	
	@PostMapping(value = "/message/send", produces = {"application/json"})
	@ResponseBody
	@ResponseStatus(HttpStatus.CREATED)
	public Object send(@RequestBody MessageDto messageDto, HttpSession session) throws Exception {
		if(logger.isInfoEnabled()) logger.info("SMS/MMS_SND_WEB\t" + session.getAttribute("EMPL_ID") + "\t" + messageDto.getSendCount());
		
		Object result = null;
		
		messageDto.setMsgByte(String.valueOf(getMsgSize(messageDto.getMessage())));

		if(logger.isInfoEnabled()) logger.info(" * 메세지크기 : " + messageDto.getMsgByte());
		
		if(Integer.parseInt(messageDto.getMsgByte()) > 88) {
			String title = messageDto.getTitle();
			if(title.equals("") || title == null || title.length() == 0) {
				messageDto.setTitle("제목없음");
			}
			messageDto.setMsgType("mms");
			
			logger.warn("CHANGE SMS => MMS: MsgByte:" + messageDto.getMsgByte());
		} 
		
		result = messageService.sendMsg(session, messageDto);
		
		Hashtable<String, Integer> h = (Hashtable<String, Integer>) result;
        logger.debug("ALL_COUNT"+h.get("ALL_COUNT"));
        logger.debug("SEND_COUNT"+h.get("SEND_COUNT"));
        logger.debug("CUT_COUNT"+h.get("CUT_COUNT"));
        logger.debug("EXCEED_COUNT"+h.get("EXCEED_COUNT"));
        logger.debug("UNIT_DISCORD_COUNT"+h.get("UNIT_DISCORD_COUNT"));
        logger.debug("ETC_COUNT"+h.get("ETC_COUNT"));
        logger.debug("DUP_COUNT"+h.get("DUP_COUNT"));
		
		return result;
	}
	
	
	 //주소록 파일 등록 처리 
	@PostMapping("/message/upload")
	@ResponseBody
	public Object singleFileUpload(@RequestParam("file") MultipartFile uploadFile, HttpSession session) {
		if (uploadFile.isEmpty()) {
			throw new IllegalArgumentException("파일이 비어있습니다.");
		}
		
		Map<String, Object> resMap = new HashMap<>();
		
		try {
			List<AsisFileDataForm> fileList = messageService.handleFile(uploadFile,session,"message");
			
			resMap.put("fileName", uploadFile.getName());
			resMap.put("fileList", fileList);
		} catch (Exception e) {
			resMap.put("errorMsg", e.getMessage());
		}
		

		return resMap;
	}
	
	
	
	
	/**
	 * 주소록에 저장 버튼 이벤트 
	 * 
	 * @param param
	 * @param session
	 * @return 
	 * @throws Exception
	 */
	@PostMapping(value = "/message/address/{type}", produces = {"application/json"})
	@ResponseBody
	@ResponseStatus(HttpStatus.CREATED)
	public Object addGroupAddress(@PathVariable("type") String type, @RequestBody Map<String, Object> param, HttpSession session) throws Exception {
		if(logger.isInfoEnabled()) logger.info("PERSONAL SEND  ADDRESS ADD \tEMPL_ID=" + session.getAttribute("EMPL_ID") + "\tTYPE=" + type + "\tDATA=" + param.toString());
		
		String grpSeq = "";
		
		if(type.equals("groupList")){ // 등록 가능한 리스트 조회
			AddressSearchCondition addressSC= new AddressSearchCondition();
			setAddressBySession(session, addressSC);
			addressSC.setAddressType(param.get("addressType").toString());

			return addressService.findAddress(addressSC);
		}else if(type.equals("addNewGroup")){ //새로운 그룹에 추가
			Address address = new Address();
			setAddressBySession(session, address);
			address.setGroupName(param.get("groupName").toString());
			address.setGroupNote(param.get("groupNote").toString());
			address.setGroupShareYn(param.get("groupShareYn").toString());
			
			grpSeq = String.valueOf((int) addressService.add(address));
		}else if(type.equals("addExistGroup")){ // 기존 그룹에 추가
			grpSeq = param.get("grpSeq").toString();
		}

		// 연락처 추가 
		String contactList = param.get("contactList").toString();

		for(String contact : contactList.split(",")){
			String[] splitContact = contact.split(":"); // [0] NAME, [1] PHONE
			 
			Contact addContact = new Contact();
			setAddressBySession(session, addContact);
			addContact.setFirstName(splitContact[0]);
			addContact.setMobile(splitContact[1]);
			addContact.setGrpSeq(grpSeq);
			
			addressService.insertContact(addContact);
		}
		
		return grpSeq;
	}
	
	
	
	@RequestMapping("/filesend.ibk")
	public String viewFileSendJsp(HttpSession httpSession, Model model) {
		
		return "massfile-send/massfile-upload";
	}
	
	@PostMapping("/message/filesendupload")
	@ResponseBody
	public Object fileSendUpload(@RequestParam("file") MultipartFile uploadFile,HttpSession httpSession) {

	      if (uploadFile.isEmpty()||uploadFile.getSize()==0) {
	    	  throw new IllegalArgumentException("파일이 비어있습니다.");
	      }
	      
	        Map<String, Object> resMap = new HashMap<>();
			List<AsisFileDataForm> fileList;
			try {
				fileList = messageService.handleFile(uploadFile,httpSession,"bulk");
				resMap.put("fileName", uploadFile.getName());
				resMap.put("fileList", fileList);
				
			} catch (Exception e) {
				resMap.put("errorMsg", e.getMessage());
			}
			
			return resMap;
	}
	
	@PostMapping(value = "/message/filesendrequest" ,  produces = {"application/json"})
	@ResponseBody
	public Object fileSendRequest(@RequestBody Map<String, Object> param, HttpSession session) throws Exception {
/*		//리스트의 마지막 AsisFileDataForm 객체의 fax==callbacknumber, email==sendRequestDate 
		String sendDate=fileList.get(fileList.size()-1).getEmail();
		String callback=fileList.get(fileList.size()-1).getFax();
		if(sendDate==null||callback==null)return null;  
		fileList.remove(fileList.size()-1);*/
		String sendDate=param.get("sendDate").toString();
		String callback=param.get("callback").toString();
		Gson gson = new Gson();
		JsonObject res = gson.toJsonTree(param).getAsJsonObject();
		List<AsisFileDataForm> fileList=gson.fromJson( res.get("fileList").toString() , new TypeToken< List<AsisFileDataForm>>(){}.getType() );
		return messageService.sendBulkMsg(session,fileList,sendDate,callback,"bulk");
	}
	@RequestMapping("/message/download/sample/{type}")//bulk  message
	public void downloadBulkSampleFile(@PathVariable("type") String type, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String appPath = request.getServletContext().getRealPath("");
        String filePath="download/sms_bulk_sample.xls";
        if(type.equalsIgnoreCase("message")) {
        	filePath="download/message_sample.xls";
        }
        File downloadFile=new File(appPath+filePath);
        if(!downloadFile.exists()) {
        	throw new IllegalArgumentException("download file is empty");
        }
        TobeFileHandler.downloadFile(downloadFile, request, response);
	}
	@RequestMapping("/emplsms/emplsend.ibk")
	public String viewEmplSendJsp(HttpSession httpSession, Model model) {
		
		return "employee-send/employeefile-upload";
	}
	
	@PostMapping("/message/emplsendupload")
	@ResponseBody
	public Object emplSendUpload(@RequestParam("file") MultipartFile uploadFile,HttpSession httpSession) {

	      if (uploadFile.isEmpty()||uploadFile.getSize()==0) {
	    	  throw new IllegalArgumentException("파일이 비어있습니다.");
	      }
	      
	      	Map<String, Object> resMap = new HashMap<>();
			List<AsisFileDataForm> fileList;
			try {
				fileList = messageService.handleFile(uploadFile,httpSession,"empnotice");
				resMap.put("fileName", uploadFile.getName());
				resMap.put("fileList", fileList);
			} catch (Exception e) {
				resMap.put("errorMsg", e.getMessage());
			}
			
			return resMap;
	}
	
	@PostMapping(value = "/message/emplsendrequest" ,  produces = {"application/json"})
	@ResponseBody
	public Object emplSendRequest(@RequestBody Map<String, Object> param, HttpSession session) throws Exception {
//		String sendDate=fileList.get(fileList.size()-1).getEmail();
//		String callback=fileList.get(fileList.size()-1).getFax();
//		if(sendDate==null||callback==null)return null;
//		fileList.remove(fileList.size()-1);
		
		String sendDate=param.get("sendDate").toString();
		String callback=param.get("callback").toString();
		Gson gson = new Gson();
		JsonObject res = gson.toJsonTree(param).getAsJsonObject();
		
		List<AsisFileDataForm> fileList=gson.fromJson( res.get("fileList").toString() , new TypeToken< List<AsisFileDataForm>>(){}.getType() );
		return messageService.sendBulkMsg(session,fileList,sendDate,callback,"empnotice");
	}
	
	public static int getMsgSize(String msg) throws UnsupportedEncodingException {
		return msg.getBytes("euc-kr").length;
	}
	
	
	
	private void setAddressBySession(HttpSession session,Object obj) {
		if(obj instanceof Address)
		{
			Address changObj = (Address) obj;
			if(session.getAttribute("EMPL_ID") ==null) {
				Preconditions.checkArgument(false, "session empl_id is empty");  
			}else {
				changObj.setEmplId((String)session.getAttribute("EMPL_ID")); 
			}
			
			if(session.getAttribute("EMPL_BOCODE")==null) {
				  //Preconditions.checkArgument(false, "session empl_bocode is empty");
			}else {
				changObj.setBoCode((String)session.getAttribute("EMPL_BOCODE"));
			} 
		} else if(obj instanceof AddressSearchCondition)
		{
			AddressSearchCondition changObj = (AddressSearchCondition) obj;
			if(session.getAttribute("EMPL_ID") ==null) {
				Preconditions.checkArgument(false, "session empl_id is empty");  
			}else {
				changObj.setEmplId((String)session.getAttribute("EMPL_ID")); 
			}
			
			if(session.getAttribute("EMPL_BOCODE")==null) {
				  //Preconditions.checkArgument(false, "session empl_bocode is empty");
			}else {
				changObj.setBoCode((String)session.getAttribute("EMPL_BOCODE"));
			} 
		} else if(obj instanceof Contact)
		{
			Contact changObj = (Contact) obj;
			if(session.getAttribute("EMPL_ID") ==null) {
				Preconditions.checkArgument(false, "session empl_id is empty");  
			}else {
				changObj.setEmplId((String)session.getAttribute("EMPL_ID")); 
			}
		}
	}
}
