package together.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import together.model.ClubDTO;
import together.model.ClubHeartJoin;
import together.model.HeartDTO;
import together.service.HeartService;
import together.service.PagingPgm;

@Controller
public class HeartController {

	@Autowired
	private HeartService heartservice;
	
	//좋아요 누르면 
	@RequestMapping(value= "insert_heart.do") 
	public String insert_heart(int club_num,  
							   HttpSession session, Model model) throws Exception{
		
		String session_email = (String) session.getAttribute("email");
		
		HeartDTO heartdto = new HeartDTO();
		heartdto.setClub_num(club_num);
		heartdto.setMember_email(session_email);
		
		
		model.addAttribute("club_num", club_num);
		System.out.println("controller in");
		//String email = (String) session.getAttribute("email");
		System.out.println("club_num:"+club_num);
		System.out.println("session_email:"+ session_email);
		
		
		HeartDTO heart = heartservice.heart_check(heartdto);
		
		int result;
		
		if(heart == null) {
			result = heartservice.insertHeart(heartdto);
			System.out.println("좋아요 처리완료");
		}else {
			result = -1;
			model.addAttribute("result", result);
		}
		
		return "togetherview/heartResult";
//		return "togetherview/heart";
	}
	
	//하트 해제 
	@RequestMapping(value ="remove_heart.do")
	public String remove_heart(int club_num, HttpSession session) throws Exception{
	
		String session_email = (String) session.getAttribute("email");
		
		HeartDTO heartdto = new HeartDTO();
		heartdto.setClub_num(club_num);
		heartdto.setMember_email(session_email);
		
		heartservice.removeHeart(heartdto);
		
		return "togetherview/heart";
	}
	
	//내가 좋아요한 모임 목록에서 좋아요 해제 시 
	@RequestMapping(value ="remove1_heart.do")
	public String remove1_heart(int club_num, HttpSession session) throws Exception{
	
		
		String session_email = (String) session.getAttribute("email");
		
		HeartDTO heartdto = new HeartDTO();
		heartdto.setClub_num(club_num);
		heartdto.setMember_email(session_email);
		
		heartservice.removeHeart(heartdto);
		
		return "redirect:/heart_list.do";
	}
	

	// 내가 좋아요한 모임 목록
	@RequestMapping(value = "/heart_list.do")
	public String list(HttpServletRequest request, Model model, HttpSession session) throws Exception {
		System.out.println("heartlist컨트롤러 들어옴");

		
		  int heartPage = 1;
	      int limit = 10;
	      
	      // 페이지 값이 넘어온 경우엔 그 값을 페이지 번호로 지정
	      if (request.getParameter("heartPage") != null) {
	         heartPage = Integer.parseInt(request.getParameter("heartPage"));
	      }
	      
	      String session_email = (String) session.getAttribute("email"); 
	      
	      Map<String, Object> map = new HashMap<String, Object>();
	      map.put("session_email", session_email);
	      
	      // 페이지 번호 확인
	      System.out.println("페이지 : " + heartPage);

	      // 내가 좋아요한 모임의 총 갯수
	      int listcount = heartservice.getHeartListCount(map); 
	      System.out.println("내가 좋아요한 모임의 총 갯수 " + listcount);
	      model.addAttribute("listcount", listcount);
	      
	      int startRow = (heartPage - 1) * limit + 1; // 1, 11, 21, 31
	      int endRow = startRow + limit - 1; // 10, 20, 30, 40
	      
	      // 나머지 파생변수들을 구함
	      PagingPgm pp = new PagingPgm(listcount, limit, heartPage);
	      map.put("startRow",startRow);
	      map.put("endRow",endRow);
	      
	      int no = listcount - startRow + 1;      // 화면 출력 번호
			// 총 페이지 수.
			int maxpage = (int) ((double) listcount / limit + 0.95); // 0.95를 더해서 올림
																		// 처리.
			// 현재 페이지에 보여줄 시작 페이지 수(1, 11, 21 등...)
			int startpage = (((int) ((double) heartPage / 10 + 0.9)) - 1) * 10 + 1;
			System.out.println("Startpage: "+ startpage);
			// 현재 페이지에 보여줄 마지막 페이지 수.(10, 20, 30 등...)
			int endpage = maxpage;

			if (endpage > startpage + 10 - 1)
				endpage = startpage + 10 - 1;
	      
	      List<ClubHeartJoin> heartlist = heartservice.getHeartList(map);
	      
	      model.addAttribute("startpage", startpage);
	      model.addAttribute("endpage", endpage);
	      model.addAttribute("heartlist", heartlist);
	      System.out.println("heartlist: " + heartlist );
	            
	      // 가져온 이벤트 리스트
	      model.addAttribute("heartlist", heartlist);
	      // 화면 출력 번호
	      model.addAttribute("no", no);
	      // 데이터 갯수, 화면에 출력할 데이터 갯수, 블랙덩 페이지 갯수, 현재 페이지 번호,
	      // 각 블럭의 시작 페이지, 각 블럭의 끝 페이지, 총 페이지수 
	      model.addAttribute("pp", pp);


		return "togetherview/heart_list";
	}
	
//	@RequestMapping(value="heart_check.do")
//		public String heart_check(HttpServletRequest request, Model model, HeartDTO heartdto) throws Exception{
//		System.out.println("heart_check 컨트롤러 들어옴");
//
//			HeartDTO heart = heartservice.heart_check(heartdto);
//		
//			int heartresult = 0;
//			
//			if(heart != null) {
//				heartresult = 1;
//			}else {
//				heartresult = 2;
//			}
//			
//			model.addAttribute("heartresult", heartresult);
//		
//		return "togetherview/suc";
//	}
	
	
}
