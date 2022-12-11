package together.controller;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.avalon.framework.service.ServiceManager;
import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
//import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import together.model.ClubDTO;
import together.model.ClubJoinInfo;
import together.model.Club_Member_JoinDTO;
import together.model.EventDTO;
import together.model.Event_User_AttendDTO;
import together.model.ManagerDTO;
import together.model.MemberDTO;
import together.model.MemberReportInfo;
import together.model.ReportDTO;
import together.service.ManagerServiceImpl;

@Controller
public class ManagerController {
	@Autowired
	ManagerServiceImpl managerService;
	
	//관리자 로그인 폼 진입
	@RequestMapping("admin.do")
	public String manager_loginForm () throws Exception {
		System.out.println("관리자 로그인 폼 진입");
		return "togetherview/manager_loginForm";
	}
	
	//관리자 로그인 정보 확인
//	@RequestMapping("manager_login.do")
	@RequestMapping(value= "manager_login.do", method=RequestMethod.POST)
	public String manager_login(String manager_email, 
								String manager_pw, 
								HttpSession session,
								Model model ) throws Exception {
		
		System.out.println("관리자 로그인 실행 메소드 진입");
		
		//관리자 계정 정보 가져오기
		ManagerDTO managerDto = managerService.getManager(manager_email);
		System.out.println(managerDto);
		
		//폼에서 입력한 계정 정보와 DB에서 가져온 계정 정보 비교
		int result = 0;
		
		if ( managerDto == null) {	// DB에 정보가 없을 때
			result = -1;
			model.addAttribute("result", result);
			
			System.out.println("관리자 계정 없음");
			return "togetherview/manager_login_fail";
			
		} else { 					// DB에 정보가 있을 때
			
			if (managerDto.getManager_pw().equals(manager_pw)) {	// 비밀번호 일치
				
				System.out.println("관리자 로그인 성공");
				session.setAttribute("manager_email", manager_email);
				System.out.println("세션 공유 시작");
				
				model.addAttribute("managerDto", managerDto);
				
//				return "togetherview/manager_main";
				return "redirect:manager_main.do";
				
			} else {												// 비밀번호 불일치
				
				System.out.println("관리자 로그인 실패");
				result = 1;
				model.addAttribute("result",result);
				
				return "togetherview/manager_login_fail";
			}
		} // if - else end
	}
	
	//관리자로그인 후 메인 화면 진입
	@RequestMapping("manager_main.do")
	public String manger_main (HttpSession session, Model model) throws Exception {
		
		//로그인 세션 유지
		String manager_email = (String) session.getAttribute("manager_email");
		System.out.println("메인화면 진입");
		
		//2일전, 1일전, 오늘 가입한 회원 수
		int dago2Total = managerService.get2dago();
		int dago1Total = managerService.get1dago();
		int todayTotal = managerService.getToday();
		
		//신고 많이 당한 회원 리스트
		List<MemberReportInfo> reportDto= managerService.getReport();
		int reportRank1 = reportDto.get(0).getReport_count();
		int reportRank2 = reportDto.get(1).getReport_count();
		int reportRank3 = reportDto.get(2).getReport_count();
		int reportRank4 = reportDto.get(3).getReport_count();
		int reportRank5 = reportDto.get(4).getReport_count();
		int reportRank6 = reportDto.get(5).getReport_count();
		String reportName1 = reportDto.get(0).getMember_nickname();
		String reportName2 = reportDto.get(1).getMember_nickname();
		String reportName3 = reportDto.get(2).getMember_nickname();
		String reportName4 = reportDto.get(3).getMember_nickname();
		String reportName5 = reportDto.get(4).getMember_nickname();
		String reportName6 = reportDto.get(5).getMember_nickname();
				
		System.out.println(reportName1+"신고 횟수 : "+reportRank1);
		System.out.println(reportName2+"신고 횟수 : "+reportRank2);
		System.out.println(reportName3+"신고 횟수 : "+reportRank3);
		
		model.addAttribute("dago2Total", dago2Total);
		model.addAttribute("dago1Total", dago1Total);
		model.addAttribute("todayTotal", todayTotal);
		model.addAttribute("reportRank1", reportRank1);
		model.addAttribute("reportRank2", reportRank2);
		model.addAttribute("reportRank3", reportRank3);
		model.addAttribute("reportRank4", reportRank4);
		model.addAttribute("reportRank5", reportRank5);
		model.addAttribute("reportRank6", reportRank6);
		model.addAttribute("reportName1", reportName1);
		model.addAttribute("reportName2", reportName2);
		model.addAttribute("reportName3", reportName3);
		model.addAttribute("reportName4", reportName4);
		model.addAttribute("reportName5", reportName5);
		model.addAttribute("reportName6", reportName6);
		
		return "togetherview/manager_main";
	}
	
