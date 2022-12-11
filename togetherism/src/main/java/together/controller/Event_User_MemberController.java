package together.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import together.model.Club_Member_JoinDTO;
import together.model.EventDTO;
import together.model.Event_User_AttendDTO;
import together.service.Event_User_AttendServiceImpl;
import together.service.PagingPgm;

@Controller
public class Event_User_MemberController {
	
	@Autowired
	private Event_User_AttendServiceImpl euaService;
	

	
	/* 선택한 이벤트 참석 이력 */
	@RequestMapping(value = "/event_user_attend_ok.do", method = RequestMethod.GET)
	public String event_user_attend_ok(int event_num,
											int club_num,
											HttpSession session,
											Model model) throws Exception{
		int result = 0; 		
		String email = (String) session.getAttribute("email");

		
		//모임 가입 여부 검색
		Club_Member_JoinDTO cmjdto = new Club_Member_JoinDTO();
		cmjdto.setClub_num(club_num);
		cmjdto.setMember_email(email);
		Club_Member_JoinDTO join = euaService.joinCheck(cmjdto);
		
		
		
		if(join != null) {	// 모임에 가입한 사람
			Event_User_AttendDTO euadto = new Event_User_AttendDTO();
			euadto.setEvent_num(event_num);
			euadto.setMember_email(email);
			Event_User_AttendDTO attend = euaService.attendCheck(euadto);
			
			if(attend == null ) {	// 모임에 가입했는데 이벤트에 참석하지 않은 사람
				result = euaService.attendInsert(euadto);
				
			}else {					// 모임에 가입했는데 이벤트에 참석한 사람
				result = 2;
				
			}
		}// 모임에 가입하지 않은 사람: result = 0
		
		
		model.addAttribute("result", result);
		model.addAttribute("event_num", event_num);
		model.addAttribute("club_num", club_num);
		
		return "togetherview/Event_User_Attend_result";
	}
	
	
	/* 이벤트 참여 취소 */
	@RequestMapping(value = "/event_user_attend_no.do", method = RequestMethod.GET)
	public String event_user_attend_no(int event_num,
										int club_num,
										HttpSession session,
										Model model) throws Exception{
		
		String email = (String) session.getAttribute("email");
		
		Event_User_AttendDTO euadto = new Event_User_AttendDTO();
		euadto.setEvent_num(event_num);
		euadto.setMember_email(email);
		
		euaService.attendDelete(euadto);
		int result = 3;
		
		model.addAttribute("result", result);
		model.addAttribute("event_num", event_num);
		model.addAttribute("club_num", club_num);
		
		return "togetherview/Event_User_Attend_result";
	}
	
	
	/* 내가 참여한 모든 이벤트 리스트 출력 */
	@RequestMapping(value="/event_user_attend_mylistPaging.do")
	public String event_user_attend_mylist(HttpSession session,
											HttpServletRequest request,
											Model model) throws Exception{
		
		int attendPage = 1;
	    int limit = 10;
	    String email = (String) session.getAttribute("email");
		
		if (request.getParameter("attendPage") != null) {
	         attendPage = Integer.parseInt(request.getParameter("attendPage"));
	      }
		
		// 페이지 번호 확인
	    System.out.println("페이지 : " + attendPage);
	    
	    // 총 이벤트 수를 받아옴.
	    int listcount = euaService.attendMylistCount(email);
	    System.out.println("총 참여한 이벤트 수 " + listcount);
	      
	    int startRow = (attendPage - 1) * limit + 1; 	// 1, 11, 21, 31
	    int endRow = startRow + limit - 1; 			// 10, 20, 30, 40
	      
	    // 나머지 파생변수들을 구함
	    PagingPgm pp = new PagingPgm(listcount, limit, attendPage);
	    
	    HashMap<String, Object> hm=new HashMap<String, Object>();
		hm.put("startRow",startRow);
		hm.put("endRow", endRow);
		hm.put("email", email);

	    int no = listcount - startRow + 1;      					  // 화면 출력 번호
	    
	    List<EventDTO> attendMylist = euaService.attendMylist(hm); // 리스트를 받아옴
	    System.out.println(attendMylist);
		
	    //가져온 참여한 이벤트 리스트 목록
		model.addAttribute("attendMylist", attendMylist);
		
		//화면 출력번호
		model.addAttribute("no", no);
		
		//데이터 갯수, 화면에 출력할 데이터 갯수, 각 블럭의 페이지 갯수, 현재 페이지 번호
		// 각 블럭의 시작 페이지, 각 블럭의 끝 페이지, 총 페이지수 
		model.addAttribute("pp", pp);
		
		
		model.addAttribute("attendPage", attendPage);
		
		
		return "togetherview/Event_User_Attend_mylist";
	}
	
	
}
