package together.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.w3c.dom.events.Event;

import together.model.ClubDTO;
import together.model.EventDTO;
import together.service.Club_Member_JoinService;
import together.service.EventService;
import together.service.PagingPgm;
import together.service.SampleService;

@Controller
public class EventController {

	@Autowired
	private EventService eventService;
	@Autowired
	private Club_Member_JoinService club_Member_JoinService;
	
	// 이벤트 만들기 폼으로 이동
	@RequestMapping(value = "/event_createform.do", method = RequestMethod.GET)
	public String eventCreateForm(@RequestParam("club_num") int club_num, Model model, HttpSession session) throws Exception {
		// 1. 세션을 구하기
		// 2. 세션을 구해서 club 테이블에서 확인해서 모임장이면 수정 가능
		String sess = (String) session.getAttribute("email");
		//(String) session.getAttribute("email");
		ClubDTO clubdto = club_Member_JoinService.getClubCont(club_num);
					
		if(!(clubdto.getClub_host_email().equals(sess))) {
			// 모임장이 아니면 모임장만 수정 가능합니다 메세지 뿌리기
			int result = 2;
			model.addAttribute("result", result);
			return "togetherview/event_createform";
		} else {
			// 그리고 모임장이면 수정 가능
			// 그리고 모임장이면 모임장 이메일을 구해서 model 객체에 저장
			model.addAttribute("club_host_email", clubdto.getClub_host_email());
			model.addAttribute("club_num", club_num);
			
			// 모임의 지역이 수도권이면 이벤트 만들때 맵이 수도권을 중간으로 해서 보여주는 작업을 위해
			ClubDTO clubdto_region = eventService.getClubCont(club_num);
			String club_region = clubdto_region.getClub_region();
			
			model.addAttribute("club_region", club_region);
			return "togetherview/event_createform";
		
		}

	}

	// 이벤트 만들기
	@RequestMapping(value = "/event_create.do", method = RequestMethod.POST)
	public String eventCreate(@RequestParam("event_file0") MultipartFile mf,
			@ModelAttribute EventDTO event,
			Model model,
			HttpSession session, HttpServletRequest request) throws Exception {
		int result = 0;
		System.out.println("Controller arrived");
		System.out.println("여기" + event.getEvent_title());
		
		// 날짜 처리
		String event_date_date = (String)request.getParameter("event_date_date");
		String event_date_time = (String)request.getParameter("event_date_time");
		
		String event_date = event_date_date + " " + event_date_time;
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date to_event_date = transFormat.parse(event_date);
		
		event.setEvent_date(to_event_date);
//		System.out.println(to_event_date);
		
		// 첨부파일 처리
		String fileName = mf.getOriginalFilename();
		int fileSize = (int) mf.getSize(); // 단위 : Byte
		System.out.println(fileName);
		
		String file[] = new String[2];
		String newfilename = "";
		
		if(fileName != "") { // 첨부파일이 전송된 경우
			//파일 중복문제 해결
			String extension = fileName.substring(fileName.lastIndexOf("."), fileName.length());
			System.out.println("extension: " + extension);
			
			UUID uuid = UUID.randomUUID();
			
			newfilename = uuid.toString() + extension;
			System.out.println("newfilename; " + newfilename);
			
			StringTokenizer st = new StringTokenizer(fileName, ".");
			file[0] = st.nextToken(); // 파일명
			file[1] = st.nextToken(); // 확장자
			
			if(fileSize > 1000000) { // 1MB
				result = 2;
				model.addAttribute("result", result);
				
				return "togetherview/event_create_result";
			}
		}
		
		if(fileName != "") { // 첨부파일이 전송된 경우
		// 첨부파일 업로드
		// mf.transferTo(new File("/path/"+fileName));
		String path = session.getServletContext().getRealPath("/upload");
		System.out.println("path : " + path);
		
		FileOutputStream fos = new FileOutputStream(path + "/" + newfilename);
		fos.write(mf.getBytes());
		fos.close();
		
			event.setEvent_file(newfilename);
			System.out.println(event.getEvent_file());
		}
		
		result = eventService.eventCreate(event);
		model.addAttribute("result", result);
		model.addAttribute("club_num", event.getClub_num());
		return "togetherview/event_create_result"; // 특정 모임의 이벤트 리스트 목록 불러오기
	}
	