	//관리자 로그아웃
	@RequestMapping("manager_logout.do")
	public String manager_logout (HttpSession session) throws Exception {
		
		//세션 종료
		session.invalidate();
		System.out.println("로그아웃 성공");
		
		return "redirect:admin.do";
	}

	//현재 활동중인 회원 리스트
	@RequestMapping("manager_list.do")
	public String mamager_member_n (HttpServletRequest request,
									Model model) throws Exception {
		
		//page : 현재 페이지, limit : 한 화면에 출력할 목록
		int page = 1;
		int limit = 10;
		
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		//현재 활동중인 회원의 수
		int nowMember = managerService.nowMemeber();
		System.out.println("현재 활동중인 회원수: "+nowMember);
		
		//현재 활동중인 회원 목록 가져오기
		List<MemberDTO> nowmemberList = managerService.nowmemberList(page);
		System.out.println("현재 활동중인 회원 목록 구해오기 성공");
		
		//1 블럭당 페이지 개수
		int pageCount = nowMember / limit + ((nowMember%limit == 0) ? 0 : 1);
		int startPage = ((page - 1) / 10) * limit + 1;	// 1, 11, 21,
		int endPage = startPage + 10 - 1;
		
		if (endPage > pageCount) endPage = pageCount;
		
		model.addAttribute("page", page);
		model.addAttribute("nowMember", nowMember);
		model.addAttribute("nowmemberList", nowmemberList);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		
		System.out.println("현재 활동중인 회원 목록 출력 성공");

		return "togetherview/manager_list";
	}
	
	//탈퇴한 회원을 포함한 전체 회원 리스트
	@RequestMapping("manager_delMemberlist.do")
	public String manager_list(HttpServletRequest request, 
							   Model model) throws Exception {
		
		//page : 현재 페이지, limit : 한 화면에 출력할 목록
		int page = 1;
		int limit = 10;
		
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		//탈퇴한 회원을 포함한 전체 회원의 수
		int memberCount = managerService.memberCount();
		System.out.println("탈퇴한 회원을 포함한 전체 회원의 수: "+memberCount);
		
		//탈퇴한 회원을 포함한 전체 회원 목록 가져오기
		List<MemberDTO> memberList = managerService.memberList(page);
		System.out.println("탈퇴한 회원을 포함한 전체 회원 목록 구해오기 성공");
		
		//1 블럭당 페이지 개수
		int pageCount = memberCount / limit + ((memberCount%limit == 0) ? 0 : 1);
		int startPage = ((page - 1) / 10) * limit + 1;	// 1, 11, 21,
		int endPage = startPage + 10 - 1;
		
		if (endPage > pageCount) endPage = pageCount;
		
		model.addAttribute("page", page);
		model.addAttribute("memberCount", memberCount);
		model.addAttribute("memberList", memberList);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		
		System.out.println("탈퇴한 회원을 포함한 전체 회원 목록 출력 성공");
		
//		if(page == 1)
		
		return "togetherview/manager_delMemberlist";
	}
	
	//검색 페이지 출력
	@RequestMapping("manager_listSearch.do")
	public String manager_listSearch (MemberDTO memberDto,
									  HttpServletRequest request,
									  Model model) throws Exception {

		//page : 현재 페이지, limit : 한 화면에 출력할 목록
		int page = 1;
		int limit = 10;
		
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		//이메일, 닉네임 검색 목록 가져오기
		List<MemberDTO> searchList = managerService.getSearch(memberDto);
		System.out.println("검색한 회원 목록 구해오기 성공");
		
		//검색 결과 회원 수
		int searchCount = searchList.size();
		System.out.println("검색 결과 구해오기 성공 : "+ searchCount);
		
		String search = memberDto.getSearch();
		String keyword = memberDto.getKeyword();
		System.out.println("분류 : "+memberDto.getSearch());
		System.out.println("키워드 : "+memberDto.getKeyword());
		
		//1 블럭당 페이지 개수
		int pageCount = searchCount / limit + ((searchCount%limit == 0) ? 0 : 1);
		int startPage = ((page - 1) / 10) * limit + 1;	// 1, 11, 21,
		int endPage = startPage + 10 - 1;
		
		if (endPage > pageCount) endPage = pageCount;
		
		model.addAttribute("search", search);
		model.addAttribute("keyword", keyword);
		model.addAttribute("page", page);
		model.addAttribute("searchList", searchList);
		model.addAttribute("searchCount", searchCount);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		
		return "togetherview/manager_listSearch";
	}
	
