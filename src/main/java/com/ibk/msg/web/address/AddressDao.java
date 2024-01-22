package com.ibk.msg.web.address;

import java.util.List;
import java.util.Map;

import com.ibk.msg.common.dto.AsisFileDataForm;
import com.ibk.msg.config.database.IbkRepository;

@IbkRepository
public interface AddressDao {

  //주소록 리스트 -페이징 
  int findTotalCount(AddressSearchCondition searchCondition);
  List<Address> findAddress(AddressSearchCondition searchCondition);
  //연락처 리스트-페이징
  int getContactCount(AddressSearchCondition searchCondition);
  
  List<Map<Object, Object>> getContactListHash(AddressSearchCondition searchCondition);
  
  void remove(int noticeId);
  int findMaxSequnce();
  
  //주소록 그룹추가 맥스 시퀀스 채번
  int findGroupMaxSequnce(String idDomain);
 //주소록 그룹추가
  void add(Address address);
 //주소록 그룹수정
  int addressModify(Address address);
 //주소록 연락처 관계 삭제
  int deleteGroupContact(Address address);
 //연락처 삭제
  int deleteContactInGroup(Address address);
 //주소록 삭제
  int deleteGroup(Address address);
 //주소록 그룹 정보 단건
  Address getGroupInfo(AddressSearchCondition searchCondition);
  //주소록 연락처 목록 연락처 단건 정보
  Contact getContactItem(Contact contact);
  //주소록 연락처 목록 연락처 추가를 위한 Max catSeq 채번
  int getContactMaxSeqCnt(Contact contact);
  //주소록 연락처 목록 연락처 추가-상세페이지
  int insertContact(Contact contact);
  //주소록 연락처 목록 연락처-그룹 관계추가-상세페이지
  int insertGroupContact(Contact contact);
  //주소록 연락처 목록 연락처 수정-상세페이지
  int updateContact(Contact contact);
  //주소록 연락처 목록 연락처 그룹이동
  int moveContact(Contact contact);
 //주소록 연락처 목록 연락처 삭제
  int deleteContact(Contact contact);
 //주소록 연락처 목록 그룹-연락처 관계 삭제
  int deleteGroupContact(Contact contact);
  //주소록 파일등록 임시 파일정보 저장
  int insertAddressFileInfo(AsisFileDataForm form);
  //주소록 파일등록 임시 파일 정보 리스트 
  List<Contact> getFileDataList(String uniqueKey);
  //일반보내기 주소록 그룹 호출
  List<Address> callAddress(AddressSearchCondition searchCondition);
  //일반보내기 부서정보 호출(부서코드, 부서명)
  List<Address> getPartList();
  //일반보내기 주소록 개인 연락처 호출
  List<Contact> getContactList(AddressSearchCondition searchCondition);
  //일반보내기 주소록 부서 연락처 호출
  List<Contact> getGroupContactList(AddressSearchCondition searchCondition);
  //일반보내기 특정부서 연락처 호출
  List<Contact> getPartAddressList(AddressSearchCondition searchCondition);
  //일반보내기 특정부서 연락처 호출
  List<Contact> getPartAddressListForAuthGrant(AddressSearchCondition searchCondition);
  
  Address findDetail(String boardSeq);
}
