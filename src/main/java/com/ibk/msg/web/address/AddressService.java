package com.ibk.msg.web.address;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.google.common.base.Preconditions;
import com.ibk.msg.common.dto.AsisFileDataForm;
import com.ibk.msg.common.dto.PaginationResponse;
import com.ibk.msg.utils.AsisFileHandler;
import com.ibk.msg.web.loglist.LogListDao;

@Component
public class AddressService {

	@Autowired
	private AddressDao dao;

	@Autowired
	private LogListDao logDao;

	//주소록 목록 조회
	public PaginationResponse findByPagination(AddressSearchCondition searchCondition)
			throws Exception {

		Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
		Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");

		int totalCount = dao.findTotalCount(searchCondition);
		List<Address> address = dao.findAddress(searchCondition);
		return new PaginationResponse(searchCondition, totalCount, address);
	}
	//주소록 목록 조회 -페이징 없음
	public List<Address> findAddress(AddressSearchCondition searchCondition) throws Exception {
		return dao.findAddress(searchCondition);
	}
	//주소록 추가
	public Object add(Address address) { 
		Preconditions.checkArgument(StringUtils.isNoneBlank(address.getGroupName()), "group name is empty");
		Preconditions.checkArgument(StringUtils.isNoneBlank(address.getGroupNote()), "group note is empty");
		Preconditions.checkArgument(StringUtils.isNoneBlank(address.getEmplId()), "writer id is empty");
		Preconditions.checkArgument(StringUtils.isNoneBlank(address.getBoCode()), "writer part code is empty");

		int maxSeq = dao.findGroupMaxSequnce(address.getEmplId());
		address.setGrpSeq(String.valueOf(maxSeq)); 

		Preconditions.checkArgument(StringUtils.isNoneBlank(address.getGrpSeq()), "group SEQ is empty");
		dao.add(address);
		return maxSeq;
	}

	//주소록 수정
	public Object addressModify(Address address) {
		Preconditions.checkArgument(StringUtils.isNoneBlank(address.getEmplId()), "empl_id is empty");
		Preconditions.checkArgument(StringUtils.isNoneBlank(address.getGrpSeq()), "grpSeq is empty");
		Preconditions.checkArgument(StringUtils.isNoneBlank(address.getGroupName()), "group name is empty");
		Preconditions.checkArgument(StringUtils.isNoneBlank(address.getGroupNote()), "group note is empty");
		Preconditions.checkArgument(StringUtils.isNoneBlank(address.getGroupShareYn()), "group shareYN is empty");
		int count=dao.addressModify(address);
		return count;
	}

	//주소록 삭제 
	//emple_id 일치 즉 자신것이면 삭제, 
	//그렇지 않으면 공유여부 0으로 셋팅
	// XgroupContact, XContact, Xgroup 세가지 테이블 데이터 지워야함
	//deleteXgroupContact deleteContactInGroup deleteXgroup
	public int delete(List<Address> addressList,String user_id) {
		int tot=0;
		for(Address address:addressList) {
			//넘겨 받은 주소록 소유자와 현 유저와 같으면 XgroupContact, XContact, Xgroup 데이터 삭제
			Preconditions.checkArgument(StringUtils.isNoneBlank(address.getEmplId()), "empl_id is empty");
			Preconditions.checkArgument(StringUtils.isNoneBlank(address.getGrpSeq()), "grpSeq is empty");
			int count=0;
			if(address.getEmplId().equals(user_id)) {
				count+=dao.deleteGroupContact(address);
				count+=dao.deleteContactInGroup(address);
				count+=dao.deleteGroup(address);
			}else {//넘겨 받은 주소록 소유자와 현 유저와 같지 않으면 
				address.setGroupShareYn("0");
				count+=dao.addressModify(address);
			}
			tot+=count;
			count=0;
		}
		return tot;
	}
	//주소록 그룹 정보 단건
	public Address getGroupInfo(AddressSearchCondition searchCondition){
		return dao.getGroupInfo(searchCondition);
	}
	//주소록 특정연락처 페이징 조회
	public PaginationResponse findContactByPagination(AddressSearchCondition searchCondition)
			throws Exception {

		Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
		Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");

		int totalCount = dao.getContactCount(searchCondition);
		List<Contact> contactList = dao.getContactList(searchCondition);
		return new PaginationResponse(searchCondition, totalCount, contactList);
	}

	public List<Map<Object, Object>> findContact(AddressSearchCondition searchCondition)
			throws Exception {
		List<Map<Object, Object>> contactList = dao.getContactListHash(searchCondition);
		return contactList;
	}