	//회원 1명의 상세정보
	@RequestMapping("manager_deleteForm.do")
	public String manager_memberView (MemberDTO member_email, 
									  Model model) throws Exception {
		
		System.out.println("회원 상세정보 컨트롤러 진입");
		
		//특정 회원 1명의 정보 가져오기
		MemberDTO memberDto = managerService.getMember(member_email);
		System.out.println("회원 상세정보 구해오기 성공");
		
		//특정 회원 1명의 신고 횟수 가져오기
		int reportCount = managerService.reportCount(member_email);
		System.out.println("신고 횟수 구해오기 성공");
		
		//특정 회원의 모임장 리스트 가져오기
		List<ClubDTO> clubDto = managerService.getClub(member_email); 
		System.out.println("개설한 모임 목록 구해오기 성공");
		//개설한 (모임장인) 모임의 수
		int clubList = clubDto.size();
		System.out.println("개설한 모임의 수 :"+clubDto.size());
		for (int i=0; i<clubList; i++) {
			System.out.println("개설한 모임 목록 :"+clubDto.get(i).getClub_name());
		}

		//특정 회원의 가입 모임 리스트 가져오기
		List<ClubJoinInfo> cjiDto = managerService.getJoinclub(member_email);
		//특정 회원이 가입한 모임의 수
		int cjiList = cjiDto.size();
		
		//특정 회원이 참석한 이벤트 목록에서 event_num을 구해온다
		List<Event_User_AttendDTO> euaDto = managerService.getAttendevent(member_email);
		//특정 회원이 참석한 이벤트 수
		int euaCount = euaDto.size();
		
		for (int i=0; i<euaCount; i++) {
			System.out.println(memberDto.getMember_nickname()+"가 참여한 event_num"+i+" : " + euaDto.get(i).getEvent_num());
		}
		
		//특정 회원이 참석한 이벤트 목록
//		if( euaDto != null ) {
//			
////			int i=0;
////			while( 0 < euaCount) {
////				List<EventDTO> eventDto = managerService.getEvent(euaDto.get(i).getEvent_num());
////			}
//			
//			for (int i=0; i<euaCount; i++) {
//				List<EventDTO> eventDto = managerService.getEvent(euaDto.get(i).getEvent_num());
//				System.out.println(memberDto.getMember_nickname()+"가 참여한 event_num"+i+" : " + eventDto.get(i).getEvent_title());
//				model.addAttribute("eventDto", eventDto);
//			}
//			
//		}
		
		model.addAttribute("memberDto", memberDto);
		model.addAttribute("clubDto", clubDto);
		model.addAttribute("reportCount", reportCount);
		model.addAttribute("clubList", clubList);
		model.addAttribute("cjiDto", cjiDto);
		model.addAttribute("cjiList", cjiList);
		model.addAttribute("euaDto", euaDto);
		model.addAttribute("euaCount", euaCount);
//		model.addAttribute("eventDto", eventDto);
		
		return "togetherview/manager_deleteForm";
	}
	
	//회원 1명 강제탈퇴 시키기 (member_del_yn 컬럼 값 변경)
	@RequestMapping("manager_delete.do")
	public String manager_delete (MemberDTO memberDto, 
								  Model model) throws Exception {
		
		System.out.println("회원 삭제 메소드 진입");
		
		//특정 회원 강제 탈퇴
		managerService.memberDelete(memberDto);
		System.out.println("회원 강제탈퇴 성공");
		
		return "togetherview/manager_delete";
	}
	
	//Q&A 페이지 진입
	@RequestMapping("qna.do")
	public String qna (HttpSession session, Model model) throws Exception {
		System.out.println("Q&A 페이지 진입");
			
		//세션 연결이 유지될 경우 세션 값으로 회원 정보 구해오기
		String email = (String) session.getAttribute("email");
			
		if (email != null) {
					
			MemberDTO old = new MemberDTO();
			old.setMember_email(email);
			MemberDTO memberDto = managerService.getMember(old);
				
			System.out.println("세션 정보로 회원 구해오기 성공");
				
			model.addAttribute("memberDto", memberDto);
		}
				
		System.out.println("세션 정보가 없는 비회원입니다");

		return "togetherview/qna";
	}
	
