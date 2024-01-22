package com.ibk.msg.web.address;

import com.ibk.msg.common.dto.PaginationCondition;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
public class AddressSearchCondition extends PaginationCondition {

  private String idDomain;
  private String emplId; 
  private String boCode;
  private String grpSeq;
  private String catSeq;//연락처 검색 조건
  private String addressType;
  private String faxYn;// 연락처 검색 조건
  private String searchWordType; 	//조회 항목
  private String searchWord;			//조회 항목 값
}
