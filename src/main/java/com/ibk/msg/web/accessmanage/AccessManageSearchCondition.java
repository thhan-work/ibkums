package com.ibk.msg.web.accessmanage;

import com.ibk.msg.common.dto.PaginationCondition;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper=false)
@Data
public class AccessManageSearchCondition extends PaginationCondition {

  private String startSearchCreateDt;
  private String endSearchCreateDt;
  private String searchWordType;
  private String searchWord;
  private String useYn;
}
