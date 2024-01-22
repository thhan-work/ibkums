package com.ibk.msg.web.envset;

import lombok.Data;

/**
 * 경조사수신 정보를 제공한다.
 *
 * @author www.infobank.net
 * @version 2005.01.17
 */
@Data
public class CutEmpl {
	/**
	 * 직원 아이디
	 */
	public String emplId;//emplId
	/**
	 * 부서 코드
	 */
	public String boCode;//boCode
	/**
	 * 경조사 수신여부(0: 허용, 1: 차단)
	 */
	public String emplCut;//emplCut

}
