package com.ibk.msg.web.mymessage;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.base.Preconditions;
import com.ibk.msg.common.dto.PaginationResponse;
import com.ibk.msg.web.loglist.LogListDao;
import com.ibk.msg.web.message.MessageService;
import com.ibk.msg.web.message.model.MsgSend;
import com.ibk.msg.web.message.model.MsgSendInfo;

@Component
public class MyMessageService {

	private static final Logger logger = LoggerFactory.getLogger(MessageService.class);

	@Autowired
	private MyMessageDao dao;

	@Autowired
	private LogListDao logDao;

	@Autowired
	private MessageService messageService;

	public PaginationResponse findByPagination(MyMessageSearchCondition searchCondition)
			throws Exception {
		Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
		Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");

		searchCondition.setRegDt(searchCondition.getSearchStartDt().substring(0,6));

		String cc = "CC";
		String boCode = searchCondition.getBoCode();
		String emplId = searchCondition.getEmplId();
		String tranId = cc + boCode + "_" + emplId; 

		searchCondition.setBoCode(tranId);

		int totalCount = dao.findTotalCount(searchCondition);
		List<MyMessage> users = dao.findMyMessage(searchCondition);

		for(MyMessage user : users) {
			if(user.getSendRslt() == null || user.getSendRslt().equals("")){
				user.setSendRslt("결과대기");
				continue;
			}

			if((user.getMessageType().toUpperCase().equals("SMS") && user.getSendRslt().equals("0"))
					|| (user.getMessageType().toUpperCase().equals("MMS") && user.getSendRslt().equals("1000")) ){
				user.setSendRslt("정상");
			}else if ( user.getSendRslt().equals("X")){
				user.setSendRslt("수신거부");
			}else {
				user.setSendRslt("실패("+user.getSendRslt()+")");
			}
		}

		HashMap<String, String> pram = new HashMap<String, String>();
		String rslt = searchCondition.getSearchSendStatus();

		if(rslt == null || rslt.trim().equals("")){
			rslt = "전체";
		}

		if(rslt.equals("success")){
			rslt = "성공";
		}else if(rslt.equals("fail")){
			rslt = "실패";
		}else if(rslt.equals("refuse")){
			rslt = "수신거부";
		}else{
			rslt = "전체";
		}

		String seachValue = "[내가 보낸메시지]시작일:"+searchCondition.getSearchStartDt() + "종료일:" + searchCondition.getSearchEndDt() + "전송상태:" + rslt + "휴대폰번호:" + searchCondition.getSearchPhoneNumber();

		pram.put("emplId", emplId);
		pram.put("seachValue", seachValue);
		pram.put("ipAdr", searchCondition.getEmplIp());
		logDao.msgHistoryLog(pram);

		return new PaginationResponse(searchCondition, totalCount, users);
	}

	public Object remove(List<MyMessage> mymessageList) {
		int total = 0;  
		int count = 0;

		for(MyMessage mymessage : mymessageList){
			Preconditions.checkArgument(StringUtils.isNoneBlank(mymessage.getRegDt()), "DisDate is empty");
			Preconditions.checkArgument(StringUtils.isNoneBlank(mymessage.getMessageType()), "MessageType is empty");
			Preconditions.checkArgument(StringUtils.isNoneBlank(mymessage.getId()), "mymessage id empty");

			String[] yyyymmdd = mymessage.getRegDt().split(" ");
			String[] yyyymmddArr = yyyymmdd[0].split("-");
			String yyyymm = yyyymmddArr[0]+ yyyymmddArr[1];

			mymessage.setRegDt(yyyymm);
			mymessage.setMessageType(mymessage.getMessageType());

			dao.remove(mymessage);
			count++;
		}
		total += count;
		return total;
	}

