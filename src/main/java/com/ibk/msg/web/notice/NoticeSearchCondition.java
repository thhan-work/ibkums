package com.ibk.msg.web.notice;

import com.ibk.msg.common.dto.PaginationCondition;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper=false)
@Data
public class NoticeSearchCondition extends PaginationCondition {

  private String searchWordType;
  private String searchWord;
  private String searchStartDt;
  private String searchEndDt;
  private String regDt;
}