	// 이벤트 목록 리스트
	@RequestMapping(value = "/event_list.do", method = RequestMethod.GET)
	public String eventList(Model model, EventDTO event, 
			HttpServletRequest request) throws Exception {
		System.out.println("Controller arrived");
		List<EventDTO> eventlist = new ArrayList<EventDTO>();
		
		// 키워드가 넘어왔는지 확인
		System.out.println("키워드 : " + event.getKeyword()); // 안넘어왔을때 null, String 형
		// club_num 즉 모임명이 넘어왔는지 확인
		System.out.println("모임 : " + event.getClub_num()); // 안넘어왔을때 0, int형
		// 지역명이 넘어왔는지 확인
		System.out.println("지역 : " + event.getEvent_region()); // 안넘어왔을떄 null, String 형
		// preview
		System.out.println("preview : " + event.getPreview()); // 안넘어왔을떄 null, String 형
		
		int eventPage = 1;
		int limit = 10;
		
		// 페이지 값이 넘어온 경우엔 그 값을 페이지 번호로 지정
		if (request.getParameter("eventPage") != null) {
			eventPage = Integer.parseInt(request.getParameter("eventPage"));
		}
		
		// preview 가 Y 면 3페이지만 출력
		if (event.getPreview() != null) {
			limit = 3;
			model.addAttribute("preview", event.getPreview());
		}
		
		// 페이지 번호 확인
		System.out.println("페이지 : " + eventPage);

		// 총 이벤트 수를 받아옴.
		int listcount = eventService.getEventListCount(event); // 키워드,모임명,지역명 넘김
		System.out.println("총 이벤트 수 " + listcount);
		
		int startRow = (eventPage - 1) * limit + 1; // 1, 11, 21, 31
		int endRow = startRow + limit - 1; // 10, 20, 30, 40

		// 나머지 파생변수들을 구함
		PagingPgm pp = new PagingPgm(listcount, limit, eventPage);
		event.setStartRow(startRow);
		event.setEndRow(endRow);
		int no = listcount - startRow + 1;		// 화면 출력 번호
		
		eventlist = eventService.getEventList(event); // 리스트를 받아옴.
		System.out.println(eventlist);
				
		// 가져온 이벤트 리스트
		model.addAttribute("eventlist", eventlist);
		// 화면 출력 번호
		model.addAttribute("no", no);
		// 데이터 갯수, 화면에 출력할 데이터 갯수, 블랙덩 페이지 갯수, 현재 페이지 번호,
		// 각 블럭의 시작 페이지, 각 블럭의 끝 페이지, 총 페이지수 
		model.addAttribute("pp", pp);
		// 각 케이스별 페이징 처리를 위해 전달
		model.addAttribute("keyword", event.getKeyword());
		model.addAttribute("club_num", event.getClub_num());
		model.addAttribute("event_region", event.getEvent_region());

		model.addAttribute("eventPage", eventPage);
		model.addAttribute("preview", event.getPreview());
		

		return "togetherview/event_list"; // 이후 리스트 출력하는 페이지로 가는걸로 수정
	}
	
