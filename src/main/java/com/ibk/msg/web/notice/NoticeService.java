package com.ibk.msg.web.notice;

import com.google.common.base.Preconditions;
import com.ibk.msg.common.dto.PaginationResponse;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Component;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.transaction.support.DefaultTransactionDefinition;

@Component
@Slf4j
public class NoticeService {

  private final String NOTICE_BOARD_ID = "1";

  @Autowired
  private NoticeDao dao;


  public PaginationResponse findByPagination(NoticeSearchCondition searchCondition)
      throws Exception {

    Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
    Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");

    int totalCount = dao.findTotalCount(searchCondition);
    List<Notice> users = dao.findNotice(searchCondition);
    return new PaginationResponse(searchCondition, totalCount, users);
  }

  public Set remove(int[] noticeIdArr) {
    Preconditions.checkArgument(noticeIdArr.length > 0, "notice id empty");
    Set resultSet = new HashSet();
    for (int noticeId : noticeIdArr) {
      dao.remove(noticeId);
      resultSet.add(noticeId);
    }
    return resultSet;
  }

  @Transactional(transactionManager = "ibkSmsTxManager")
  public Object add(Notice notice) {
    Preconditions.checkArgument(StringUtils.isNoneBlank(notice.getTitle()), "subject is empty");
    Preconditions.checkArgument(StringUtils.isNoneBlank(notice.getContents()), "contents is empty");
    Preconditions.checkArgument(StringUtils.isNoneBlank(notice.getWriter()), "writer is empty");
    Preconditions
        .checkArgument(StringUtils.isNoneBlank(notice.getStartDate()), "startDate is empty");
    Preconditions.checkArgument(StringUtils.isNoneBlank(notice.getEndDate()), "endDate is empty");
    // TODO : 화면 기획 상에 표시 여부를 설정하는 부분이 없음 그래서 일단 skip
//    Preconditions.checkArgument(StringUtils.isNoneBlank(notice.getDisYn()), "disYn is empty");

    int boardSeq = dao.findMaxSequnce();
    notice.setId(boardSeq);
    notice.setDisYn('Y');
    dao.add(notice);
    return boardSeq;
  }

  public Object modify(Notice notice) {
    Preconditions.checkArgument(StringUtils.isNoneBlank(notice.getTitle()), "title is empty");
    Preconditions.checkArgument(StringUtils.isNoneBlank(notice.getContents()), "contents is empty");
    Preconditions
        .checkArgument(StringUtils.isNoneBlank(notice.getStartDate()), "startDate is empty");
    Preconditions.checkArgument(StringUtils.isNoneBlank(notice.getEndDate()), "endDate is empty");
    dao.modify(notice);
    return notice.getId();
  }

  public Notice findDetail(String boardSeq) {
    return dao.findDetail(boardSeq);
  }

  // 특정 메소드에 적용 하려면
  // 사용할 트랜잭션 매니져를 설정 하셔야 합니다.
  // 트랜잭션 매니져 명칭은 xxxxDatabaseConfig 을 확인 하시면 됩니다.
  @Transactional(transactionManager = "ibkSmsTxManager")
  public Object addList(List<Notice> noticeList) throws SQLException {
    dao.add(noticeList.get(0));
    dao.add(noticeList.get(1));
    return null;
  }
}
