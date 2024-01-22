package com.ibk.msg.web.notice;

import com.ibk.msg.config.database.IbkRepository;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.springframework.transaction.annotation.Transactional;

@IbkRepository
public interface NoticeDao {

  int findTotalCount(NoticeSearchCondition searchCondition);

  List<Notice> findNotice(NoticeSearchCondition searchCondition);

  void remove(int noticeId);

  int findMaxSequnce();

  int add(Notice notice);

  void modify(Notice notice);

  Notice findDetail(String boardSeq);

  int addList(@Param("noticeList") List<Notice> noticeList);
}