	// 이벤트 상세정보 구하기
	@RequestMapping(value = "/event_cont.do", method = RequestMethod.GET)
	public String eventCont(@RequestParam("event_num") int event_num,
			@RequestParam("eventPage") int eventPage,
			@RequestParam("state") String state ,
			@RequestParam("club_num") int club_num, 
			RedirectAttributes redirectAttributes,
			Model model, HttpSession session) throws Exception {
		
		System.out.println("상태값 출력: " + state);
		
		EventDTO event = eventService.getEventCont(event_num);
		
		model.addAttribute("eventPage", eventPage);
		model.addAttribute("event_num", event_num);
		model.addAttribute("event", event);
		model.addAttribute("club_num", club_num);

		// 1. 세션을 구하기
		// 2. 세션을 구해서 club 테이블에서 확인해서 모임장이면 수정 가능
		String sess = (String) session.getAttribute("email");
		//(String) session.getAttribute("email");
		ClubDTO clubdto = club_Member_JoinService.getClubCont(event.getClub_num());
		
		
		if (state.equals("cont")) {// 내용보기일때
			// 글내용중 엔터키 친부분을 웹상에 보이게 할때 다음줄로 개행
			String eventInfobr = event.getEvent_info().replace("\n", "<br>");
			model.addAttribute("eventInfobr", eventInfobr);
			
			if(clubdto.getClub_host_email().equals(sess)) {
				String club_host_yn = "Y";
				model.addAttribute("club_host_yn", club_host_yn);
			}
			
			return "togetherview/event_cont";
			// 추후 세션 구해서 모임장인지 일반회원인지 구분
		} else if (state.equals("edit")) {// 수정폼
			
			if(!clubdto.getClub_host_email().equals(sess)) {
				// 모임장이 아니면 모임장만 수정 가능합니다 메세지 뿌리기
				int result = 2;
				model.addAttribute("result", result);
				return "togetherview/event_editform";
			} else {
				// 그리고 모임장이면 수정 가능
				// 글내용중 엔터키 친부분을 웹상에 보이게 할때 다음줄로 개행
				return "togetherview/event_editform";
			}
		} else if (state.equals("del")) {// 삭제폼
			
			if(!(clubdto.getClub_host_email().equals(sess))) {
				// 모임장이 아니면 모임장만 수정 가능합니다 메세지 뿌리기
				int result = 2;
				model.addAttribute("result", result);
				return "togetherview/event_del_result";
			} else {
				// 그리고 모임장이면 수정 가능
				redirectAttributes.addAttribute("eventPage", eventPage);
				redirectAttributes.addAttribute("event_num", event_num);
				redirectAttributes.addAttribute("club_num", club_num);
				//redirectAttributes.addAttribute("event", event);
				return "redirect:event_del.do";

			}
						
		}
		return null;
		
	}
	
	// 이벤트 수정하기
	@RequestMapping(value = "/event_edit.do", method = RequestMethod.POST)
	public String eventUpdate(@RequestParam("event_file0") MultipartFile mf,
			@ModelAttribute EventDTO event, @RequestParam("eventPage") int eventPage, 
			Model model,
			HttpSession session, HttpServletRequest request) throws Exception {
		
		System.out.println("Controller arrived");
		System.out.println("이벤트 수정 " + event.getEvent_title());
			int result = 0;
			// 날짜 처리
			String event_date_date = (String)request.getParameter("event_date_date");
			String event_date_time = (String)request.getParameter("event_date_time");
			
			String event_date = event_date_date + " " + event_date_time;
			SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			Date to_event_date = transFormat.parse(event_date);
			
			event.setEvent_date(to_event_date);
//			System.out.println(to_event_date);
			
			// 첨부파일 처리 수정
			String fileName = mf.getOriginalFilename();
			int fileSize = (int) mf.getSize(); // 단위 : Byte
			System.out.println(fileName);
			
			String file[] = new String[2];
			String newfilename = "";
			
			if(fileName != "") { // 첨부파일이 전송된 경우
				//파일 중복문제 해결
				String extension = fileName.substring(fileName.lastIndexOf("."), fileName.length());
				System.out.println("extension: " + extension);
				
				UUID uuid = UUID.randomUUID();
				
				newfilename = uuid.toString() + extension;
				System.out.println("newfilename; " + newfilename);
				
				StringTokenizer st = new StringTokenizer(fileName, ".");
				file[0] = st.nextToken(); // 파일명
				file[1] = st.nextToken(); // 확장자
				
				if(fileSize > 1000000) { // 1MB
					result = 3;
					model.addAttribute("result", result);
					
					return "togetherview/event_edit_result";
				}
			}
			
			if(fileName != "") { // 첨부파일이 전송된 경우
			// 첨부파일 업로드
			// mf.transferTo(new File("/path/"+fileName));
			String path = session.getServletContext().getRealPath("/upload");
			System.out.println("path : " + path);
			
			
			FileOutputStream fos = new FileOutputStream(path + "/" + newfilename);
			fos.write(mf.getBytes());
			fos.close();
			
			}
			
			EventDTO old = this.eventService.getEventCont(event.getEvent_num());
			if (fileSize > 0 ) { 		// 첨부 파일이 수정되면
				event.setEvent_file(newfilename);			
			} else { 					// 첨부파일이 수정되지 않으면
				event.setEvent_file(old.getEvent_file());
			}
			
			result = eventService.eventUpdate(event);
			model.addAttribute("club_num", event.getClub_num());
			model.addAttribute("event_num", event.getEvent_num());
			model.addAttribute("eventPage", eventPage);
			model.addAttribute("result", result);
			return "togetherview/event_edit_result";
		
		
	}
	
