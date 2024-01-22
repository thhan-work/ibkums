package com.ibk.msg.web.address;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.common.base.Preconditions;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.ibk.msg.utils.ExcelDef;
import com.ibk.msg.utils.ExcelExportUtil;
import com.ibk.msg.utils.ExcelSheetDef;
import com.ibk.msg.utils.TobeFileHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AddressController {

	@Autowired
	private AddressService addressService;
	//주소록 메인 화면 보기 ==전체 주소록 보기 메인
	@GetMapping("/all-address.ibk")
	public String viewMainListJsp(Model model) {
		model.addAttribute("addressType", "group");
		model.addAttribute("title", "전체주소록");
		return "address/address-list";
	}
	@GetMapping("/personal-address.ibk")
	public String viewPersonalJsp(Model model) {
		model.addAttribute("addressType", "personal");
		model.addAttribute("title", "개인주소록");
		return "address/address-list";
	}
	@GetMapping("/share-address.ibk")
	public String viewShareJsp(Model model) {
		model.addAttribute("addressType", "share");
		model.addAttribute("title", "부서공유주소록");
		return "address/address-list";
	}

	//주소록 파일 등록 화면 보기
	@GetMapping("/upload-address.ibk")
	public String viewUploadJsp(Model model) {
		model.addAttribute("title", "주소록 파일 등록");
		return "address/address-upload";
	}

	//주소록 리스트 보기
	@GetMapping("/addressType/{addressType}")
	@ResponseBody
	public Object findAddressByPagination(AddressSearchCondition searchCondition,HttpSession httpSession, 
			@PathVariable("addressType") String addressType) throws Exception {

		setSearchConditionBySession(httpSession,searchCondition);
		searchCondition.setAddressType(addressType);

		return addressService.findByPagination(searchCondition);
	}

	//주소록 등록
	@PostMapping(value = "/address", produces = {"application/json"})
	@ResponseBody
	@ResponseStatus(HttpStatus.CREATED)
	public Object add(@RequestBody Address address, HttpSession session) throws Exception {
		setAddressBySession(session,address);
		return addressService.add(address);
	}
	//주소록 수정
	@PutMapping(value = "/address", produces = {"application/json"})
	@ResponseBody
	@ResponseStatus(HttpStatus.OK)
	public Object addressModify(@RequestBody Address address, HttpSession session) throws Exception {
		setAddressBySession(session, address);

		return addressService.addressModify(address);
	}
	//주소록 삭제
	@DeleteMapping(value = "/address",  produces = {"application/json"})
	@ResponseBody
	public Object addressDel(@RequestBody List<Address> addressList,HttpSession session) throws Exception {

		return addressService.delete(addressList,getEmplId(session));
	}

	//주소록 연락처 목록 화면보기 ==연락처 목록 메인화면
	@GetMapping("/contact-list.ibk")
	public String viewContactListJsp(AddressSearchCondition searchCondition,HttpSession httpSession, Model model) throws Exception{
		String emplId=searchCondition.getEmplId();
		setSearchConditionBySession(httpSession,searchCondition);
		//주소록 보기 요청자가 주소록 소유자와 일치 한지 확인-- 그룹 이동 셀렉트 박스에 노출 시킬 목록 추출
		if(emplId.equals(searchCondition.getEmplId())) {
			searchCondition.setAddressType("personal");
		}else {
			if(searchCondition.getBoCode().trim().equals("")||searchCondition.getBoCode()==null) {
				Preconditions.checkArgument(false, "boCode is empty");
			}
			searchCondition.setEmplId(emplId);
			searchCondition.setAddressType("share");
		}
		Address address=addressService.getGroupInfo(searchCondition);
		List<Address> addressList=addressService.findAddress(searchCondition);
		model.addAttribute("address",address);
		model.addAttribute("addressList",addressList);
		return "address/contact-list";
	}

	//주소록 연락처 리스트 보기
	@GetMapping("/contactType/contactsList")
	@ResponseBody
	public Object findContactByPagination(AddressSearchCondition searchCondition,HttpSession httpSession) throws Exception {
		return addressService.findContactByPagination(searchCondition);
	}

	// 연락처 등록 및 수정 상세 페이지를 같이 사용 합니다.
	@GetMapping("/contact-detail.ibk")
	public ModelAndView viewDetailAddress(
			@RequestParam(value = "type", required = true) String type, Contact contact, HttpSession httpSession) throws Exception {
		ModelAndView mav = new ModelAndView();
		AddressSearchCondition searchCondition=new AddressSearchCondition();
		String emplId=contact.getEmplId();
		String grpSeq=contact.getGrpSeq();
		setSearchConditionBySession(httpSession, searchCondition);
		if(emplId.equals(searchCondition.getEmplId())) {
			searchCondition.setAddressType("group");
		}else {
			searchCondition.setAddressType("add");
		}
		searchCondition.setEmplId(emplId);
		searchCondition.setGrpSeq(grpSeq);
		if(type.equalsIgnoreCase("form")){
			mav.addObject("title", "주소록 추가");
			mav.addObject("type","add" );
			mav.addObject("contact",contact );
		}else if(type.equalsIgnoreCase("modForm")){
			mav.addObject("title", "주소록 수정");
			mav.addObject("type","mod" );
			Contact rContact=addressService.getContactItem(contact);
			rContact.setGrpSeq(grpSeq);
			mav.addObject("contact",rContact);
		}    
		mav.addObject("addressList",addressService.findAddress(searchCondition));
		mav.setViewName("address/contact-detail");
		return mav;
	}
	//주소록 그룹 연락처 추가 처리(상세페이지에서 추가)
	
	
	//주소록 그룹 연락처 추가 처리(상세페이지에서 추가)
	@PostMapping(value = "/contact")
	public Object contactAdd(Contact contact) throws Exception {
		addressService.insertContact(contact);
		return "redirect:/contact-list.ibk?emplId="+contact.getEmplId()+"&grpSeq="+contact.getGrpSeq();
	}
	//주소록 그룹 연락처 수정 처리(상세페이지에서 수정)
	@PostMapping(value = "/contactModify")
	public Object contactModify(Contact contact) throws Exception {
		addressService.updateContact(contact);
		return "redirect:/contact-list.ibk?emplId="+contact.getEmplId()+"&grpSeq="+contact.getGrpSeq();
	}
	
	//주소록 그룹 연락처 추가 처리(상세페이지에서 추가)
	@PostMapping(value = "/contacta", produces = {"application/json"})
	@ResponseBody
	@ResponseStatus(HttpStatus.CREATED)
	public Object contactAdda(@RequestBody Contact contact, HttpSession session) throws Exception {
		log.info("Contact : {}", contact);
		int insertContact = addressService.insertContact(contact);
		Map<String, Object> retMap = new HashMap<String, Object>();
		retMap.put("cnt", insertContact);
		return retMap;
	}
	
	@PostMapping(value = "/getContact", produces = {"application/json"})
	@ResponseBody
	public Object getContact(@RequestBody Contact contact, HttpSession session) throws Exception {
		Contact rContact=addressService.getContactItem(contact);
		return rContact;
	}
	
	//주소록 그룹 연락처 수정 처리(상세페이지에서 수정)
	@PostMapping(value = "/contactModifya", produces = {"application/json"})
	@ResponseBody
	public Object contactModifya(@RequestBody Contact contact, HttpSession session) throws Exception {
		log.info("Contact {}", contact);
		int updateContact = addressService.updateContact(contact);
		Map<String, Object> retMap = new HashMap<String, Object>();
		retMap.put("cnt", updateContact);
		return retMap;
	}
	
	//연락처 그룹 이동
	@PutMapping(value = "/contacts/{targetGrpSeq}", produces = {"application/json"})
	@ResponseBody
	@ResponseStatus(HttpStatus.OK)
	public Object contactMove(@RequestBody List<Contact> contactList,@PathVariable("targetGrpSeq") int targetGrpSeq) throws Exception {
		return addressService.contactMove(contactList,targetGrpSeq);
	}
	//연락처 삭제
	@DeleteMapping(value = "/contact",  produces = {"application/json"})
	@ResponseBody
	public Object contactDel(@RequestBody List<Contact> contactList) throws Exception {

		return addressService.deleteContact(contactList);
	}


	//일반보내기 주소록 그룹 호출
	@GetMapping("/addressCall/{addressType}")
	@ResponseBody
	public Object callAddress(AddressSearchCondition searchCondition,HttpSession httpSession, 
			@PathVariable("addressType") String addressType) throws Exception {

		setSearchConditionBySession(httpSession,searchCondition);
		searchCondition.setAddressType(addressType);
		AddressCallResponse response=new AddressCallResponse();
		if (addressType.equals("personal")) {
			List<Address> personalGroupList = addressService.callAddress(searchCondition);
			response.personalGroupList=personalGroupList;
			// 공유주소록
			if(searchCondition.getEmplId() != null) {
				searchCondition.setAddressType("share");
				List<Address> shareGroupList = addressService.callAddress(searchCondition);
				response.shareGroupList=shareGroupList;
			}

			// 부서주소록
		} else if (addressType.equals("share")) {
			List<Address> partList =addressService.getPartList();	
			response.partList=partList;
		}
		response.addrType=addressType;
		return response;
	}

	//일반보내기 주소록 개인-부서-특정 연락처 호출
	@GetMapping("/addressCall/{emplId}/{groupType}")///addressCall/{boCode}/{groupType} 호환
	@ResponseBody
	public Object callAllContact(AddressSearchCondition searchCondition,HttpSession httpSession, 
			@PathVariable("emplId") String emplId,@PathVariable("groupType") String groupType) throws Exception {
		setSearchConditionBySession(httpSession,searchCondition);

		if(groupType.equals("pdef")){//개인 전체 주소록
			searchCondition.setAddressType("personal");
			searchCondition.setEmplId(emplId);
		}else if(groupType.equals("gdef")){//부서 공유 전체 주소록
			searchCondition.setAddressType("share");
			
		}else if(groupType.equals("ddef")) {//특정부서 주소록  emplId==boCode
			searchCondition.setAddressType("part");
			searchCondition.setBoCode(emplId);
		}else{//특정 주소록--개인 주소록과 동일하나 그룹시퀀스  null 여부로 갈림
			searchCondition.setGrpSeq(groupType);	
			searchCondition.setEmplId(emplId);
			searchCondition.setAddressType("personal");
		}

		return addressService.getContactList(searchCondition);
	}



	//주소록 파일 등록 처리 
	@PostMapping("/upload") // //new annotation since 4.3
	@ResponseBody
	public Object singleFileUpload(@RequestParam("file") MultipartFile uploadFile,HttpSession httpSession) {

		if (uploadFile.isEmpty()||uploadFile.getSize()==0) {
			throw new IllegalArgumentException("upload file is empty");
			//return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		// List<Contact> contactList=addressService.handleFile(uploadFile,httpSession);
		return addressService.handleFile(uploadFile,httpSession);
	}
	//주소록 파일 등록 연락처 등록 처리  @PostMapping(value = "/message/address/{type}", produces = {"application/json"})
	@PostMapping(value = "/upload/{type}", produces = {"application/json"}) // //new annotation since 4.3
	@ResponseBody
	@ResponseStatus(HttpStatus.CREATED)
	public Object addContactByFile(@PathVariable("type") String type, @RequestBody Map<String, Object> param,HttpSession httpSession) {
		String grpSeq = "";
		String emplId=getEmplId(httpSession);
		if(type.equals("addNewGroup")){ //새로운 그룹에 추가
			Address address = new Address();
			setAddressBySession(httpSession, address);
			address.setGroupName(param.get("groupName").toString());
			address.setGroupNote(param.get("groupNote").toString());
			address.setGroupShareYn(param.get("groupShareYn").toString());

			grpSeq = String.valueOf((int) addressService.add(address));
		}else if(type.equals("addExistGroup")){ // 기존 그룹에 추가
			grpSeq = param.get("grpSeq").toString();
		}
		Gson gson = new Gson();
		List<Contact> contactList=gson.fromJson( param.get("contactlist").toString() , new TypeToken<ArrayList<Contact>>(){}.getType() );

		return addressService.getContactListFromTemp(contactList,emplId,grpSeq) ;
	}
	@RequestMapping("/address/download/sample/contact")//message/download/bulksample
	public void downloadBulkSampleFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//new File(filePath + System.getProperty("file.separator") +uqiuName+"."+fileExt);

		String appPath = request.getServletContext().getRealPath("");
		String filePath="download/sms_general_sample.xls";
		File downloadFile=new File(appPath+filePath);
		if(!downloadFile.exists()) {
			throw new IllegalArgumentException("download file is empty");
		}
		TobeFileHandler.downloadFile(downloadFile, request, response);
	}
	@RequestMapping("/address/download/sample/manual")//message/download/bulksample
	public void downloadManualFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//new File(filePath + System.getProperty("file.separator") +uqiuName+"."+fileExt);

		String appPath = request.getServletContext().getRealPath("");
		String filePath="download/MSCENTER_MANUALv1.0.pdf";
		File downloadFile=new File(appPath+filePath);
		if(!downloadFile.exists()) {
			throw new IllegalArgumentException("download file is empty");
		}
		TobeFileHandler.downloadFile2(downloadFile, request, response);
	}

	@RequestMapping("/contact-list-download.ibk")
	public void findChannelByExcel(HttpServletRequest request, AddressSearchCondition searchCondition, HttpServletResponse response) throws Throwable {
		Address groupInfo = addressService.getGroupInfo(searchCondition);
		List<Map<Object, Object>> contactList = addressService.findContact(searchCondition);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd HHmmss");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HHmmss");

		String fileName = groupInfo.getGroupName() + " ("+ sdf.format(new Date()) + ").xls";
		String sheetName = groupInfo.getGroupName() + " ("+sdf2.format(new Date())+")";

		String[] dataString = new String[] {"FIRST_NAME", "MOBILE", "E_MAIL1", "HOME_FAX", "DEPARTMENT"};

		ExcelDef excelDef = new ExcelDef();
		excelDef.setFileName(fileName);

		ExcelSheetDef excelSheetDef = new ExcelSheetDef();
		excelSheetDef.setLeftMargin(0);
		excelSheetDef.setTopMargin(0);
		excelSheetDef.convertMapDataToCellListAndAdd(sheetName, null, null, dataString, contactList);

		excelDef.addSheet(excelSheetDef);

		ExcelExportUtil.exportExcel(request, response, excelDef);
	}
	/*  // 등록 수정 상세 페이지를 같이 사용 합니다.
  @GetMapping("/address-detail.ibk")
  public ModelAndView viewDetailJsp(
      @RequestParam(value = "id", required = false) String addressId) {
    ModelAndView mav = new ModelAndView();
    if (StringUtils.isNotBlank(addressId)) {
      Address address = addressService.findDetail(addressId);
      mav.addObject("address", address);
      mav.addObject("viewType", "modify");

    }
    mav.addObject("title", "주소록 추가");
    mav.setViewName("address/address-detail");
    return mav;
  }
  @GetMapping("/addressNotice/{addressId}/")
  @ResponseBody
  public Object findDetail(@PathVariable("addressId") String addressId) throws Exception {
    return addressService.findDetail(addressId);
  }*/

	/*  @PutMapping(value = "/address/{addressId}", produces = {"application/json"})
  @ResponseBody
  @ResponseStatus(HttpStatus.OK)
  public Object modify(@PathVariable("addressId") int addressId
      , @RequestBody Address address, HttpSession session) throws Exception {
    address.setWriter(getWriter(session));
    address.setId(addressId);
    return addressService.modify(address);
  }*/

	/*  @DeleteMapping("/address/{id}")
  @ResponseBody
  public Object remove(@PathVariable("id") int[] addressIdArr) throws Exception {
    return addressService.remove(addressIdArr);
  }*/

	private String getEmplId(HttpSession session) {
		String empl_id="";
		if(session.getAttribute("EMPL_ID") ==null) {
			Preconditions.checkArgument(false, "session empl_id is empty");  
		}else {
			empl_id=(String) session.getAttribute("EMPL_ID");
		}

		return empl_id;
	}

	private void setSearchConditionBySession(HttpSession session,AddressSearchCondition searchCondition) {
		if(session.getAttribute("EMPL_ID") ==null) {
			Preconditions.checkArgument(false, "session empl_id is empty");  
		}else {
			searchCondition.setEmplId((String)session.getAttribute("EMPL_ID")); 
		}

		if(session.getAttribute("EMPL_BOCODE")==null) {
			//Preconditions.checkArgument(false, "session empl_bocode is empty");
		}else {
			searchCondition.setBoCode((String)session.getAttribute("EMPL_BOCODE"));
		} 
	}

	private void setAddressBySession(HttpSession session,Address address) {
		if(session.getAttribute("EMPL_ID") ==null) {
			Preconditions.checkArgument(false, "session empl_id is empty");  
		}else {
			address.setEmplId((String)session.getAttribute("EMPL_ID")); 
		}

		if(session.getAttribute("EMPL_BOCODE")==null) {
			//Preconditions.checkArgument(false, "session empl_bocode is empty");
		}else {
			address.setBoCode((String)session.getAttribute("EMPL_BOCODE"));
		} 
	}

	//일반보내기 주소록 개인-부서-특정 연락처 호출
	@GetMapping("/addressCallForAuthGrant/{emplId}/{groupType}")///addressCall/{boCode}/{groupType} 호환
	@ResponseBody
	public Object callAllContactForAuthGrant(AddressSearchCondition searchCondition,HttpSession httpSession, 
			@PathVariable("emplId") String emplId,@PathVariable("groupType") String groupType) throws Exception {
		setSearchConditionBySession(httpSession,searchCondition);

		if(groupType.equals("pdef")){//개인 전체 주소록
			searchCondition.setAddressType("personal");
			searchCondition.setEmplId(emplId);
		}else if(groupType.equals("gdef")){//부서 공유 전체 주소록
			searchCondition.setAddressType("share");
			
		}else if(groupType.equals("ddef")) {//특정부서 주소록  emplId==boCode
			searchCondition.setAddressType("part");
			searchCondition.setBoCode(emplId);
		}else{//특정 주소록--개인 주소록과 동일하나 그룹시퀀스  null 여부로 갈림
			searchCondition.setGrpSeq(groupType);	
			searchCondition.setEmplId(emplId);
			searchCondition.setAddressType("personal");
		}

		return addressService.getContactListForAuthGrant(searchCondition);
	}

}
