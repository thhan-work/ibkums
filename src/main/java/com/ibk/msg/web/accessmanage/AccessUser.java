package com.ibk.msg.web.accessmanage;

import lombok.Data;

@Data
public class AccessUser {

  private String empNo;
  private String empNm;
  private String empIp;
  private String empDepNm;
  private String createdDt;
  private String useYn;

}
