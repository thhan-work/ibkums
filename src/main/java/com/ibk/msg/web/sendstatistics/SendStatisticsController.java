package com.ibk.msg.web.sendstatistics;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ibk.msg.utils.ExcelCellDef;
import com.ibk.msg.utils.ExcelDef;
import com.ibk.msg.utils.ExcelExportUtil;
import com.ibk.msg.utils.ExcelMergeCellDef;
import com.ibk.msg.utils.ExcelSheetDef;
import com.ibk.msg.web.sendstatistics.StatisticsData;
import com.ibk.msg.web.sendstatistics.StatisticsSearchCondition;
import com.ibk.msg.web.sendstatistics.SendStatisticsService;

@RequestMapping(value = "/campaign")
@Controller
public class SendStatisticsController {

	@Autowired
	private SendStatisticsService sendStatisticsService;

	@GetMapping("/sendStatistics.ibk")
	public String statisticsChannel() {
		return "campaign/sendStatistics/sendStatistics-list";
	}

	
	/**
	 * 발송통계(일별/월별/부서별) 조회
	 * @param searchCondition
	 * @param httpSession
	 * @return
	 * @throws Exception
	 */
	@PostMapping("/sendStatisticsList")
	@ResponseBody
	public Object findStatisticsListAjax(@RequestBody StatisticsSearchCondition searchCondition,
			HttpSession httpSession) throws Exception {
		return sendStatisticsService.findStatisticsListAjax(searchCondition);
	}

