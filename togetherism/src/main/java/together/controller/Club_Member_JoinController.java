package together.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import together.dao.EventDAO;
import together.model.ClubDTO;
import together.model.ClubMemberInfo;
import together.model.Club_Member_JoinDTO;
import together.model.EventDTO;
import together.model.MemberDTO;
import together.service.Club_Member_JoinService;
import together.service.EventService;
import together.service.PagingPgm;
import together.service.Photo_BoardService;

@Controller
public class Club_Member_JoinController {

	@Autowired
	private Club_Member_JoinService club_Member_JoinService;
	@Autowired
	private EventService eventService;
	@Autowired
	private Photo_BoardService photo_boardService;

	// 일반 회원 모임 가입
	@RequestMapping(value = "/club_join.do", method = RequestMethod.GET)
	public String clubJoin(@ModelAttribute Club_Member_JoinDTO cmjdto, 
			Model model, HttpSession session) throws Exception {

		int result = 0;
		// 중복 가입 검사 : 모임가입테이블은 중복가입이 가능하므로 중복가입을 방지
		// 1. 세션 구하기 (현재는 Merge 가 안되었으므로 임의로 정함)
		String sess = (String) session.getAttribute("email");
		cmjdto.setMember_email(sess);

		// 넘어오는 값 확인
		System.out.println("가입하려는 모임 번호 : " + cmjdto.getClub_num());
		System.out.println("가입인사 : " + cmjdto.getJoin_hello());
		System.out.println("가입하려는 멤버 이메일 : " + cmjdto.getMember_email());
		model.addAttribute("club_num", cmjdto.getClub_num());

		// 3. 구한 세션으로 select 해서 이미 가입된 회원인지 확인
		Club_Member_JoinDTO cmj = club_Member_JoinService.getJoin(cmjdto);

		if (cmj != null) { // 데이터가 있을때, 즉 중복가입일때
			result = 2;
			model.addAttribute("result", result);
			return "togetherview/join_result"; // 중복가입 메세지
		} else { // 데이터가 없을때 가입 가능

			// 정원이 다 찼는지 확인
			// club 테이블과 연동, merge 후 수정
			ClubDTO clubdto = this.club_Member_JoinService.getClubCont(cmjdto.getClub_num());
			System.out.println(clubdto);

			// 정원이 다 차지 않았을때만 가입 가능
			if (clubdto.getClub_member_count() >= clubdto.getClub_member_limit()) {
				result = 3;
				model.addAttribute("result", result);
				return "togetherview/join_result";
			} else {

				cmjdto.setClub_host_yn("N"); // 여기선 일반 회원 가입이므로 N 로 설정

				// 그 cmjdto 로 club_member_join 테이블에 insert 하기
				result = club_Member_JoinService.clubJoin(cmjdto);
				model.addAttribute("result", result);

				// 그 club 에 멤버수 +1 하기
				// club 테이블 작업, merge 후 수정
				club_Member_JoinService.updateMemberCount(cmjdto.getClub_num());

				return "togetherview/join_result";
			}
		}

	}

	// 가입된 회원 불러오기
	@RequestMapping(value = "/club_member.do", method = RequestMethod.GET)
	public String getclubMember(@RequestParam("club_num") int club_num, Model model) throws Exception {

		// 가입된 회원이 있는 경우 Member 테이블에서 그 사람을 검색해서 닉네임, 프로필 가져오기위해 Member 객체 List 가져오기
		// member 테이블과 club_member_join 테이블을 조인해서 가입인사, 멤버 프사, 멤버 닉네임 가져오기
		List<ClubMemberInfo> cmilist = club_Member_JoinService.getMemberList(club_num);
		System.out.println(cmilist);

		if (cmilist.isEmpty()) {
			int result = 2;
			model.addAttribute("result", result);
		} else {
			model.addAttribute("cmilist", cmilist);
		}
		model.addAttribute("club_num", club_num);
		return "togetherview/joined_member";
	}

