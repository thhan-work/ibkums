package com.ibk.msg.utils;

public class PaginationUtil {

  public static final int getStartRowNum(final int pageNo, final int pageSize) {
    int tempPageNo = initPageNo(pageNo);
    int tempPageSize = initPageSize(pageSize);
    return tempPageSize * (tempPageNo - 1) + 1;
  }

  public static final int getEndRowNum(final int pageNo, final int pageSize) {
    int tempPageNo = initPageNo(pageNo);
    int tempPageSize = initPageSize(pageSize);
    return tempPageNo * tempPageSize;
  }

  private static int initPageNo(int pageNo) {
    if (pageNo > 0) {
      return pageNo;
    } else {
      return 1;
    }
  }

  private static int initPageSize(int pageSize) {
    if (pageSize > 0) {
      return pageSize;
    } else {
      return 10;
    }
  }
}