	@Transactional(transactionManager = "ibkSmsTxManager")
	public Object resend(List<MyMessage> mymessageList, HttpSession session) {
		// Step 1 메시지 한도 체크 (2018.10.21 한도체크 X)

		// Step 2 메시지 정보 체크
		int count = 0;
		int all_count = 0;
		int send_count = 0;
		int cut_count = 0;
		int exceed_count = 0;
		int unit_discord_count = 0;
		int etc_count = 0;

		Hashtable h = new Hashtable();

		for(MyMessage mymessage : mymessageList){
			Preconditions.checkArgument(StringUtils.isNoneBlank(mymessage.getMessageType()), "MessageType is empty");
			Preconditions.checkArgument(StringUtils.isNoneBlank(mymessage.getId()), "uniqueKey is empty");

			List<MsgSendInfo> rcvSendList = new ArrayList<MsgSendInfo>();
			List<MsgSendInfo> rcvLogList = new ArrayList<MsgSendInfo>();

			MsgSendInfo request_msgsendinfo = new MsgSendInfo();
			request_msgsendinfo.setDesCode(session.getAttribute("EMPL_BOCODE").toString());
			request_msgsendinfo.setUnitCode("CC");
			request_msgsendinfo.setEmplId(session.getAttribute("EMPL_ID").toString());
			request_msgsendinfo.setPartName("");//부서명 @@@@@@@@@@@@@@@@@@@ 추가필요
			request_msgsendinfo.setTranCallback(mymessage.getCallBack().replaceAll("-", ""));
			request_msgsendinfo.setTranMsg(mymessage.getMsg());
			request_msgsendinfo.setRcvPhone(mymessage.getPhoneNumber());
			request_msgsendinfo.setRcvSubject(mymessage.getSubject());
			request_msgsendinfo.setTranDate("SYSDATE");
			request_msgsendinfo.setIsAD("0");
			request_msgsendinfo.setRcvName("");
			request_msgsendinfo.setSendType(mymessage.getMessageType());
			mymessage.setReceivers("");
			request_msgsendinfo.setFileCt("0");
			request_msgsendinfo.setRcvFilename("");
			request_msgsendinfo.setRcvFilesize("0");
			request_msgsendinfo.setRcvName(mymessage.getEtc5());

			if(mymessage.getMessageType().toUpperCase().equals("SMS")){
				request_msgsendinfo.setUserAD(mymessage.getUserAD());
			}

			//step3 개별 메시지 처리

			MsgSendInfo request_msgsendrcv = new MsgSendInfo();
			request_msgsendrcv.setMsgSendInfo(request_msgsendinfo);
			request_msgsendrcv.setRcvName(mymessage.getEtc5());
			request_msgsendrcv.setRcvPhone(request_msgsendinfo.getRcvPhone());
			request_msgsendrcv.setRcvMsg(request_msgsendinfo.getTranMsg());
			request_msgsendrcv.setCallback(request_msgsendinfo.getTranCallback());

			if(mymessage.getMessageType().toUpperCase().equals("MMS")){
				request_msgsendrcv.setRcvFilename("");
				request_msgsendrcv.setRcvFilect("0");
				request_msgsendrcv.setRcvFilesize("0");
				request_msgsendrcv.setRcvSubject(mymessage.getSubject());
			}

			String rslt = messageService.sendValidation(request_msgsendrcv);

			if (rslt.equals("0")) {//정상 발송 데이터
				String sendType = mymessage.getMessageType().toUpperCase();
				request_msgsendrcv.setTranStatus(sendType.equals("SMS") ? "1":"0");
				request_msgsendrcv.setTranRslt(null);
				
				rcvSendList.add(request_msgsendrcv);
				send_count++;
			} else if (rslt.equals("X")) { // 발송 X 로그 O 데이터
				request_msgsendrcv.setTranStatus("3");
				request_msgsendrcv.setTranRslt("X");
				rcvLogList.add(request_msgsendrcv);
				cut_count++;
			} else { // 그외 오류처리
				etc_count++;
			}
			all_count += count;

			if(logger.isDebugEnabled()) {
				logger.debug("실건수:" + all_count + ", 발송 건수:" + send_count);
			}



			//-------------발송을 위한 데이터 처리 
			MsgSend msgSend = new MsgSend();

			// tranId 업무코드 생성 ( UNITCODE + 부서코드 + '_' + 회원ID )
			String tranId = request_msgsendinfo.getUnitCode() + request_msgsendinfo.getDesCode() +"_"+ request_msgsendinfo.getEmplId();
			msgSend.setTranId(tranId);
			msgSend.setSendType(mymessage.getMessageType().toUpperCase());

			msgSend.setMymsgResendList(rcvSendList);
			msgSend.setMymsgLogList(rcvLogList);


			//send
			sendMsgList(msgSend);

			all_count = send_count + cut_count + exceed_count + unit_discord_count + etc_count;

			h.put("ALL_COUNT", new Integer(all_count));
			h.put("SEND_COUNT", new Integer(send_count));
			h.put("CUT_COUNT", new Integer(cut_count));
			h.put("EXCEED_COUNT", new Integer(exceed_count));
			h.put("UNIT_DISCORD_COUNT", new Integer(unit_discord_count));
			h.put("ETC_COUNT", new Integer(etc_count));
			//      h.put("DUP_COUNT", msgSend.setMymsgResendList().size() + msgSend.getMsgLogList().size());

		} //end for

		return h;  
	}


	/**
	 * 메시지 발송 및 로그처리
	 *
	 * @param request_msgsendinfo
	 * @return
	 */
	public int sendMsgList(MsgSend mymessage){
		SimpleDateFormat yyyymm = new SimpleDateFormat("yyyyMM");
		mymessage.setLogDate(yyyymm.format(new Date()));

		int result = -1;

		//로그테이블 
		logger.info("#####SEND MSG TYPE :" + mymessage.getSendType());
		logger.info("#####SEND DATA LIST :" + mymessage.getMymsgResendList().size());
		logger.info("#####LOG DATA LIST :" + mymessage.getMymsgLogList().size());
		//		
		if(mymessage.getSendType().equals("SMS")) // SMS 발송 및 로그(미발송건) 처리 
		{
			if(mymessage.getMymsgResendList().size() > 0) // 발송
			{
				result = dao.sendSMS(mymessage);
			}

			if(mymessage.getMymsgLogList().size() > 0) // 로그(미발송 에러건)
			{
				result = dao.logSMS(mymessage);
			}
		}


		if(mymessage.getSendType().equals("MMS")) // MMS 발송 및 로그(미발송건) 처리 
		{
			if(mymessage.getMymsgResendList().size() > 0) // 발송
			{
				result = dao.sendMMS(mymessage);
			}

			if(mymessage.getMymsgLogList().size() > 0) // 로그(미발송 에러건)
			{
				result = dao.logMMS(mymessage);
			}
		}

		return result;
	}


}