	// club 테이블 작업, merge 이후 수정하기
	// 모임 상세정보 가져오기
	@RequestMapping(value = "/club_ct.do", method = RequestMethod.GET)
	public String clubCont(@RequestParam("club_num") int club_num,
			Model model) throws Exception {
		
		ClubDTO club = club_Member_JoinService.getClubCont(club_num);
		model.addAttribute("club", club);

		if(club != null) {
		String clubInfobr = club.getClub_info().replace("\n", "<br>");
		model.addAttribute("clubInfobr", clubInfobr);

		// 이 코드는 수정폼이 아니라 상세정보만 불러오는데 사용된다, 즉 모임 상세페이지로 이동할때만 호출됨
		// 모임 상세페이지로 이동할땐 조회수를 1 증가시켜야함
		// 뒤로가기 했을때도 실행되어 조회수 증가하는건 나중에 처리하기, 목록에서 눌렀을때만 조회수 증가되도록 해보자
		club_Member_JoinService.getUpdateViewCount(club_num);
		
		// 또한 club_num 으로 Event 테이블을 검색해서 해당 club_num 을 가진 이벤트 데이터 List 를 모두 가져오기
		// 맵에 모든 이벤트 지역을 마커로 표시하기 위해 필요
		List<EventDTO> eventlist = eventService.getEventListWithCN(club_num);
		model.addAttribute("eventlist", eventlist);
		
		System.out.println(eventlist);
		
		// 해당 모임의 모임장에 대한 정보도 가져오기
		// 객체 club 에서 모임장 이메일을 가져와서 member 테이블에서 검색
		MemberDTO memberdto = club_Member_JoinService.getMember(club.getClub_host_email());
		model.addAttribute("memberdto", memberdto);
		
		// 해당 모임의 사진 개수 구하기, ajax 로 사진첩 페이징 처리를 하기 위함
		int photoCount = photo_boardService.getPhotoListCount(club_num);
		model.addAttribute("photoCount", photoCount);
		
		int pt = 1;
		if(photoCount % 3 == 0) {
			pt = photoCount / 3;
		} else {
			pt = photoCount / 3 + 1;
		}
		
		model.addAttribute("pt", pt); // ajax 페이징 처리 하기 위해 가져감
		}
		return "togetherview/club_cont";
	}

	// 내가 가입한 모임
	@RequestMapping(value = "/joined_club.do", method = RequestMethod.GET)
	public String joinedClub(Model model, HttpServletRequest request, HttpSession session) throws Exception {

		// 1. 세션 구하기 (현재는 Merge 가 안되었으므로 임의로 정함)
		String sess = (String) session.getAttribute("email");
		//(String) session.getAttribute("email");
		//(String) session.getAttribute("email");
		
		List<ClubDTO> joinedClubList = new ArrayList<ClubDTO>();
		
		int joinedClubPage = 1;
		int limit = 10;
		
		// 페이지 값이 넘어온 경우엔 그 값을 페이지 번호로 지정
		if (request.getParameter("joinedClubPage") != null) {
			joinedClubPage = Integer.parseInt(request.getParameter("joinedClubPage"));
		}
		
		// 페이지 번호 확인
		System.out.println("페이지 : " + joinedClubPage);

		// 총 이벤트 수를 받아옴.
		int listcount = club_Member_JoinService.getjoinedClubListCount(sess);
		System.out.println("총 이벤트 수 " + listcount);
		
		int startRow = (joinedClubPage - 1) * limit + 1; // 1, 11, 21, 31
		int endRow = startRow + limit - 1; // 10, 20, 30, 40
		
		// 나머지 파생변수들을 구함
		PagingPgm pp = new PagingPgm(listcount, limit, joinedClubPage);
		Map<String, Object> map = new HashMap<String, Object>();
		int no = listcount - startRow + 1;		// 화면 출력 번호
		
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("sess",sess);
		joinedClubList = club_Member_JoinService.getJoinedClub(map); // 리스트를 받아옴.
		System.out.println(joinedClubList);
		
		// club 테이블 작업, merge 이후 수정하기
		// 가져온 이벤트 리스트
		model.addAttribute("joinedClubList", joinedClubList);
		// 화면 출력 번호
		model.addAttribute("no", no);
		// 데이터 갯수, 화면에 출력할 데이터 갯수, 블랙덩 페이지 갯수, 현재 페이지 번호,
		// 각 블럭의 시작 페이지, 각 블럭의 끝 페이지, 총 페이지수 
		model.addAttribute("pp", pp);
		// 각 케이스별 페이징 처리를 위해 전달
		model.addAttribute("joinedClubPage", joinedClubPage);

		
		return "togetherview/joined_club_list";
	}