	//주소록 연락처 정보 가져오기
	public Contact getContactItem(Contact contact){
		return dao.getContactItem(contact);
	}
	//주소록 연락처 추가 하기(연락처-그룹 관계 추가 포함)
	public int insertContact(Contact contact) {
		String catSeq=String.valueOf(dao.getContactMaxSeqCnt(contact));
		contact.setCatSeq(catSeq);
		int i=dao.insertContact(contact);
		i=dao.insertGroupContact(contact);
		return i;
	}
	public int updateContact(Contact contact) {

		int i=dao.updateContact(contact);

		return i;
	}
	//주소록 연락처 그룹 이동--미구현
	public int contactMove(List<Contact> contactList,int targetGrpSeq) {
		int tot=0;

		for(Contact contact:contactList) {
			contact.setTargetGrpSeq(targetGrpSeq);
			tot+=dao.moveContact(contact);
		}
		return  tot;
	}
	//주소록 연락처 삭제
	public int deleteContact(List<Contact> contactList) {
		int tot=0;
		String empl_id="";
		for(Contact contact:contactList) {
			//넘겨 받은 주소록 소유자와 현 유저와 같으면 XgroupContact, XContact, Xgroup 데이터 삭제
			Preconditions.checkArgument(StringUtils.isNoneBlank(contact.getEmplId()), "empl_id is empty");
			Preconditions.checkArgument(StringUtils.isNoneBlank(contact.getGrpSeq()), "grpSeq is empty");
			Preconditions.checkArgument(StringUtils.isNoneBlank(contact.getCatSeq()), "catSeq is empty");
			int count=0;
			count+=dao.deleteContact(contact);			
			count+=dao.deleteGroupContact(contact);
			tot+=count;
			count=0;
			empl_id=contact.getEmplId();
		}
		HashMap<String, String> pram = new HashMap<String, String>();
		pram.put("emplId", empl_id);
		pram.put("category", "삭제");
		pram.put("menu", "주소록");
		pram.put("content", "연락처"+tot+"건 삭제");
		//	  logDao.recordLog(pram);
		return tot;
	}

	//일반보내기 주소록 그룹 호출
	public List<Address> callAddress(AddressSearchCondition searchCondition) throws Exception {
		return dao.callAddress(searchCondition);
	}
	//일반보내기 부서 리스트 호출
	public List<Address> getPartList() {
		return dao.getPartList();
	}
	//일반보내기 주소록 개인-부서 연락처 호출
	public List<Contact> getContactList(AddressSearchCondition searchCondition) throws Exception {
		List<Contact> contactList=null;
		if(searchCondition.getAddressType().equals("personal")) {
			contactList = dao.getContactList(searchCondition);
		}else if(searchCondition.getAddressType().equals("part")){  //일반보내기 특정부서 연락처 호출
			if(searchCondition.getSearchWordType()!=null&&!searchCondition.getSearchWordType().equals("")) {
				Preconditions.checkArgument(StringUtils.isNoneBlank(searchCondition.getBoCode()), "boCode is empty");  
			}
			contactList = dao.getPartAddressList(searchCondition);
		}else {
			contactList = dao.getGroupContactList(searchCondition);
		}
		return contactList;
	}
	//주소록 파일 등록 -파일 처리
	public Object handleFile(MultipartFile uploadFile,HttpSession httpSession) {

		List<AsisFileDataForm> fileList=AsisFileHandler.hadleFile(uploadFile, httpSession, "addr");
		if(fileList ==null||fileList.size()==0) return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

		List<Contact> contactList=new ArrayList<Contact>(fileList.size());
		Contact contact=null;
		for(AsisFileDataForm form:fileList) {
			//dao.insertAddressFileInfo(form);
			contact=new Contact();
			contact.setCatSeq(form.getUniquekey());
			contact.setFirstName(form.getName());
			contact.setMobile(form.getMobile());
			contact.seteMail1(form.getEmail());
			contact.setHomeFax(form.getFax());
			contact.setDepartment(form.getDepartment());
			contactList.add(contact);
		}
		return contactList;
	}
	//주소록 파일 등록 임시 테이블 연락처 정보 가져오기
	public Contact getContactListFromTemp(List<Contact> contactList,String emplId,String grpSeq ){
		//List<Contact> contactList=dao.getFileDataList(uniqueKey);

		for(Contact contact : contactList){
			contact.setEmplId(emplId);
			contact.setGrpSeq(grpSeq);
			insertContact(contact);
		}
		return contactList.get(0);
	}

	//일반보내기 주소록 개인-부서 연락처 호출
	public List<Contact> getContactListForAuthGrant(AddressSearchCondition searchCondition) throws Exception {
		List<Contact> contactList=null;
		
		if(searchCondition.getSearchWordType()!=null&&!searchCondition.getSearchWordType().equals("")) {
			Preconditions.checkArgument(StringUtils.isNoneBlank(searchCondition.getBoCode()), "boCode is empty");  
		}
		contactList = dao.getPartAddressListForAuthGrant(searchCondition);
		
		return contactList;
	}

}
