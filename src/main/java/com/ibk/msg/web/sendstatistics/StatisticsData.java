package com.ibk.msg.web.sendstatistics;

import lombok.Data;

@Data
public class StatisticsData {
	
	private int rnum; 						// 순번
	private String msgDstic;				// 그룹회사코드
	private String standardYmd;				// 발송일
	//private int	sendNumber;				// 전체 건수(기본발송)
	private int successNumber;				// 성공 건수(기본발송)
	private int failureNumber;				// 실패 건수(기본발송)
	private String successPercent;			// 성공율(기본발송)
	private int reSuccessNumber;			// 성공 건수(전환발송)
	private int reFailureNumber;			// 실패 건수(전환발송)
	private String reSuccessPercent;		// 성공율(전환발송)
	
	private String relay;					// 중계사
	
	private int totalSuccessNumber; 		// 총 성공 건수(기본발송)
	private String totalSuccessPercent; 	// 총 성공율(기본발송)
	private int totalReSuccessNumber; 		// 총 성공 건수(전환발송)
	private String totalReSuccessPercent; 	// 총 성공율(전환발송)
	private int totalFailureNumber; 		// 총 실패 건수
	private String totalFailurePercent; 	// 총 실패율
	private int totalSendNumber; 			// 총 건수
	private String totalPercent; 			// 총 성공율
	
	private String monthPercent; 			// 월별 총 성공률
	private int monthSuccessNumber; 		// 월별 총 성공 건수 (기본발송)
	private String monthSuccessPercent; 	// 월별 총 성공률 (기본발송)
	private int monthReSuccessNumber; 		// 월별 총 성공 건수(전환발송)
	private String monthReSuccessPercent; 	// 월별 총 성공률(전환발송)
	private int monthFailureNumber; 		// 월별 총 실패 건수
	private String monthFailurePercent; 	// 월별 총 실패률
	private int monthSendNumber; 			// 월별 총 건수
	
	private String departmentPercent; 			// 부서별 총 성공률
	private int departmentSuccessNumber; 		// 부서별 총 성공 건수(기본발송)
	private String departmentSuccessPercent; 	// 부서별 총 성공률(기본발송)
	private int departmentReSuccessNumber; 		// 부서별 총 성공 건수(전환발송)
	private String departmentReSuccessPercent; 	// 부서별 총 성공률(전환발송)
	private int departmentFailureNumber; 		// 부서별 총 실패 건수
	private String departmentFailurePercent; 	// 부서별 총 실패률
	private int departmentSendNumber; 			// 부서별 총 건수
	
	private String groupValue2;				// 하위부서
	private int successCost;				// 메시지 비용(기본발송)
	private int reSuccessCost;				// 메시지 비용(전환발송)
	private int marketingCnt;				// 마케팅 건수
	private int noMarketingCnt;				// 비마케팅 건수	
	
}