	// 모임 탈퇴
	@RequestMapping(value = "/leave_club.do", method = RequestMethod.GET)
	public String leaveClub(Model model, @ModelAttribute Club_Member_JoinDTO cmjdto, HttpSession session) throws Exception {
		// 1. 세션 구하기 (현재는 Merge 가 안되었으므로 임의로 정함)
		String sess = (String) session.getAttribute("email");
		//(String) session.getAttribute("email");
		//(String) session.getAttribute("email");
		cmjdto.setMember_email(sess);
		int result = 0;

		// 넘어온 값 확인
		System.out.println(cmjdto.getMember_email());
		System.out.println(cmjdto.getClub_num());

		// 모임장인지 확인하고, 모임장이 아닌 경우에만 탈퇴 가능
		String club_host_yn = club_Member_JoinService.getClubHostYN(cmjdto);
		System.out.println(club_host_yn);
		if (club_host_yn != null) {
			if (club_host_yn.equals("Y")) { // 모임장이면 탈퇴 불가, 모임 삭제를 해야하므로
				result = 2;
				model.addAttribute("result", result);
				return "togetherview/leave_club_result";
			} else if (club_host_yn.equals("N")) { // 모임장이 아닌경우 탈퇴 진행

				// 구한 세션으로 Club_Member_Join 테이블에서 해당 이메일인 데이터 삭제
				result = club_Member_JoinService.leaveClub(cmjdto);
				model.addAttribute("result", result);
				model.addAttribute("club_num", cmjdto.getClub_num());

				// 이후 club 테이블에서 update SQL문
				// club 테이블 작업, merge 이후 수정하기
				club_Member_JoinService.minusMemberCount(cmjdto.getClub_num());

				return "togetherview/leave_club_result";
			}
		} else
			result = 3;
		model.addAttribute("result", result);
		return "togetherview/leave_club_result";
	}

	// 내가 운영하는 모임 리스트
	@RequestMapping(value = "/my_club.do", method = RequestMethod.GET)
	public String myClub(Model model, HttpServletRequest request, HttpSession session) throws Exception {

		// 1. 세션 구하기 (현재는 Merge 가 안되었으므로 임의로 정함)
		String sess = (String) session.getAttribute("email");
		//(String) session.getAttribute("email");
	
		List<Club_Member_JoinDTO> myClubList = new ArrayList<Club_Member_JoinDTO>();
		
		int myClubPage = 1;
		int limit = 10;
		
		// 페이지 값이 넘어온 경우엔 그 값을 페이지 번호로 지정
		if (request.getParameter("myClubPage") != null) {
			myClubPage = Integer.parseInt(request.getParameter("myClubPage"));
		}
		
		// 페이지 번호 확인
		System.out.println("페이지 : " + myClubPage);

		// 총 이벤트 수를 받아옴.
		int listcount = club_Member_JoinService.getmyClubListCount(sess);
		System.out.println("총 이벤트 수 " + listcount);
		
		
		int startRow = (myClubPage - 1) * limit + 1; // 1, 11, 21, 31
		int endRow = startRow + limit - 1; // 10, 20, 30, 40
		
		// 나머지 파생변수들을 구함
		PagingPgm pp = new PagingPgm(listcount, limit, myClubPage);
		Map<String, Object> map = new HashMap<String, Object>();
		int no = listcount - startRow + 1;		// 화면 출력 번호
		
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("sess",sess);
		myClubList = club_Member_JoinService.getMyClub(map); // 리스트를 받아옴 1
		System.out.println(myClubList);
		
		model.addAttribute("myClubList", myClubList);
		if(!myClubList.isEmpty()) {
			System.out.println("아웃");
		// club 테이블 작업, merge 이후 수정하기
		List<ClubDTO> joinedClist = club_Member_JoinService.getClubList(myClubList); // 리스트를 받아옴 2
			
		// club 테이블 작업, merge 이후 수정하기
		// 가져온 이벤트 리스트
		model.addAttribute("joinedClist", joinedClist);
		}
		// 화면 출력 번호
		model.addAttribute("no", no);
		// 데이터 갯수, 화면에 출력할 데이터 갯수, 블랙덩 페이지 갯수, 현재 페이지 번호,
		// 각 블럭의 시작 페이지, 각 블럭의 끝 페이지, 총 페이지수 
		model.addAttribute("pp", pp);
		// 각 케이스별 페이징 처리를 위해 전달
		model.addAttribute("myClubPage", myClubPage);
			

		return "togetherview/my_club_list";
	}
	