	/**
	 * 발송통계(일별/월별/부서별) 엑셀다운로드
	 * @param request
	 * @param searchCondition
	 * @param response
	 * @throws Throwable
	 */
	@RequestMapping("/sendStatisticsExcelDownload")
	public void sendStatisticshExcelDownload(HttpServletRequest request, StatisticsSearchCondition searchCondition,
			HttpServletResponse response) throws Throwable {
		Map<String, Object> statisticsMap = sendStatisticsService.findStatisticsListAjax(searchCondition);

		List<StatisticsData> statisticsList = (List<StatisticsData>) statisticsMap.get("statisticsList");
		List<StatisticsData> totalCountGroupByMonth = (List<StatisticsData>) statisticsMap.get("totalCountGroupByMonth");
		List<StatisticsData> totalCountGroupByDepartment = (List<StatisticsData>) statisticsMap.get("totalCountGroupByDepartment");
		StatisticsData totalCount = (StatisticsData) statisticsMap.get("totalCount");

		String title = "";
		String fileName = "";
		String sheetName = "";

		ExcelDef excelDef = new ExcelDef();
		ExcelSheetDef excelSheetDef = new ExcelSheetDef();

		int row = 0;
		int rowMergeCnt = 0;
		int copyRow = 0;

		String topTblTotalSuccess = "";
		String topTblTotalReSuccess = "";
		String topTblTotalFailure = "";
		String topTblTotalSum = "";

		if ("daily".equals(searchCondition.getStatisticsType())) {
			title = "일별통계";
			fileName = "일별통계.xls";
			sheetName = "일별통계";

			excelDef.setFileName(fileName);
			excelSheetDef.setSheetName(sheetName);

			excelSheetDef.addCellMerge(new ExcelMergeCellDef(0, 0, 0, 11));
			excelSheetDef.addCell(new ExcelCellDef("title", 0, 0, title));

			excelSheetDef.addCellMerge(new ExcelMergeCellDef(2, 3, 0, 0));
			excelSheetDef.addCell(new ExcelCellDef("header", 2, 0, "발송일"));

			excelSheetDef.addCellMerge(new ExcelMergeCellDef(2, 3, 1, 1));
			excelSheetDef.addCell(new ExcelCellDef("header", 2, 1, "메시지유형"));

			excelSheetDef.addCellMerge(new ExcelMergeCellDef(2, 2, 2, 3));
			excelSheetDef.addCell(new ExcelCellDef("header", 2, 2, "발송구분(건수)"));

			excelSheetDef.addCellMerge(new ExcelMergeCellDef(2, 3, 4, 4));
			excelSheetDef.addCell(new ExcelCellDef("header", 2, 4, "전체건수"));

			excelSheetDef.addCellMerge(new ExcelMergeCellDef(2, 3, 5, 5));
			excelSheetDef.addCell(new ExcelCellDef("header", 2, 5, "성공률"));

			excelSheetDef.addCellMerge(new ExcelMergeCellDef(2, 2, 6, 8));
			excelSheetDef.addCell(new ExcelCellDef("header", 2, 6, "기본발송"));

			excelSheetDef.addCellMerge(new ExcelMergeCellDef(2, 2, 9, 11));
			excelSheetDef.addCell(new ExcelCellDef("header", 2, 9, "전환발송"));

			excelSheetDef.addCell(new ExcelCellDef("header", 3, 2, "마케팅"));
			excelSheetDef.addCell(new ExcelCellDef("header", 3, 3, "비마케팅"));
			excelSheetDef.addCell(new ExcelCellDef("header", 3, 6, "성공건\n 금액"));
			excelSheetDef.addCell(new ExcelCellDef("header", 3, 7, "실패건"));
			excelSheetDef.addCell(new ExcelCellDef("header", 3, 8, "성공률"));
			excelSheetDef.addCell(new ExcelCellDef("header", 3, 9, "성공건\n 금액"));
			excelSheetDef.addCell(new ExcelCellDef("header", 3, 10, "실패건"));
			excelSheetDef.addCell(new ExcelCellDef("header", 3, 11, "성공률"));

			row = 4;
		} else if ("monthly".equals(searchCondition.getStatisticsType())) {
			title = "월별통계";
			fileName = "월별통계.xls";
			sheetName = "월별통계";

			excelDef.setFileName(fileName);
			excelSheetDef.setSheetName(sheetName);

			excelSheetDef.addCellMerge(new ExcelMergeCellDef(0, 0, 0, 11));
			excelSheetDef.addCell(new ExcelCellDef("title", 0, 0, title));

			excelSheetDef.addCellMerge(new ExcelMergeCellDef(2, 2, 0, 3));
			excelSheetDef.addCell(new ExcelCellDef("header", 2, 0, "발송월"));

			excelSheetDef.addCellMerge(new ExcelMergeCellDef(2, 2, 4, 5));
			excelSheetDef.addCell(new ExcelCellDef("header", 2, 4, "기본발송 성공 총 건수 (성공률)\n 금액"));
			excelSheetDef.addCellMerge(new ExcelMergeCellDef(2, 2, 6, 7));
			excelSheetDef.addCell(new ExcelCellDef("header", 2, 6, "전환발송 성공 총 건수 (성공률)\n 금액"));
			excelSheetDef.addCellMerge(new ExcelMergeCellDef(2, 2, 8, 9));
			excelSheetDef.addCell(new ExcelCellDef("header", 2, 8, "총 실패 건수 (실패율)"));
			excelSheetDef.addCellMerge(new ExcelMergeCellDef(2, 2, 10, 11));
			excelSheetDef.addCell(new ExcelCellDef("header", 2, 10, "총 건수 (총 성공률)"));

			row = 3;

			rowMergeCnt = 0;
			copyRow = 0;

			if (totalCountGroupByMonth.size() > 0) {
				for (int i = 0; i < totalCountGroupByMonth.size(); i++) {
					int monthSuccessNumber = totalCountGroupByMonth.get(i).getMonthSuccessNumber();
					String monthSuccessPercent = totalCountGroupByMonth.get(i).getMonthSuccessPercent();
					int monthReSuccessNumber = totalCountGroupByMonth.get(i).getMonthReSuccessNumber();
					String monthReSuccessPercent = totalCountGroupByMonth.get(i).getMonthReSuccessPercent();
					int monthFailureNumber = totalCountGroupByMonth.get(i).getMonthFailureNumber();
					String monthFailurePercent = totalCountGroupByMonth.get(i).getMonthFailurePercent();
					int monthSendNumber = totalCountGroupByMonth.get(i).getMonthSendNumber();
					String monthPercent = totalCountGroupByMonth.get(i).getMonthPercent();
					int successCost = totalCountGroupByMonth.get(i).getSuccessCost();
					int reSuccessCost = totalCountGroupByMonth.get(i).getReSuccessCost();

					topTblTotalSuccess = comma(monthSuccessNumber) + " 건 (" + monthSuccessPercent + "%)" + "\n ₩"
							+ comma(successCost);
					topTblTotalReSuccess = comma(monthReSuccessNumber) + " 건 (" + monthReSuccessPercent + "%)" + "\n ₩"
							+ comma(reSuccessCost);
					topTblTotalFailure = comma(monthFailureNumber) + " 건 (" + monthFailurePercent + "%)";
					topTblTotalSum = comma(monthSendNumber) + " 건 (" + monthPercent + "%)";

					if (i > 0) {
						String standardYmd = totalCountGroupByMonth.get(i).getStandardYmd(); // 현재 row 발송일/월 값
						String standardYmdPre = totalCountGroupByMonth.get(i - 1).getStandardYmd(); // 이전 row 발송일/월 값

						if (standardYmd.contains(standardYmdPre)) { // 이전 row 값과 같을 때
							rowMergeCnt++;

							if (copyRow == 0) {
								copyRow = row - 1;
							}

							if (i == totalCountGroupByMonth.size() - 1) {
								excelSheetDef.addCellMerge(new ExcelMergeCellDef(copyRow, copyRow + rowMergeCnt, 0, 3));
							}
						} else { // 이전 row와 값이 달라졌을 때
							if (rowMergeCnt > 0) {
								int nextRow = copyRow + rowMergeCnt + 1;

								excelSheetDef.addCellMerge(new ExcelMergeCellDef(copyRow, copyRow + rowMergeCnt, 0, 3));

								if (i == totalCountGroupByMonth.size() - 1) {
									excelSheetDef.addCell(new ExcelCellDef("data", row - 1, 0, getDateFmt(totalCountGroupByMonth.get(i - 1).getStandardYmd())));
									excelSheetDef.addCellMerge(new ExcelMergeCellDef(nextRow, nextRow, 0, 3));
								}

								rowMergeCnt = 0;
								copyRow = nextRow;
							} else {
								if (i == totalCountGroupByMonth.size() - 1) {
									excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row, 0, 3));
								}
							}
						}
					} else {
						if (totalCountGroupByMonth.size() == 1) {
							excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row, 0, 3));
						} else {
							String standardYmd = totalCountGroupByMonth.get(i).getStandardYmd(); // 현재 row 발송일/월 값
							String standardYmdNext = totalCountGroupByMonth.get(i + 1).getStandardYmd(); // 다음 row 발송일/월 값

							if (!standardYmd.contains(standardYmdNext)) {
								excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row, 0, 3));
							}
						}
					}

					excelSheetDef.addCell(new ExcelCellDef("data", row, 0, getDateFmt(totalCountGroupByMonth.get(i).getStandardYmd())));
					excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row, 4, 5));
					excelSheetDef.addCell(new ExcelCellDef("data", row, 4, topTblTotalSuccess));
					excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row, 6, 7));
					excelSheetDef.addCell(new ExcelCellDef("data", row, 6, topTblTotalReSuccess));
					excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row, 8, 9));
					excelSheetDef.addCell(new ExcelCellDef("data", row, 8, topTblTotalFailure));
					excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row, 10, 11));
					excelSheetDef.addCell(new ExcelCellDef("data", row, 10, topTblTotalSum));

					row++;
				}
			} else {
				excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row, 0, 11));
				excelSheetDef.addCell(new ExcelCellDef("data", row, 0, "조회 하신 데이터가 없습니다."));

				row++;
			}

			row++;

			excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row + 1, 0, 0));
			excelSheetDef.addCell(new ExcelCellDef("header", row, 0, "발송월"));

			excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row + 1, 1, 1));
			excelSheetDef.addCell(new ExcelCellDef("header", row, 1, "메시지유형"));

			excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row, 2, 3));
			excelSheetDef.addCell(new ExcelCellDef("header", row, 2, "발송구분(건수)"));

			excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row + 1, 4, 4));
			excelSheetDef.addCell(new ExcelCellDef("header", row, 4, "전체건수"));

			excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row + 1, 5, 5));
			excelSheetDef.addCell(new ExcelCellDef("header", row, 5, "성공률"));

			excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row, 6, 8));
			excelSheetDef.addCell(new ExcelCellDef("header", row, 6, "기본발송"));

			excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row, 9, 11));
			excelSheetDef.addCell(new ExcelCellDef("header", row, 9, "전환발송"));

			excelSheetDef.addCell(new ExcelCellDef("header", row + 1, 2, "마케팅"));
			excelSheetDef.addCell(new ExcelCellDef("header", row + 1, 3, "비마케팅"));
			excelSheetDef.addCell(new ExcelCellDef("header", row + 1, 6, "성공건\n 금액"));
			excelSheetDef.addCell(new ExcelCellDef("header", row + 1, 7, "실패건"));
			excelSheetDef.addCell(new ExcelCellDef("header", row + 1, 8, "성공률"));
			excelSheetDef.addCell(new ExcelCellDef("header", row + 1, 9, "성공건\n 금액"));
			excelSheetDef.addCell(new ExcelCellDef("header", row + 1, 10, "실패건"));
			excelSheetDef.addCell(new ExcelCellDef("header", row + 1, 11, "성공률"));

			row += 2;
		} else if ("department".equals(searchCondition.getStatisticsType())) {
			title = "부서별통계";
			fileName = "부서별통계.xls";
			sheetName = "부서별통계";

			excelDef.setFileName(fileName);
			excelSheetDef.setSheetName(sheetName);

			excelSheetDef.addCellMerge(new ExcelMergeCellDef(0, 0, 0, 12));
			excelSheetDef.addCell(new ExcelCellDef("title", 0, 0, title));

			excelSheetDef.addCellMerge(new ExcelMergeCellDef(2, 2, 0, 1));
			excelSheetDef.addCell(new ExcelCellDef("header", 2, 0, "발송월"));

			excelSheetDef.addCellMerge(new ExcelMergeCellDef(2, 2, 2, 3));
			excelSheetDef.addCell(new ExcelCellDef("header", 2, 2, "부서별"));

			excelSheetDef.addCellMerge(new ExcelMergeCellDef(2, 2, 4, 5));
			excelSheetDef.addCell(new ExcelCellDef("header", 2, 4, "기본발송 성공 총 건수 (성공률)\n 금액"));
			excelSheetDef.addCellMerge(new ExcelMergeCellDef(2, 2, 6, 7));
			excelSheetDef.addCell(new ExcelCellDef("header", 2, 6, "전환발송 성공 총 건수 (성공률)\n 금액"));
			excelSheetDef.addCellMerge(new ExcelMergeCellDef(2, 2, 8, 9));
			excelSheetDef.addCell(new ExcelCellDef("header", 2, 8, "총 실패 건수 (실패율)"));
			excelSheetDef.addCellMerge(new ExcelMergeCellDef(2, 2, 10, 12));
			excelSheetDef.addCell(new ExcelCellDef("header", 2, 10, "총 건수 (총 성공률)"));

			row = 3;

			rowMergeCnt = 0;
			copyRow = 0;

			if (totalCountGroupByDepartment.size() > 0) {
				for (int i = 0; i < totalCountGroupByDepartment.size(); i++) {
					int departmentSuccessNumber = totalCountGroupByDepartment.get(i).getDepartmentSuccessNumber();
					String departmentSuccessPercent = totalCountGroupByDepartment.get(i).getDepartmentSuccessPercent();
					int departmentReSuccessNumber = totalCountGroupByDepartment.get(i).getDepartmentReSuccessNumber();
					String departmentReSuccessPercent = totalCountGroupByDepartment.get(i).getDepartmentReSuccessPercent();
					int departmentFailureNumber = totalCountGroupByDepartment.get(i).getDepartmentFailureNumber();
					String departmentFailurePercent = totalCountGroupByDepartment.get(i).getDepartmentFailurePercent();
					int departmentSendNumber = totalCountGroupByDepartment.get(i).getDepartmentSendNumber();
					String departmentPercent = totalCountGroupByDepartment.get(i).getDepartmentPercent();
					int successCost = totalCountGroupByDepartment.get(i).getSuccessCost();
					int reSuccessCost = totalCountGroupByDepartment.get(i).getReSuccessCost();

					topTblTotalSuccess = comma(departmentSuccessNumber) + " 건 (" + departmentSuccessPercent + "%)"
							+ "\n ₩" + comma(successCost);
					topTblTotalReSuccess = comma(departmentReSuccessNumber) + " 건 (" + departmentReSuccessPercent + "%)"
							+ "\n ₩" + comma(reSuccessCost);
					topTblTotalFailure = comma(departmentFailureNumber) + " 건 (" + departmentFailurePercent + "%)";
					topTblTotalSum = comma(departmentSendNumber) + " 건 (" + departmentPercent + "%)";

					if (i > 0) {
						String standardYmd = totalCountGroupByDepartment.get(i).getStandardYmd(); // 현재 row 발송일/월 값
						String standardYmdPre = totalCountGroupByDepartment.get(i - 1).getStandardYmd(); // 이전 row 발송일/월 값

						if (standardYmd.contains(standardYmdPre)) { // 이전 row 값과 같을 때
							rowMergeCnt++;

							if (copyRow == 0) {
								copyRow = row - 1;
							}

							if (i == totalCountGroupByDepartment.size() - 1) {
								excelSheetDef.addCellMerge(new ExcelMergeCellDef(copyRow, copyRow + rowMergeCnt, 0, 1));
							}
						} else { // 이전 row와 값이 달라졌을 때
							if (rowMergeCnt > 0) {	// 기존에 머지된 값이 있을 때	
								int nextRow = copyRow + rowMergeCnt + 1;

								excelSheetDef.addCellMerge(new ExcelMergeCellDef(copyRow, copyRow + rowMergeCnt, 0, 1));

								if (i == totalCountGroupByDepartment.size() - 1) {
									excelSheetDef.addCell(new ExcelCellDef("data", row - 1, 0, getDateFmt(totalCountGroupByDepartment.get(i - 1).getStandardYmd())));

									excelSheetDef.addCellMerge(new ExcelMergeCellDef(nextRow, nextRow, 0, 1));
								}

								rowMergeCnt = 0;
								copyRow = nextRow;
							} else {	
								if (i == totalCountGroupByDepartment.size() - 1) {
									excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row, 0, 1));
								}
							}
						}
					} else {
						if (totalCountGroupByDepartment.size() == 1) {
							excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row, 0, 1));
						} else {
							String standardYmd = totalCountGroupByDepartment.get(i).getStandardYmd(); // 현재 row 발송일/월 값
							String standardYmdNext = totalCountGroupByDepartment.get(i + 1).getStandardYmd(); // 다음 row 발송일/월 값

							if (!standardYmd.contains(standardYmdNext)) {
								excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row, 0, 1));
							}
						}
					}

					excelSheetDef.addCell(new ExcelCellDef("data", row, 0, getDateFmt(totalCountGroupByDepartment.get(i).getStandardYmd())));
					excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row, 2, 3));
					excelSheetDef.addCell(new ExcelCellDef("data", row, 2, totalCountGroupByDepartment.get(i).getGroupValue2()));
					excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row, 4, 5));
					excelSheetDef.addCell(new ExcelCellDef("data", row, 4, topTblTotalSuccess));
					excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row, 6, 7));
					excelSheetDef.addCell(new ExcelCellDef("data", row, 6, topTblTotalReSuccess));
					excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row, 8, 9));
					excelSheetDef.addCell(new ExcelCellDef("data", row, 8, topTblTotalFailure));
					excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row, 10, 12));
					excelSheetDef.addCell(new ExcelCellDef("data", row, 10, topTblTotalSum));

					row++;
				}
			} else {
				excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row, 0, 12));
				excelSheetDef.addCell(new ExcelCellDef("data", row, 0, "조회 하신 데이터가 없습니다."));

				row++;
			}

			row++;

			excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row + 1, 0, 0));
			excelSheetDef.addCell(new ExcelCellDef("header", row, 0, "발송월"));

			excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row + 1, 1, 1));
			excelSheetDef.addCell(new ExcelCellDef("header", row, 1, "부서"));

			excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row + 1, 2, 2));
			excelSheetDef.addCell(new ExcelCellDef("header", row, 2, "메시지유형"));

			excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row, 3, 4));
			excelSheetDef.addCell(new ExcelCellDef("header", row, 3, "발송구분(건수)"));

			excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row + 1, 5, 5));
			excelSheetDef.addCell(new ExcelCellDef("header", row, 5, "전체건수"));

			excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row + 1, 6, 6));
			excelSheetDef.addCell(new ExcelCellDef("header", row, 6, "성공률"));

			excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row, 7, 9));
			excelSheetDef.addCell(new ExcelCellDef("header", row, 7, "기본발송"));

			excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row, 10, 12));
			excelSheetDef.addCell(new ExcelCellDef("header", row, 10, "전환발송"));

			excelSheetDef.addCell(new ExcelCellDef("header", row + 1, 3, "마케팅"));
			excelSheetDef.addCell(new ExcelCellDef("header", row + 1, 4, "비마케팅"));
			excelSheetDef.addCell(new ExcelCellDef("header", row + 1, 7, "성공건\n 금액"));
			excelSheetDef.addCell(new ExcelCellDef("header", row + 1, 8, "실패건"));
			excelSheetDef.addCell(new ExcelCellDef("header", row + 1, 9, "성공률"));
			excelSheetDef.addCell(new ExcelCellDef("header", row + 1, 10, "성공건\n 금액"));
			excelSheetDef.addCell(new ExcelCellDef("header", row + 1, 11, "실패건"));
			excelSheetDef.addCell(new ExcelCellDef("header", row + 1, 12, "성공률"));

			row += 2;
		}

		String totalSuccess = "기본발송 성공 총 건수 (성공률)               " + comma(totalCount.getTotalSuccessNumber()) + " 건 ("
				+ (totalCount.getTotalSuccessPercent() == null ? "0" : totalCount.getTotalSuccessPercent()) + "%)"
				+ "\n" + "금액                                   ₩" + comma(totalCount.getSuccessCost());
		String totalReSuccess = "전환발송 성공 총 건수 (성공률)               " + comma(totalCount.getTotalReSuccessNumber())
				+ " 건 (" + (totalCount.getTotalReSuccessPercent() == null ? "0" : totalCount.getTotalReSuccessPercent())
				+ "%)" + "\n" + "금액                                   ₩" + comma(totalCount.getReSuccessCost());
		String totalFailure = "총 실패 건수 (실패율)               " + comma(totalCount.getTotalFailureNumber()) + " 건 ("
				+ (totalCount.getTotalFailurePercent() == null ? "0" : totalCount.getTotalFailurePercent()) + "%)";
		String totalSum = "총 건수 (총 성공률)               " + comma(totalCount.getTotalSendNumber()) + " 건 ("
				+ (totalCount.getTotalPercent() == null ? "0" : totalCount.getTotalPercent()) + "%)";

		if ("department".equals(searchCondition.getStatisticsType())) {
			rowMergeCnt = 0;
			copyRow = 0;

			if (statisticsList.size() > 0) {
				for (int i = 0; i < statisticsList.size(); i++) {
					if (i > 0) {
						String standardYmd = statisticsList.get(i).getStandardYmd(); // 현재 row 발송일/월 값
						String standardYmdPre = statisticsList.get(i - 1).getStandardYmd(); // 이전 row 발송일/월 값

						if (standardYmd.contains(standardYmdPre)) { // 이전 row 값과 같을 때
							rowMergeCnt++;

							if (copyRow == 0) {
								copyRow = row - 1;
							}

							if (i == statisticsList.size() - 1) {
								excelSheetDef.addCellMerge(new ExcelMergeCellDef(copyRow, copyRow + rowMergeCnt, 0, 0));
							}
						} else { // 이전 row와 값이 달라졌을 때
							if (rowMergeCnt > 0) { // 머지할 row 개수 값이 있을 때
								int nextRow = copyRow + rowMergeCnt + 1;

								excelSheetDef.addCellMerge(new ExcelMergeCellDef(copyRow, copyRow + rowMergeCnt, 0, 0));

								if (i == statisticsList.size() - 1) {
									excelSheetDef.addCell(new ExcelCellDef("data", row - 1, 0, getDateFmt(statisticsList.get(i - 1).getStandardYmd())));
								}
								rowMergeCnt = 0;
								copyRow = nextRow;
							}
						}
					} 

					excelSheetDef.addCell(new ExcelCellDef("data", row, 0, getDateFmt(statisticsList.get(i).getStandardYmd())));
					excelSheetDef.addCell(new ExcelCellDef("data", row, 1, statisticsList.get(i).getGroupValue2()));
					excelSheetDef.addCell(new ExcelCellDef("data", row, 2, fmtMsgDstic(statisticsList.get(i).getMsgDstic())));
					excelSheetDef.addCell(new ExcelCellDef("data", row, 3, (statisticsList.get(i).getMarketingCnt() > 0? comma(statisticsList.get(i).getMarketingCnt()): "-")));
					excelSheetDef.addCell(new ExcelCellDef("data", row, 4, (statisticsList.get(i).getNoMarketingCnt() > 0? comma(statisticsList.get(i).getNoMarketingCnt()): "-")));
					excelSheetDef.addCell(new ExcelCellDef("data", row, 5, comma(statisticsList.get(i).getTotalSendNumber())));
					excelSheetDef.addCell(new ExcelCellDef("data", row, 6, statisticsList.get(i).getTotalSuccessPercent() + "%"));
					excelSheetDef.addCell(new ExcelCellDef("data", row, 7, comma(statisticsList.get(i).getSuccessNumber()) + "\n ₩" + comma(statisticsList.get(i).getSuccessCost())));
					excelSheetDef.addCell(new ExcelCellDef("data", row, 8, comma(statisticsList.get(i).getFailureNumber())));
					excelSheetDef.addCell(new ExcelCellDef("data", row, 9, statisticsList.get(i).getSuccessPercent() + "%"));

					if (statisticsList.get(i).getFailureNumber() > 0) {
						excelSheetDef.addCell(new ExcelCellDef("data", row, 10, comma(statisticsList.get(i).getReSuccessNumber()) + "\n ₩" + comma(statisticsList.get(i).getReSuccessCost())));
						excelSheetDef.addCell(new ExcelCellDef("data", row, 11, comma(statisticsList.get(i).getReFailureNumber())));
						excelSheetDef.addCell(new ExcelCellDef("data", row, 12, statisticsList.get(i).getReSuccessPercent() + "%"));
					} else {
						excelSheetDef.addCell(new ExcelCellDef("data", row, 10, "-"));
						excelSheetDef.addCell(new ExcelCellDef("data", row, 11, "-"));
						excelSheetDef.addCell(new ExcelCellDef("data", row, 12, "-"));
					}

					row++;
				}

				excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row, 0, 12));
				excelSheetDef.addCell(new ExcelCellDef("header", row, 0, totalSuccess));

				excelSheetDef.addCellMerge(new ExcelMergeCellDef(row + 1, row + 1, 0, 12));
				excelSheetDef.addCell(new ExcelCellDef("header", row + 1, 0, totalReSuccess));

				excelSheetDef.addCellMerge(new ExcelMergeCellDef(row + 2, row + 2, 0, 12));
				excelSheetDef.addCell(new ExcelCellDef("header", row + 2, 0, totalFailure));

				excelSheetDef.addCellMerge(new ExcelMergeCellDef(row + 3, row + 3, 0, 12));
				excelSheetDef.addCell(new ExcelCellDef("header", row + 3, 0, totalSum));
			} else {
				excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row, 0, 12));
				excelSheetDef.addCell(new ExcelCellDef("data", row, 0, "조회 하신 데이터가 없습니다."));

				row++;

				excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row, 0, 12));
				excelSheetDef.addCell(new ExcelCellDef("header", row, 0, totalSuccess));

				excelSheetDef.addCellMerge(new ExcelMergeCellDef(row + 1, row + 1, 0, 12));
				excelSheetDef.addCell(new ExcelCellDef("header", row + 1, 0, totalReSuccess));

				excelSheetDef.addCellMerge(new ExcelMergeCellDef(row + 2, row + 2, 0, 12));
				excelSheetDef.addCell(new ExcelCellDef("header", row + 2, 0, totalFailure));

				excelSheetDef.addCellMerge(new ExcelMergeCellDef(row + 3, row + 3, 0, 12));
				excelSheetDef.addCell(new ExcelCellDef("header", row + 3, 0, totalSum));
			}
		} else {
			rowMergeCnt = 0;
			copyRow = 0;

			if (statisticsList.size() > 0) {
				for (int i = 0; i < statisticsList.size(); i++) {
					if (i > 0) {
						String standardYmd = statisticsList.get(i).getStandardYmd(); // 현재 row 발송일/월 값
						String standardYmdPre = statisticsList.get(i - 1).getStandardYmd(); // 이전 row 발송일/월 값

						if (standardYmd.contains(standardYmdPre)) { // 이전 row 값과 같을 때
							rowMergeCnt++;

							if (copyRow == 0) {
								copyRow = row - 1;
							}

							if (i == statisticsList.size()-1) {
								excelSheetDef.addCellMerge(new ExcelMergeCellDef(copyRow, copyRow + rowMergeCnt, 0, 0));
							}
						} else { // 이전 row와 값이 달라졌을 때 
							if(rowMergeCnt > 0) { // 머지할 row 개수 값이 있을 때
								int nextRow = copyRow+rowMergeCnt+1;
								  
								excelSheetDef.addCellMerge(new ExcelMergeCellDef(copyRow, copyRow+rowMergeCnt, 0, 0));
								  
								if(i == statisticsList.size()-1) { 
									excelSheetDef.addCell(new ExcelCellDef("data", row-1, 0, getDateFmt(statisticsList.get(i-1).getStandardYmd())));
								}
								  
								rowMergeCnt = 0; 
								copyRow = nextRow; 
							}
						}
					} 

					excelSheetDef.addCell(new ExcelCellDef("data", row, 0, getDateFmt(statisticsList.get(i).getStandardYmd())));
					excelSheetDef.addCell(new ExcelCellDef("data", row, 1, fmtMsgDstic(statisticsList.get(i).getMsgDstic())));
					excelSheetDef.addCell(new ExcelCellDef("data", row, 2, (statisticsList.get(i).getMarketingCnt() > 0? comma(statisticsList.get(i).getMarketingCnt()): "-")));
					excelSheetDef.addCell(new ExcelCellDef("data", row, 3, (statisticsList.get(i).getNoMarketingCnt() > 0? comma(statisticsList.get(i).getNoMarketingCnt()): "-")));
					excelSheetDef.addCell(new ExcelCellDef("data", row, 4, comma(statisticsList.get(i).getTotalSendNumber())));
					excelSheetDef.addCell(new ExcelCellDef("data", row, 5, statisticsList.get(i).getTotalSuccessPercent() + "%"));
					excelSheetDef.addCell(new ExcelCellDef("data", row, 6, comma(statisticsList.get(i).getSuccessNumber()) + "\n ₩" + comma(statisticsList.get(i).getSuccessCost())));
					excelSheetDef.addCell(new ExcelCellDef("data", row, 7, comma(statisticsList.get(i).getFailureNumber())));
					excelSheetDef.addCell(new ExcelCellDef("data", row, 8, statisticsList.get(i).getSuccessPercent() + "%"));

					if (statisticsList.get(i).getFailureNumber() > 0) {
						excelSheetDef.addCell(new ExcelCellDef("data", row, 9, comma(statisticsList.get(i).getReSuccessNumber()) + "\n ₩" + comma(statisticsList.get(i).getReSuccessCost())));
						excelSheetDef.addCell(new ExcelCellDef("data", row, 10, comma(statisticsList.get(i).getReFailureNumber())));
						excelSheetDef.addCell(new ExcelCellDef("data", row, 11, statisticsList.get(i).getReSuccessPercent() + "%"));
					} else {
						excelSheetDef.addCell(new ExcelCellDef("data", row, 9, "-"));
						excelSheetDef.addCell(new ExcelCellDef("data", row, 10, "-"));
						excelSheetDef.addCell(new ExcelCellDef("data", row, 11, "-"));
					}

					row++;
				}

				excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row, 0, 11));
				excelSheetDef.addCell(new ExcelCellDef("header", row, 0, totalSuccess));

				excelSheetDef.addCellMerge(new ExcelMergeCellDef(row + 1, row + 1, 0, 11));
				excelSheetDef.addCell(new ExcelCellDef("header", row + 1, 0, totalReSuccess));

				excelSheetDef.addCellMerge(new ExcelMergeCellDef(row + 2, row + 2, 0, 11));
				excelSheetDef.addCell(new ExcelCellDef("header", row + 2, 0, totalFailure));

				excelSheetDef.addCellMerge(new ExcelMergeCellDef(row + 3, row + 3, 0, 11));
				excelSheetDef.addCell(new ExcelCellDef("header", row + 3, 0, totalSum));

			} else {
				excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row, 0, 11));
				excelSheetDef.addCell(new ExcelCellDef("data", row, 0, "조회 하신 데이터가 없습니다."));

				row++;

				excelSheetDef.addCellMerge(new ExcelMergeCellDef(row, row, 0, 11));
				excelSheetDef.addCell(new ExcelCellDef("header", row, 0, totalSuccess));

				excelSheetDef.addCellMerge(new ExcelMergeCellDef(row + 1, row + 1, 0, 11));
				excelSheetDef.addCell(new ExcelCellDef("header", row + 1, 0, totalReSuccess));

				excelSheetDef.addCellMerge(new ExcelMergeCellDef(row + 2, row + 2, 0, 11));
				excelSheetDef.addCell(new ExcelCellDef("header", row + 2, 0, totalFailure));

				excelSheetDef.addCellMerge(new ExcelMergeCellDef(row + 3, row + 3, 0, 11));
				excelSheetDef.addCell(new ExcelCellDef("header", row + 3, 0, totalSum));
			}

		}

		excelDef.addSheet(excelSheetDef);
		ExcelExportUtil.exportExcel(request, response, excelDef);
	}

	/**
	 * 메시지 타입 세팅
	 * @param msgDstic
	 * @return
	 */
	public String fmtMsgDstic(String msgDstic) {
		if ("SM".equals(msgDstic) || "LM".equals(msgDstic) || "MM".equals(msgDstic)) {
			msgDstic = "문자-" + msgDstic + "S";
		} else if ("KM".equals(msgDstic)) {
			msgDstic = "알림톡";
		} else if ("SR".equals(msgDstic)) {
			msgDstic = "RCS - SMS";
		} else if ("LR".equals(msgDstic)) {
			msgDstic = "RCS - LMS";
		} else if ("MR".equals(msgDstic)) {
			msgDstic = "RCS - MMS";
		} else if ("TR".equals(msgDstic)) {
			msgDstic = "RCS - 템플릿";
		}

		return msgDstic;
	}

	/**
	 * 콤마 표시
	 * @param num
	 * @return
	 */
	public String comma(int num) {
		if (num > 0) {
			String str = Integer.toString(num);
			return str.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ",");
		} else {
			return "0";
		}
	}

	/**
	 * 날짜 포맷 변경
	 * @param str
	 * @return
	 */
	public String getDateFmt(String str) {
		SimpleDateFormat input = null;
		SimpleDateFormat output = null;

		if (str.length() == 8) {
			input = new SimpleDateFormat("yyyyMMdd");
			output = new SimpleDateFormat("yyyy-MM-dd");
		} else if (str.length() == 6) {
			input = new SimpleDateFormat("yyyyMM");
			output = new SimpleDateFormat("yyyy-MM");

		}

		Date newInputDt = null;
		String newOutputDt = "";
		try {
			newInputDt = input.parse(str);
			newOutputDt = output.format(newInputDt);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		return newOutputDt;
	}
}
