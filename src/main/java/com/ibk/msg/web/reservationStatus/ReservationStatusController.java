package com.ibk.msg.web.reservationStatus;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@RequestMapping(value = "/campaign")
@Controller
public class ReservationStatusController {
  
  @Autowired
  private ReservationStatusService service;

	
  @GetMapping("/reservationStatus.ibk")
  public String viewListJsp() {
    return "campaign/reservationStatus/reservationStatus-list";
  }
  
  @GetMapping("/nevigation.ibk")
  public String viewNaviJsp() {
    return "nevigation/nevigation";
  }
  
  
  /**
   * 스케쥴 표 월별 조회
   * 
   * @param reservationStatusSearchCondition
   * @param session
   * @return
   * @throws Exception
   */
  @PostMapping(value = "/reservationStatus/monthly", produces = {"application/json"})
  @ResponseBody
  public Object selectMonthly(@RequestBody ReservationStatusSearchCondition reservationStatusSearchCondition, HttpSession session) throws Exception {
    return service.selectMonthly(reservationStatusSearchCondition);
  }
  
  /**
   * 시간별 예약 내역 조회
   * 
   * @param reservationStatusSearchCondition
   * @param session
   * @return
   * @throws Exception
   */
  @PostMapping(value = "/reservationStatus/hourly", produces = {"application/json"})
  @ResponseBody
  public Object selectHourly(@RequestBody ReservationStatusSearchCondition reservationStatusSearchCondition, HttpSession session) throws Exception {
    return service.selectHourly(reservationStatusSearchCondition);
  }

  
  /**
   * 일별 디테일 조회
   * 
   * @param reservationStatusSearchCondition
   * @param session
   * @return
   * @throws Exception
   */
  @PostMapping(value = "/reservationStatus/daily", produces = {"application/json"})
  @ResponseBody
  public Object selectDaily(@RequestBody ReservationStatusSearchCondition reservationStatusSearchCondition) throws Exception {
    return service.findByReservationStatusDetail(reservationStatusSearchCondition);
  }
}

  
	  
  
  
  