	// 모임 리스트
	// CLUB 테이블 , merge 후 수정
	@RequestMapping(value="/club_list.do", method = RequestMethod.GET)
	public String clubList(Model model, 
			@RequestParam(value="club_region", required = false) String club_region,
			@RequestParam(value="keyword", required = false) String keyword,
			@RequestParam(value="preview", required = false) String preview,
			HttpServletRequest request) throws Exception {
		
		List<ClubDTO> clublist = new ArrayList<ClubDTO>();
		
		int clubPage = 1;
		int limit = 10;
		
		if(request.getParameter("clubPage") != null) {
			clubPage = Integer.parseInt(request.getParameter("clubPage"));
		}
		
		// 페이지 번호 확인
		System.out.println("페이지 : " + clubPage);
		// 넘어온 값들 확인
		System.out.println("키워드 : " + keyword);
		System.out.println("지역 : " + club_region);
		System.out.println("프리뷰 : " + preview);
		
		if(preview != null) {
			limit = 3;
			model.addAttribute("preview", preview);
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("club_region", club_region);
		
		// 모임 개수 구하기, 전체/키워드/지역별
		int listcount = club_Member_JoinService.getClubListCount(map);
		System.out.println("listcount : " + listcount);
		
		int startRow = (clubPage - 1) * limit + 1; // 1, 11, 21, 31
		int endRow = startRow + limit - 1; // 10, 20, 30, 40
		
		// 나머지 파생변수들을 구함
		PagingPgm pp = new PagingPgm(listcount, limit, clubPage);
		map.put("startRow",startRow);
		map.put("endRow",endRow);
		int no = listcount - startRow + 1;		// 화면 출력 번호
				
		// 모임 리스트 구하기
		clublist = club_Member_JoinService.getClubListAll(map);
		System.out.println(clublist);
		
		// 가져온 모임 리스트
		model.addAttribute("clublist", clublist);
		// 화면 출력 번호
		model.addAttribute("no", no);
		// 데이터 갯수, 화면에 출력할 데이터 갯수, 블랙덩 페이지 갯수, 현재 페이지 번호,
		// 각 블럭의 시작 페이지, 각 블럭의 끝 페이지, 총 페이지수 
		model.addAttribute("pp", pp);
		// 각 케이스별 페이징 처리를 위해 전달
		model.addAttribute("keyword", keyword);
		model.addAttribute("club_region", club_region);

		model.addAttribute("clubPage", clubPage);		
		return "togetherview/club_list";
	
	}
	
	// preview 모임 리스트
	// CLUB 테이블 , merge 후 수정
	@RequestMapping(value="/club_pre_list.do", method = RequestMethod.GET)
	public String clubList(Model model, 
			@RequestParam(value="preview", required = false) String preview,
			HttpServletRequest request) throws Exception {
		
		List<ClubDTO> clubprelist = new ArrayList<ClubDTO>();
		
		// 넘어온 값들 확인
		System.out.println("프리뷰 : " + preview); // not, new, pre
		
		// 1 ~ 9 번까지만 가져오기 , preview 가 pre 일땐 1 ~ 3 까지
				
		// 모임 리스트 구하기
		clubprelist = club_Member_JoinService.getClubListPreview(preview);
		System.out.println("prelist : " +clubprelist);
		
		// 가져온 모임 리스트
		model.addAttribute("clubprelist", clubprelist);
		model.addAttribute("preview", preview);
		
		return "togetherview/club_pre_list"; // 이후 리스트 출력하는 페이지로 가는걸로 수정
	
	}
	
	// 모임장이 멤버 모임 탈퇴시키기
	@RequestMapping(value="/kick_out.do", method = RequestMethod.GET)
	public String kickOut(@RequestParam("member_email") String member_email,
			@RequestParam("club_num") int club_num, Model model, HttpSession session) throws Exception {

		int result = 0;
		model.addAttribute("club_num", club_num);
		
		// 1. 세션을 구해서 모임장인지 확인, 모임장만 내보내기 가능
		String sess = (String) session.getAttribute("email");
		//(String) session.getAttribute("email");

		// member_email, club_num 을 담은 Club_Member_Join DTO 필요
		Club_Member_JoinDTO cmjdto = new Club_Member_JoinDTO();
		cmjdto.setMember_email(sess);
		cmjdto.setClub_num(club_num);
		
		String club_host_yn = club_Member_JoinService.getClubHostYN(cmjdto);

		if(club_host_yn != null && club_host_yn.equals("Y")){ // 모임장이면 내보내기 가능

				// 구한 세션으로 Club_Member_Join 테이블에서 받은이메일인 데이터 삭제
				// 넘어온 member_email, club_num 을 담은 Club_Member_Join DTO 필요함
				// 세션 대신 내보낼 멤버의 이메일로 수정
				cmjdto.setMember_email(member_email);
				result = club_Member_JoinService.leaveClub(cmjdto);
				
				// 이후 club 테이블에서 update SQL문
				// club 테이블 작업, merge 이후 수정하기
				club_Member_JoinService.minusMemberCount(cmjdto.getClub_num());
				
				model.addAttribute("result", result);
				model.addAttribute("club_num", cmjdto.getClub_num());

				return "togetherview/kick_out_result";
				
			} else {
				  // 가입한 상태가 아니거나 모임장이 아니면 내보내기 불가능
					result = 2;
					model.addAttribute("result", result);
					return "togetherview/kick_out_result";
				} 
				
		}
	
		// 메인페이지로 가기
		@RequestMapping(value="/main.do", method = RequestMethod.GET)
		public String mainPage() throws Exception {
			
			return "togetherview/main";
		}
}
