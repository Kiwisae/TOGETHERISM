package together.controller;

import java.io.File;
import java.util.List;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import together.model.Club_Member_JoinDTO;
import together.model.MemberDTO;
import together.service.Event_User_AttendServiceImpl;
import together.service.MemberServiceImpl;


@Controller
public class MemberController {

	@Autowired
	private MemberServiceImpl memberService;
	
	
	/* 헤더부분 처리 */
	@RequestMapping(value="/header_member.do")
	public String header(HttpSession session, Model model) throws Exception {
		
		String email = (String) session.getAttribute("email");
	
		
		if(email==null) {
			model.addAttribute("header_result", "null");
		}else {
			MemberDTO header_result = memberService.userCheck(email);
			model.addAttribute("header_result", header_result);
		}
		
		return "include/header_member";
	}
	
	
	/* ID중복검사 ajax함수로 처리부분 */
	@RequestMapping(value = "/member_emailcheck.do")
	public String member_idcheck(@RequestParam("mememail") String member_email,
								 Model model) throws Exception {
	
		int result = memberService.checkMemberEmail(member_email);
		model.addAttribute("result", result);
		
		return "togetherview/member_idcheckResult";
	}
	
	
	/* nickname 중복검사 ajax함수로 처리부분 */
	@RequestMapping(value = "/member_nickcheck.do")
	public String member_nickcheck(@RequestParam("memnick") String member_nickname,
									Model model) throws Exception {
		int result = memberService.checkMemberNickname(member_nickname);
		model.addAttribute("result", result);
		
		return "togetherview/member_nickcheckResult";
	}
	
	
	/* 로그인 폼 뷰 */
	@RequestMapping(value = "/member_login.do")
	public String member_login() {
		return "togetherview/member_login";
		// togetherview 폴더의 member_login 뷰 페이지 실행
	}
	
	
	/* email 찾기 폼 뷰*/
	@RequestMapping(value = "/member_emailfind.do")
	public String member_emailFind() {
		return "togetherview/member_emailFind";
		// togetherview 폴더의 member_emailFind 뷰 페이지 실행
	}
	
	
	/* email 찾기 완료  */
	@RequestMapping(value = "/member_emailfind_ok.do")
	public String member_emailfind_ok(@ModelAttribute MemberDTO member, Model model) throws Exception {
		
		MemberDTO old = memberService.findemail(member);

		if (old == null) {// 값이 없는 경우

			return "togetherview/member_emailResult";

		} else {

			model.addAttribute("old", old);
			return "togetherview/member_emailFind";

		}
	}
	
	
	/* 비밀번호 찾기 폼 뷰 */
	@RequestMapping(value = "/member_pwfind.do")
	public String member_pwfind() {
		return "togetherview/member_pwFind";
		// togetherview 폴더의 member_pwFind 뷰 페이지 실행
	}
	
	
	/* 비밀번호 찾기 완료  */
	@RequestMapping(value = "/member_pwfind_ok.do")
	public String member_pwfind_ok(@ModelAttribute MemberDTO member, Model model) throws Exception {
		
		MemberDTO old = memberService.findPwd(member);

		if (old == null) {// 값이 없는 경우

			return "togetherview/member_pwResult";

		} else {

			// Mail Server 설정
			String charSet = "utf-8";
			String hostSMTP = "smtp.naver.com";
			String hostSMTPid = "이메일주소";
			String hostSMTPpwd = "비밀번호"; // 비밀번호 입력해야함

			// 보내는 사람 EMail, 제목, 내용
			String fromEmail = "이메일주소";
			String fromName = "관리자";
			String subject = "비밀번호 찾기";

			// 받는 사람 E-Mail 주소
			String mail = old.getMember_email();

			try {
				HtmlEmail email = new HtmlEmail();
				email.setDebug(true);
				email.setCharset(charSet);
				email.setSSL(true);
				email.setHostName(hostSMTP);
				email.setSmtpPort(587);

				email.setAuthentication(hostSMTPid, hostSMTPpwd);
				email.setTLS(true);
				email.addTo(mail, charSet);
				email.setFrom(fromEmail, fromName, charSet);
				email.setSubject(subject);
				email.setHtmlMsg("<p align = 'center'>비밀번호 찾기</p><br>" + "<div align='center'> 비밀번호 : "
						+ old.getMember_pw() + "</div>");
				email.send();
			} catch (Exception e) {
				System.out.println(e);
			}

			model.addAttribute("pwdok", "등록된 email로 등록된 비밀번호를 발송했습니다. email 수신함을 확인하세요~!!\"");
			return "togetherview/member_pwFind";

		}
	}
	
	
	/* 회원가입 폼 */
	@RequestMapping(value = "/member_signup.do")
	public String member_signup() {
		System.out.println("member_signup.do컨트롤러");
		return "togetherview/member_signup";
		// togetherview 폴더의 member_signup 뷰 페이지 실행
	}
	
	
	/* 회원가입 저장 */
	@RequestMapping(value = "/member_signup_ok.do")
	public String member_signup_ok(@RequestParam("member_image1") MultipartFile mf,
								   @RequestParam("email_id") String email_id,
								   @RequestParam("email_domain") String email_domain,
									MemberDTO member,
									HttpServletRequest request,
									Model model) throws Exception{
		System.out.println("member_signup_ok 컨트롤러");
		
		String filename = mf.getOriginalFilename();
		int size = (int) mf.getSize(); 	// 첨부파일의 크기 (단위:Byte) 

		String path = request.getRealPath("upload");
		System.out.println("mf=" + mf);
		System.out.println("filename=" + filename); // filename="Koala.jpg"
		System.out.println("size=" + size);
		System.out.println("Path=" + path);
		int result=0;
		
		String file[] = new String[2];
		
		String newfilename = "";
	
		if(size > 0){	 // 첨부파일이 전송된 경우	
			
			// 파일 중복문제 해결
			String extension = filename.substring(filename.lastIndexOf("."));
			System.out.println("extension:"+extension);
			
			UUID uuid = UUID.randomUUID();
			
			newfilename = uuid.toString() + extension;
			System.out.println("newfilename:"+newfilename);		
			
			StringTokenizer st = new StringTokenizer(filename, ".");
			file[0] = st.nextToken();		// 파일명		Koala
			file[1] = st.nextToken();		// 확장자	    jpg
			
			if(size > 1000000){				// 100KB
				result=1;
				model.addAttribute("result", result);
				
				return "togetherview/member_uploadResult";
				
			}else if(!file[1].equals("jpg") &&
					 !file[1].equals("gif") &&
					 !file[1].equals("png") ){
				
				result=2;
				model.addAttribute("result", result);
				
				return "togetherview/member_uploadResult";
			}
		}	

		if (size > 0) { // 첨부파일이 전송된 경우
	
				mf.transferTo(new File(path + "/" + newfilename));
	
			}
		
		String mail_id = email_id.trim();
		String mail_domain = email_domain.trim();
		String mail_email = mail_id + "@" + mail_domain;
		
		
			member.setMember_email(mail_email);
			member.setMember_image(newfilename);
	
			memberService.insertMember(member);
	
			return "togetherview/member_signupResult";
		}
	
	
	/* 로그인 인증 */
	@RequestMapping(value = "/member_login_ok.do", method = RequestMethod.POST)
	public String member_login_ok(@RequestParam("login_email") String email, 
									@RequestParam("login_pw")String pw,
									HttpSession session, 
									Model model) throws Exception {
		int result=0;		
		MemberDTO member = memberService.userCheck(email);

		if (member == null) {	// 등록되지 않은 회원일때
			
			result = 1;
			model.addAttribute("result", result);
			
			return "togetherview/member_loginResult";
			
		} else {			// 등록된 회원일때
			if (member.getMember_pw().equals(pw)) {// 비번이 같을때
				
				session.setAttribute("email", email);

				String member_nickname = member.getMember_nickname();
				String member_image = member.getMember_image();

				model.addAttribute("member_nickname", member_nickname);
				model.addAttribute("member_image", member_image);

				return "redirect: main.do";
				
			} else {// 비번이 다를때
				result = 2;
				model.addAttribute("result", result);
				
				return "togetherview/member_loginResult";				
			}
		}
	}
	
	
	/* 회원정보 수정 폼 뷰 */
	@RequestMapping(value = "/member_edit.do")
	public String member_edit(HttpSession session, Model model) throws Exception {

		String email = (String) session.getAttribute("email");

		MemberDTO member = memberService.userCheck(email);

		model.addAttribute("member", member);

		return "togetherview/member_edit";
	}
	
	
	/* 회원정보 수정(fileupload) */
	@RequestMapping(value = "/member_edit_ok.do", method = RequestMethod.POST)
	public String member_edit_ok(@RequestParam("member_image1") MultipartFile mf, 
								 MemberDTO member,
								 HttpServletRequest request, 
								 HttpSession session, 
								 Model model) throws Exception {

		String filename = mf.getOriginalFilename();
		int size = (int) mf.getSize();		
		
		String path = request.getRealPath("upload");
		System.out.println("path:"+path);
		
		int result=0;		
		String file[] = new String[2];
		String newfilename = "";
		
		
		if(size > 0){	 // 첨부파일이 전송된 경우		
			
			// 파일 중복문제 해결
			String extension = filename.substring(filename.lastIndexOf("."), filename.length());
			System.out.println("extension:"+extension);
					
			UUID uuid = UUID.randomUUID();
					
			newfilename = uuid.toString() + extension;
			System.out.println("newfilename:"+newfilename);			
			
			StringTokenizer st = new StringTokenizer(filename, ".");
			file[0] = st.nextToken();		// 파일명
			file[1] = st.nextToken();		// 확장자	
			
			if(size > 1000000){
				result=1;
				model.addAttribute("result", result);
				
				return "togetherview/member_uploadResult";
				
			}else if(!file[1].equals("jpg") &&
					 !file[1].equals("gif") &&
					 !file[1].equals("png") ){
				
				result=2;
				model.addAttribute("result", result);
				
				return "togetherview/member_uploadResult";
			}	
		}
		
		
		if (size > 0) { // 첨부파일이 전송된 경우
			mf.transferTo(new File(path + "/" + newfilename));
		}		

		
		String email = (String) session.getAttribute("email");

		MemberDTO old = memberService.userCheck(email);
		System.out.println("editm:"+old);
		
		
		if (size > 0 ) { 			// 첨부 파일이 수정되면
			member.setMember_image(newfilename);
		} else { 					// 첨부파일이 수정되지 않으면
			member.setMember_image(old.getMember_image());
		}

		memberService.updateMember(member);// 수정 메서드 호출

		model.addAttribute("member_nickname", member.getMember_nickname());
		model.addAttribute("member_image", member.getMember_image());

		return "redirect: joined_club.do";
	}
	
	
	/* 회원정보 삭제 폼 뷰 */
	@RequestMapping(value = "/member_delete.do")
	public String member_del(HttpSession session, Model model) throws Exception {

		String email = (String) session.getAttribute("email");
		MemberDTO member = memberService.userCheck(email);
		model.addAttribute("d_email", member.getMember_email());
		model.addAttribute("d_nickname", member.getMember_nickname());

		return "togetherview/member_delete";
	}
	
	
	/* 회원정보 삭제 */
	@RequestMapping(value = "/member_delete_ok.do")
	public String member_del_ok(String member_pw, String member_del_reason,
								Model model,
							    HttpSession session) throws Exception {
		int result = 0;
		
		String email = (String) session.getAttribute("email");
		
		List<Club_Member_JoinDTO> hostyn = memberService.checkHost(email);
		
		System.out.println(hostyn);
		
		//비번 비교를 위해 정보 불러옴
		MemberDTO old = memberService.userCheck(email);
		

		if (!(hostyn.isEmpty())) {		// 모임장일 경우
			model.addAttribute("result", result);
			return "togetherview/member_deleteResult";
			
		}else {
			if(!old.getMember_pw().equals(member_pw)) {	// 비번 불일치
				result = 1;
				model.addAttribute("result", result);
				return "togetherview/member_deleteResult";
				
			}else {												// 비번 일치
				
				MemberDTO member = new MemberDTO();
				member.setMember_email(email);;
				member.setMember_del_reason(member_del_reason);;
				
				
				//1. 모임가입 삭제
				memberService.deleteJoinclub(email);
				
				//2. 탈퇴하는 회원이 가입한 모임들의 현재 정원을 -1명 시키기
				memberService.reduceClubmemeber(email);
				
				//3. 좋아요 삭제
				memberService.deleteHeart(email);
				
				//4. 이벤트 참석 삭제
				memberService.deleteEventattend(email);
				

				memberService.deleteMember(member);// 삭제 메서드 호출
				
				result = 2;
				
				model.addAttribute("result", result);

				session.invalidate();	// 세션만료

				return "togetherview/member_deleteResult";
			}
		}
	}
	
	
	/* 로그아웃 */
	@RequestMapping("member_logout.do")
	public String logout(HttpSession session) {
		session.invalidate();

		return "togetherview/member_logout";
	}
}