	// 이벤트 삭제
	@RequestMapping(value="/event_del.do", method=RequestMethod.GET)
	public String eventDelete(
			@RequestParam("eventPage") int eventPage,
			@RequestParam("event_num") int event_num,
			@RequestParam("club_num") int club_num,
			Model model,
			HttpSession session) {
			System.out.println("이벤트 번호" + event_num);
			System.out.println("모임 번호: " + club_num);
			System.out.println("페이지 : " + eventPage);
			
			// 1. 세션을 구하기
			// 2. 세션을 구해서 club_member_join 테이블에서 확인해서 모임장이면 삭제 가능
			// 또는 club 테이블에서 확인도 가능함
			// 그리고 모임장이면 모임장 이메일을 구해서 model 객체에 저장
			
			EventDTO old = this.eventService.getEventCont(event_num);
			// 첨부파일이 있다면
			if(old.getEvent_file() != null) {
			// 삭제 후 첨부파일도 함꼐 삭제
			String up = session.getServletContext().getRealPath("upload");

			String fname = old.getEvent_file();
			System.out.println("up:"+up);
			
			// 디비에 저장된 기존 이진파일명을 가져옴
			if (fname != null) {// 기존 이진파일이 존재하면
				File delFile = new File(up +"/"+fname);
				delFile.delete();// 기존 이진파일을 삭제
				}
			}
			
			int result = eventService.eventDelete(event_num);
			System.out.println("result");
			
			model.addAttribute("club_num", club_num);
			model.addAttribute("event_num", event_num);
			model.addAttribute("eventPage", eventPage);
			model.addAttribute("result", result);

			return "togetherview/event_delete_result";
	}

	// 첨부파일 다운로드
	@RequestMapping(value="/file_down.do", method=RequestMethod.GET)
	public void fileDown(Model model, HttpServletRequest request, HttpSession session,
			HttpServletResponse response, @RequestParam("file_name") String file_name) throws Exception {
		System.out.println("파일다운");
		if(file_name != "") {
		String path = session.getServletContext().getRealPath("/upload");
		System.out.println("path : " + path);
		
		File file = new File(path + "/" + file_name);
		response.setHeader("Content-Disposition", "attachment;filename=" + file.getName());
		
		FileInputStream fis = new FileInputStream(path + "/" + file_name);
		OutputStream out = response.getOutputStream();
		
		int read = 0;
		byte[] buffer = new byte[2048];
		while((read = fis.read(buffer)) != -1) {
			 out.write(buffer, 0, read);
		}

		fis.close();
		}
	}
	
}
