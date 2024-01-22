package com.ibk.msg.web.reservationStatus;

import java.util.List;

import com.ibk.msg.config.database.IbkRepository;

@IbkRepository
public interface ReservationStatusDao {

	int findDetailTotalCount(ReservationStatusSearchCondition rSearchCondition);
	List<ReservationStatus> findReservationStatusDetail(ReservationStatusSearchCondition rSearchCondition);
	
	List<ReservationStatus> selectMonthly(ReservationStatusSearchCondition reservationStatusSearchCondition);
	List<ReservationStatus> selectHourly(ReservationStatusSearchCondition reservationStatusSearchCondition);
	
}
