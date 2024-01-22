package com.ibk.msg.web.notice;

import lombok.Data;

@Data
public class Notice {

  private int id;
  private String title;
  private String writer;
  private String disDate;
  private String startDate;
  private String endDate;
  private String regDt;
  private char disYn;
  private String contents;
  private String modDt;
}
