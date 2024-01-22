package com.ibk.msg.web.message.dao;

import com.ibk.msg.config.database.IbkRepository;

@IbkRepository
public interface MsgSendMgrDao {

//    @SuppressWarnings("unchecked")
//	public Hashtable sendMsgList(Hashtable<String, MsgSendRcv> req_msgsendrcvlist, MsgSendInfo req_msgsendinfo) throws SQLException
//    {
//        DBConnectionMgr conMgr = null;
//        Connection con = null;
//        
//        CallableStatement cstmt =  null;
//        StringBuffer sb = new StringBuffer();
//
//        String TRAN_MSG;
//        boolean isNameTrans = false;
//
//        StringBuffer send_log = new StringBuffer();
//        StringBuffer sendResult = new StringBuffer();
//        int all_count = 0;
//        int send_count = 0;
//        int cut_count = 0;
//        int exceed_count = 0;
//        int unit_discord_count = 0;
//        int etc_count = 0;
//
//        String header = "①②③④⑤⑥⑦⑧⑨⑩⑪⑫⑬⑭⑮";
//        char[] cStr = header.toCharArray();
//
//        Hashtable h = new Hashtable();
//        MsgSendRcv req_msgsendrcv = null;
//        String rslt;
//
//        try {
//            conMgr = DBConnectionMgr.getInstance();
//            con = conMgr.getConnection();
//            
////            logger.writeLog("SND", "userAD 서비스 품질보증서 신청고객 여부(미신청자: 0, 신청자: 1) = " + req_msgsendinfo.userAD);
//            
//            /**
//        	 * userAD 서비스 품질보증서 신청고객 여부(미신청자: 0, 신청자: 1)
//        	 */
//			if ("0".equals(req_msgsendinfo.userAD)) {
//				
//				cstmt = con.prepareCall("{ ? = call SMS_SEND_EM(?, ?, ?, ?, ?, ?, ?, ?) }");
//				
//				TRAN_MSG = req_msgsendinfo.TRAN_MSG;
//				
//				Enumeration<MsgSendRcv> enu = req_msgsendrcvlist.elements();
//				while(enu.hasMoreElements()) {
//					req_msgsendrcv = enu.nextElement();
//
//					cstmt.registerOutParameter(1, java.sql.Types.CHAR, 1);
//					cstmt.setString(2, req_msgsendrcv.RCV_PHONE);
//					cstmt.setString(3, req_msgsendinfo.TRAN_CALLBACK);
//					cstmt.setString(4, req_msgsendinfo.TRAN_DATE);
//					cstmt.setString(5, req_msgsendinfo.UNIT_CODE);
//					cstmt.setString(6, req_msgsendinfo.DES_CODE);
//					cstmt.setString(7, req_msgsendinfo.EMPL_ID);
//					cstmt.setString(8, req_msgsendinfo.isAD);
//
//					if (isNameTrans) {
//						req_msgsendrcv.RCV_MSG = cFormatter.chgString(TRAN_MSG, "{$$$}", req_msgsendrcv.RCV_NAME);
//					} else {
//						req_msgsendrcv.RCV_MSG = TRAN_MSG;
//					}
//					cstmt.setString(9, req_msgsendrcv.RCV_MSG);
//					
//					cstmt.executeQuery();
//					rslt = cstmt.getString(1);
//					
//					cstmt.clearParameters();
//
//					if (rslt.equals("0")) {
//						send_count++;
//					} else if (rslt.equals("X")) {
//						cut_count++;
//					} else if (rslt.equals("Y")) {
//						exceed_count++;
//					} else if (rslt.equals("Z")) {
//						unit_discord_count++;
//					} else {
//						etc_count++;
//					}
//					if(!rslt.equals("0")) {
//						logger.writeLog(" SMS_SND_WEB ", "SMS_SND_WEB " + req_msgsendinfo.userAD + "	" +  req_msgsendinfo.EMPL_ID + "	" + etc_count + "	" + req_msgsendrcv.RCV_NAME + "	" + req_msgsendrcv.RCV_PHONE + "	" + rslt);
//					}
//					
//				} // end for
//			} else{
//				cstmt = con.prepareCall("{ ? = call SMS_SEND_USER_EM(?, ?, ?, ?, ?, ?, ?, ?) }");
//
//				TRAN_MSG = req_msgsendinfo.TRAN_MSG;
//				
//				Enumeration<MsgSendRcv> enu = req_msgsendrcvlist.elements();
//				while(enu.hasMoreElements()) {
//					req_msgsendrcv = enu.nextElement();
//
//					cstmt.registerOutParameter(1, java.sql.Types.CHAR, 1);
//					cstmt.setString(2, req_msgsendrcv.RCV_PHONE);
//					cstmt.setString(3, req_msgsendinfo.TRAN_CALLBACK);
//					cstmt.setString(4, req_msgsendinfo.TRAN_DATE);
//					cstmt.setString(5, req_msgsendinfo.UNIT_CODE);
//					cstmt.setString(6, req_msgsendinfo.DES_CODE);
//					cstmt.setString(7, req_msgsendinfo.EMPL_ID);
//					cstmt.setString(8, req_msgsendinfo.isAD);
//					
//					if (isNameTrans) {
//						req_msgsendrcv.RCV_MSG = cFormatter.chgString(TRAN_MSG, "{$$$}", req_msgsendrcv.RCV_NAME);
//					} else {
//						req_msgsendrcv.RCV_MSG = TRAN_MSG;
//					}
//					cstmt.setString(9, req_msgsendrcv.RCV_MSG);
//					
//					cstmt.executeQuery();
//					rslt = cstmt.getString(1);
//					
//					cstmt.clearParameters();
//					
//					if (rslt.equals("0")) {
//						send_count++;
//					} else if (rslt.equals("X")) {
//						cut_count++;
//					} else if (rslt.equals("Y")) {
//						exceed_count++;
//					} else if (rslt.equals("Z")) {
//						unit_discord_count++;
//					} else {
//						etc_count++;
//					}
//					if(!rslt.equals("0")) {
//						logger.writeLog(" SMS_SND_WEB ", "SMS_SND_WEB " + req_msgsendinfo.userAD + "	" +  req_msgsendinfo.EMPL_ID + "	" + etc_count + "	" + req_msgsendrcv.RCV_NAME + "	" + req_msgsendrcv.RCV_PHONE + "	" + rslt);
//					}
//				} // end for
//			} // end if
//
//            all_count = send_count + cut_count + exceed_count + unit_discord_count + etc_count;
//
//            h.put("ALL_COUNT", new Integer(all_count));
//            h.put("SEND_COUNT", new Integer(send_count));
//            h.put("CUT_COUNT", new Integer(cut_count));
//            h.put("EXCEED_COUNT", new Integer(exceed_count));
//            h.put("UNIT_DISCORD_COUNT", new Integer(unit_discord_count));
//            h.put("ETC_COUNT", new Integer(etc_count));
//            h.put("DUP_COUNT", req_msgsendrcvlist.size());
//            
//            send_log.append("SMS_SND_WEB ");
//            send_log.append(req_msgsendinfo.UNIT_CODE);
//            send_log.append(req_msgsendinfo.DES_CODE + "_");
//            send_log.append(req_msgsendinfo.EMPL_ID);
//            send_log.append("	LIST:	" + String.valueOf(req_msgsendrcvlist.size()) + " ");
//            send_log.append("	A:	" + String.valueOf(all_count) + " ");
//            send_log.append("	0:	" + String.valueOf(send_count) + " ");
//            send_log.append("	X:	" + String.valueOf(cut_count) + " ");
//            send_log.append("	Y:	" + String.valueOf(exceed_count) + " ");
//            send_log.append("	Z:	" + String.valueOf(unit_discord_count) + " ");
//            send_log.append("	?:	" + String.valueOf(etc_count) + " ");
//            send_log.append(sendResult.toString());
//
//            logger.writeLog("SND", send_log.toString());
//
//        } catch (SQLException ex) {
//            logger.writeLog("SQLE", "MsgSendMgr.sendMsgList()\n" + sb.toString(), ex);
//        } catch (Exception ex) {
//            logger.writeLog("EXP", "MsgSendMgr.sendMsgList()", ex);
//        } finally {
//            conMgr.close(con, cstmt, null);
//        }
//
//        return h;
//    }
	
	
}
