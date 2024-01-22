package com.ibk.msg.web.notice;

import java.util.List;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class NoticeController {

	@Autowired
	private NoticeService noticeService;

	@GetMapping("/admin/notice.ibk")
	public String viewListJsp() {
		return "notice/notice-list";
	}

	// 등록 수정 상세 페이지를 같이 사용 합니다.
	@GetMapping("/admin/notice-detail.ibk")
	public ModelAndView viewDetailJsp(
			@RequestParam(value = "id", required = false) String noticeId) {
		ModelAndView mav = new ModelAndView();
		if (StringUtils.isNotBlank(noticeId)) {
			Notice notice = noticeService.findDetail(noticeId);
			mav.addObject("notice", notice);
			mav.addObject("viewType", "modify");
		}
		mav.setViewName("notice/notice-detail");
		return mav;
	}

	@GetMapping("/notice")
	@ResponseBody
	public Object findByPagination(NoticeSearchCondition searchCondition) throws Exception {
		return noticeService.findByPagination(searchCondition);
	}

	@GetMapping("/notice/{noticeId}")
	@ResponseBody
	public Object findDetail(@PathVariable("noticeId") String noticeId) throws Exception {
		return noticeService.findDetail(noticeId);
	}

	@PostMapping(value = "/notice", produces = {"application/json"})
	@ResponseBody
	@ResponseStatus(HttpStatus.CREATED)
	public Object add(@RequestBody Notice notice, HttpSession session) throws Exception {
		notice.setWriter(getWriter(session));
		return noticeService.add(notice);
	}

	@PostMapping(value = "/notices", produces = {"application/json"})
	@ResponseBody
	@ResponseStatus(HttpStatus.CREATED)
	public Object addNotices(@RequestBody List<Notice> notice, HttpSession session) throws Exception {
		return noticeService.addList(notice);
	}

	@PutMapping(value = "/notice/{noticeId}", produces = {"application/json"})
	@ResponseBody
	@ResponseStatus(HttpStatus.OK)
	public Object modify(@PathVariable("noticeId") int noticeId
			, @RequestBody Notice notice, HttpSession session) throws Exception {
		notice.setWriter(getWriter(session));
		notice.setId(noticeId);
		return noticeService.modify(notice);
	}

	@DeleteMapping("/notice/{id}")
	@ResponseBody
	public Object remove(@PathVariable("id") int[] noticeIdArr) throws Exception {
		return noticeService.remove(noticeIdArr);
	}

	private String getWriter(HttpSession session) {
		return (String) session.getAttribute("EMPL_NAME");
	}

}
