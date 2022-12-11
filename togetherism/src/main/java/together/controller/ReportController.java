package together.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import together.model.ReportDTO;
import together.service.ReportServiceImpl;

@Controller
public class ReportController {
	
	@Autowired
	private ReportServiceImpl reService;
	
	
	/* 신고 전 중복신고 검증: 신고자 유저가 신고당하는 유저를 이전에 신고한 적 없는지  */
	@RequestMapping(value="report_check.do")
	public String report_check(String member_email, HttpSession session,
								Model model) throws Exception{
		
		String report_member_email = (String) session.getAttribute("email");
		//신고하는 사람의 이메일 
		
		ReportDTO report = new ReportDTO();
		report.setMember_email(member_email);
		report.setReport_member_email(report_member_email);
		
		ReportDTO checkR = reService.reportCheck(report);
		// 신고자 유저가 신고당한 유저를 신고했던 이력 결과
		
		model.addAttribute("report", report);
		model.addAttribute("checkR", checkR);
		
		if (checkR != null) {
			return "togetherview/report_result";
		}else {
			return "togetherview/report_form";
		}
		
	}
	
	
	/* 중복 검증 통과한 신고건 신고 등록 */
	@RequestMapping(value="report_ok.do")
	public String report_ok(ReportDTO report,
								Model model) throws Exception {
		
		int insertR = reService.reportInsert(report);
		//신고당하는 사람이 몇번 신고당했는지 카운트
		
		model.addAttribute("insertR", insertR);
		
		
		return "togetherview/report_result";
	}

	
	/* 신고당한 횟수 카운트 */
	@RequestMapping(value="report_count.do")
	public void report_count(String member_email,
								HttpSession session,
								Model model) throws Exception {
		
		int countR = reService.reportCount(member_email);
		//신고당하는 사람이 몇번 신고당했는지 카운트
		
		model.addAttribute("countR", countR);
		
		System.out.println("신고당한 횟수:" + countR);
	}
	
	

						

	
}
