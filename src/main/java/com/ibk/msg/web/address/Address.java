package com.ibk.msg.web.address;

import lombok.Data;

@Data
public class Address {

  private String emplId;
  private String grpSeq;
  private String groupName;
  private String groupNote;
  private String owner;
  private String groupShareYn;
  private String boCode;
  private int contactCount;
  private String catSeq;//XGROUP_CONTACT ,XCONTACT
  
  private String partName; //부서 정보
  @Override
  public String toString(){
      return "emplId "+emplId+", grpSeq:" +grpSeq+", groupName:"+groupName+
    		     ",\n groupNote:"+groupNote+", owner:"+owner+", groupShareYn:"+groupShareYn+
    		     ",\n boCode:"+boCode+", contactCount:"+contactCount;
  }
}
