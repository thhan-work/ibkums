package com.ibk.msg.web.reservationStatus;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.google.common.base.Preconditions;
import com.ibk.msg.common.dto.PaginationResponse;

@Component
public class ReservationStatusService {
	
  private static final Logger logger = LoggerFactory.getLogger(ReservationStatusService.class);

  @Autowired
  private ReservationStatusDao dao;
  

  /**
   * 일별 디테일 조회
   * @param rSearchCondition
   * @return
   * @throws Exception
   */
  public PaginationResponse findByReservationStatusDetail(ReservationStatusSearchCondition rSearchCondition) throws Exception {
    Preconditions.checkArgument(rSearchCondition.getPerPage() > 0, "perPage is null");
    Preconditions.checkArgument(rSearchCondition.getCurrentPage() > 0, "currentPage is null");

    int totalCount = dao.findDetailTotalCount(rSearchCondition);
    List<ReservationStatus> reservationStatus = dao.findReservationStatusDetail(rSearchCondition);
    return new PaginationResponse(rSearchCondition, totalCount, reservationStatus);
  }


  /**
   * 스케쥴표 년/월별 조회
   * 
   * @param reservationStatusSearchCondition
   * @return
   */
  public Object selectMonthly(ReservationStatusSearchCondition reservationStatusSearchCondition) {
  	logger.info("[INFO] ########### 스케쥴표 년/월별 조회 DATE="+reservationStatusSearchCondition.getPengagYms());
  	List<ReservationStatus> reList = dao.selectMonthly(reservationStatusSearchCondition);
  	return reList;
  }
  
  
  /**
   * 시간별 예약 내역 조회
   * 
   * @param reservationStatusSearchCondition
   * @return
   */
  public Object selectHourly(ReservationStatusSearchCondition reservationStatusSearchCondition) {
  	logger.info("[INFO] ########### 시간별 예약 내역 조회 DATE="+reservationStatusSearchCondition.getPengagYms());
  	List<List<ReservationStatus>> resultList = new ArrayList<List<ReservationStatus>>();
  	
  	for(String pengagYms : reservationStatusSearchCondition.getPengagYms().split(",")){
  		ReservationStatusSearchCondition rssc = new ReservationStatusSearchCondition();
  		rssc.setPengagYms(pengagYms);
  		
  		resultList.add(dao.selectHourly(rssc));
  	}
  	
  	return resultList;
  }
  

}
