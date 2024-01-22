package com.ibk.msg.web.campaign;

import com.ibk.msg.web.user.UserInfo;
import com.ibk.msg.web.user.UserInfoDao;
import com.ibk.msg.web.user.UserInfoSearchCondition;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@RequestMapping(value = "/campaign")
@Controller
public class TestController {

	private static final Logger logger = LoggerFactory.getLogger(TestController.class);

	@Autowired
    private UserInfoDao dao;

	/**
	 * datatables(그리드) 샘플 화면
	 * @param httpSession
	 * @param model
	 * @return
	*/
	@GetMapping("/datatables.ibk")
	public String datatables(HttpSession httpSession, Model model) {
		return "campaign/sample/datatables_sample";
	}

	/**
	 * datatables(그리드) 목록
	 * @param searchCondition 조회조건
	 * @return
	 * @throws Exception
	*/
	@RequestMapping(value="/list.do")
	public @ResponseBody List<UserInfo> getSampleList(UserInfoSearchCondition searchCondition) throws Exception {
		System.out.println("********************* Get datatables sample list *********************");

		System.out.println("search param 1 = " + searchCondition.getSearchUserType());
		System.out.println("search param 2 = " + searchCondition.getSearchWordType());
		System.out.println("search param 3 = " + searchCondition.getSearchWord());

		List<UserInfo> users = new ArrayList<>();
		if(searchCondition.getSearchUserType().equals("param1-1")) {
			/**
			 * datatables 페이징, 건수기능 사용시 모든 데이터 조회해서 넘겨야됨
			 * 쿼리에서 페이징 처리 안됨
			 */
			searchCondition.setCurrentPage(1);
			searchCondition.setPerPage(100);

			users = dao.findUser(searchCondition);
		}

		return users;
	}


}