	//Q&A 메일 전송 미리보기
	@RequestMapping("qna_beforeMail.do")
	public String before_mail (String qna_category,
							   String member_nickname,
							   String member_email,
							   String mail_subject,
							   String mail_content,
							   Model model) throws Exception {
		
		model.addAttribute("qna_category", qna_category);
		model.addAttribute("member_nickname", member_nickname);
		model.addAttribute("member_email", member_email);
		model.addAttribute("mail_subject", mail_subject);
		model.addAttribute("mail_content", mail_content);
		
		return "togetherview/qna_beforeMail";
	}
	
	//Q&A 페이지에서 메일 전송 요청
	@RequestMapping(value= "mail.do", method = RequestMethod.POST)
	public String mail (String qna_category,
						String member_nickname,
						String member_email,
						String mail_subject,
						String mail_content,
						HttpServletResponse response, 
						Model model) throws Exception {
		
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		System.out.println("메일 보내기 진입");
		
		System.out.println("분류:"+qna_category);
		System.out.println("작성자:"+member_nickname);
		System.out.println("메일주소:"+member_email);
		System.out.println("제목:"+mail_subject);
		
		//문의 내용 줄바꿈
		String mail_content1 = mail_content.replace("\n", "<br>");
		
		/*
		 * 관리자에게 이용자 문의 발송
		 */
		
		String charSet = "utf-8";
		String hostSMTP = "smtp.naver.com";
		String hostSMTPid = "이메일주소";	// 메일주소 입력
		String hostSMTPpwd = "비번"; 		// 로그인 비밀번호 입력

		// 보내는 사람 EMail, 제목, 내용
		String fromEmail = hostSMTPid;	// 관리자 이메일
		String fromName = "관리자";	// 관리자 발송 이름
		String subject = "["+qna_category+"] "+mail_subject;	// 문의 메일 제목
		String content = mail_content1;	// 문의 메일 내용

		// 받는 사람 E-Mail 주소
		String mail = hostSMTPid;
		String nickname = fromName;

		try {
			HtmlEmail email = new HtmlEmail();
			email.setDebug(true);
			email.setCharset(charSet);
			email.setSSL(true);
			email.setHostName(hostSMTP);
			email.setSmtpPort(465);

			email.setAuthentication(hostSMTPid, hostSMTPpwd);
			email.setTLS(true);
			email.addTo(fromEmail, fromName, charSet);
			email.setFrom(fromEmail, member_nickname, charSet);
			email.setSubject(subject);
			email.setHtmlMsg(content);		// 발송 완료 메일 본문
			email.send();
			
		} catch (Exception e) {
			System.out.println(e);
		}		
		
		/*
		 * 문의 접수 안내 메일 
		 */
		
		// Mail Server 설정
		String admin_charSet = "utf-8";
		String admin_hostSMTP = "smtp.naver.com";
		String admin_hostSMTPid = "이메일주소";	// 메일주소 입력
		String admin_hostSMTPpwd = "비번"; 		// 로그인 비밀번호 입력

		// 보내는 사람 EMail, 제목, 내용
		// 발송 완료 안내메일
		String admin_fromEmail = hostSMTPid;	// 관리자 이메일
		String admin_fromName = "관리자";	// 관리자 발송 이름
		String admin_subject = "[Togetherism] 문의 메일이 발송 완료 되었습니다.";	// 관리자 메일 제목
		String admin_content = "내용을 확인 후 회신 드리겠습니다. 감사합니다.";	// 관리자 메일 내용

		// 받는 사람 E-Mail 주소
		String admin_mail = member_email;
		String admin_nickname = member_nickname;

		try {
			HtmlEmail email = new HtmlEmail();
			email.setDebug(true);
			email.setCharset(admin_charSet);
			email.setSSL(true);
			email.setHostName(admin_hostSMTP);
			email.setSmtpPort(465);

			email.setAuthentication(admin_hostSMTPid, admin_hostSMTPpwd);
			email.setTLS(true);
			email.addTo(admin_mail, member_nickname, admin_charSet);
			email.setFrom(admin_fromEmail, admin_fromName, admin_charSet);
			email.setSubject(admin_subject);
			email.setHtmlMsg(admin_content);		// 발송 완료 메일 본문
			email.send();
			
		} catch (Exception e) {
			System.out.println(e);
		}
		
		model.addAttribute("qna_category", qna_category);
		model.addAttribute("member_nickname", member_nickname);
		model.addAttribute("member_email", member_email);
		model.addAttribute("mail_subject", mail_subject);
		model.addAttribute("mail_content1", mail_content1);
		
		return "togetherview/qna_mailResult";
	}
	
	//about 페이지 진입
	@RequestMapping("about.do")
	public String about () {
		return "togetherview/about";
	}
}
