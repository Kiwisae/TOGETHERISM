package together.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.UUID;

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
import org.springframework.web.multipart.MultipartFile;

import together.model.ClubDTO;
import together.model.Club_Member_JoinDTO;
import together.model.EventDTO;
import together.model.Photo_BoardDTO;
import together.service.Club_Member_JoinService;
import together.service.PagingPgm;
import together.service.Photo_BoardService;

@Controller
public class Photo_BoardController {

	@Autowired
	private Photo_BoardService photo_BoardService;
	@Autowired
	private Club_Member_JoinService club_Member_JoinService;

	// 사진 등록
	@RequestMapping(value = "/photo_create.do", method = RequestMethod.POST)
	public String photoCreate(@RequestParam("photo_file0") MultipartFile mf, @ModelAttribute Photo_BoardDTO pbdto,
			Model model, HttpSession session) throws Exception {

		// 세션을 구하기
		// 세션을 구해서 club_member_join 테이블에서 확인해서 모임 멤버인 경우만 사진첩 insert 가능
		// 세션이 없으므로 임의로 설정
		String sess = (String) session.getAttribute("email");
		//(String) session.getAttribute("email");
		pbdto.setPhoto_member_email(sess);
		int result = 0;

		// 넘어오는 값 확인
		System.out.println("사진을 저장할 모임 번호 : " + pbdto.getClub_num());
		System.out.println("사진 글귀 : " + pbdto.getPhoto_content());
		System.out.println("사진을 저장한 사람 이메일 : " + pbdto.getPhoto_member_email());
		System.out.println("사진 : " + pbdto.getPhoto_file());

		// 모임에 가입된 사람인지 검사
		Club_Member_JoinDTO cmjdto = new Club_Member_JoinDTO();
		cmjdto.setClub_num(pbdto.getClub_num());
		cmjdto.setMember_email(pbdto.getPhoto_member_email());

		// 3. 구한 세션으로 select
		Club_Member_JoinDTO cmj = club_Member_JoinService.getJoin(cmjdto);

		if (cmj == null) { // 데이터가 없을때, 즉 멤버가 아닐때
			result = 2;
			model.addAttribute("result", result);
			return "togetherview/photo_board_create_result";

		} else { // 데이터가 있을때, 즉 멤버일때
			// 이때 만 사진첩에 insert 가능하도록 폼으로 간다

			// 첨부파일 처리
			String fileName = mf.getOriginalFilename();
			int fileSize = (int) mf.getSize(); // 단위 : Byte
			System.out.println(fileName);

			String file[] = new String[2];
			String newfilename = "";

			if (fileName != "") { // 첨부파일이 전송된 경우
				// 파일 중복문제 해결
				String extension = fileName.substring(fileName.lastIndexOf("."), fileName.length());
				System.out.println("extension: " + extension);

				UUID uuid = UUID.randomUUID();

				newfilename = uuid.toString() + extension;
				System.out.println("newfilename; " + newfilename);

				StringTokenizer st = new StringTokenizer(fileName, ".");
				file[0] = st.nextToken(); // 파일명
				file[1] = st.nextToken(); // 확장자

				if (fileSize > 1000000) { // 1MB
					result = 3;
					model.addAttribute("result", result);
					return "togetherview/photo_board_create_result";

				} else if (!(file[1].toLowerCase()).equals("jpg") && 
						!(file[1].toLowerCase()).equals("gif") && 
						!(file[1].toLowerCase()).equals("png")) {
					result = 4;
					model.addAttribute("result", result);
					return "togetherview/photo_board_create_result";

				}
			}

			if (fileName != "") { // 첨부파일이 전송된 경우
				// 첨부파일 업로드
				// mf.transferTo(new File("/path/"+fileName));
				String path = session.getServletContext().getRealPath("/upload");
				System.out.println("path : " + path);

				FileOutputStream fos = new FileOutputStream(path + "/" + newfilename);
				fos.write(mf.getBytes());
				fos.close();

				pbdto.setPhoto_file(newfilename);
				System.out.println(pbdto.getPhoto_file());
			}

			result = photo_BoardService.photoCreate(pbdto);
			model.addAttribute("result", result);
			model.addAttribute("club_num", pbdto.getClub_num());

			return "togetherview/photo_board_create_result";
		}
	}

	// 사진첩 리스트
	@RequestMapping(value = "/photo_list.do", method = RequestMethod.GET)
	public String photoCreate(@RequestParam("club_num") int club_num,
			@RequestParam(value="startRow", required = false) String startRow0, 
			@RequestParam(value="endRow", required = false) String endRow0, 
			HttpServletRequest request, Model model)
			throws Exception {

		List<Photo_BoardDTO> pblist = new ArrayList<Photo_BoardDTO>();

		int photoPage = 1;
		int limit = 100;

		int startRow = 0;
		int endRow = 0;
		
		// 페이지 값이 넘어온 경우엔 그 값을 페이지 번호로 지정
		if (request.getParameter("photoPage") != null) {
			photoPage = Integer.parseInt(request.getParameter("photoPage"));
		}
		
		// startRow, endRow 가 넘어오지 않으면 바로 로딩했을때 
		if(startRow0 == null && endRow0 == null) {
			startRow = 1;
			endRow = 3;
		} else if(startRow0 != null && endRow0 != null){ // startRow, endRow 가 넘어왔을땐 그 데이터 가져오기
			startRow = Integer.parseInt(startRow0);
			endRow = Integer.parseInt(endRow0);
			photoPage = endRow/3;
		}
		System.out.println(startRow);
		System.out.println(endRow);
		
		// 총 사진 수를 받아옴.
		int listcount = photo_BoardService.getPhotoListCount(club_num);
		System.out.println("총 이벤트 수 " + listcount);


		// 나머지 파생변수들을 구함
		PagingPgm pp = new PagingPgm(listcount, limit, photoPage);

		Map<String, Integer> map = new HashMap<String, Integer>();

		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("club_num", club_num); // 모임 번호 저장

		pblist = photo_BoardService.getPhotoList(map); // 리스트를 받아옴.
		System.out.println(pblist);

		// 가져온 사진첩 리스트
		model.addAttribute("pblist", pblist);

		// 데이터 갯수, 화면에 출력할 데이터 갯수, 블랙덩 페이지 갯수, 현재 페이지 번호,
		// 각 블럭의 시작 페이지, 각 블럭의 끝 페이지, 총 페이지수
		model.addAttribute("pp", pp);
		model.addAttribute("club_num", club_num);
		model.addAttribute("photoPage", photoPage); // ajax 페이징 처리 나중에 하기 위해 가져감
		
		return "togetherview/photo_list";
	}

	// 사진 삭제
	@RequestMapping(value = "/photo_delete.do", method = RequestMethod.GET)
	public String photoDelete(@ModelAttribute Photo_BoardDTO pbdto, HttpServletRequest request, Model model,
			HttpSession session) throws Exception {
		int result = 0;
		// 세션을 구하기
		// 세션을 구해서 사진 등록자와 일치하는 경우에만 삭제 가능, 
		// 세션이 없으므로 임의로 설정
		String sess = (String) session.getAttribute("email");
		//(String) session.getAttribute("email");
		Photo_BoardDTO old = this.photo_BoardService.getPhotoCont(pbdto.getPhoto_num());
		//또한 모임장과 일치하는 경우에도 삭제 가능하도록 하기
		// club 테이블과 연동해서 모임장 이메일 구해오기
		ClubDTO clubdto = club_Member_JoinService.getClubCont(old.getClub_num());
		
		// 넘어온 값 확인
		System.out.println(pbdto.getClub_num());
		System.out.println(old.getPhoto_member_email());
		System.out.println(pbdto.getPhoto_num());
		System.out.println(clubdto.getClub_host_email());

		if (!sess.equals(old.getPhoto_member_email()) && !sess.equals(clubdto.getClub_host_email())) { 
			// 로그인되어있는 사용자가 사진 작성자가 아닐때 그리고 모임장도 아닐떄는
			// 삭제 불가능
			result = 2;
			model.addAttribute("result", result);
			return "togetherview/photo_delete_result";
		} else { // 로그인되어있는 사용자가 사진 작성자 일때 또는 모임장일떄는 삭제 가능
			result = photo_BoardService.photoDelete(pbdto.getPhoto_num());

			if(result == 1) {
			  
			// 삭제 후 첨부파일도 함꼐 삭제
			String up = session.getServletContext().getRealPath("upload");
			String fname = old.getPhoto_file();
			System.out.println("up:"+up);
			  
			File delFile = new File(up +"/"+fname);
			delFile.delete(); // 기존 파일 삭제

			model.addAttribute("club_num", pbdto.getClub_num());
			model.addAttribute("result", result);
			return "togetherview/photo_delete_result";
			} else {
				result = 3;
				model.addAttribute("result", result);
				return "togetherview/photo_delete_result";
			}

		}
	}
	// 사진 수정
	@RequestMapping(value = "/photo_edit.do", method = RequestMethod.POST)
	public String photoEdit(@RequestParam("photo_file0") MultipartFile mf, @ModelAttribute Photo_BoardDTO pbdto,
			Model model, HttpSession session) throws Exception {
		
		// 세션을 구하기
		// 세션을 구해서 club_member_join 테이블에서 확인해서 모임 멤버인 경우만 사진첩 insert 가능
		// 세션이 없으므로 임의로 설정
		String sess = (String) session.getAttribute("email");
		//(String) session.getAttribute("email");
		pbdto.setPhoto_member_email(sess);
		int result = 0;
		
		// 넘어온 값 확인
		System.out.println("모임 번호: " + pbdto.getClub_num());
		System.out.println("사진 글귀: " + pbdto.getPhoto_content());
		System.out.println("사진 번호: " + pbdto.getPhoto_num());
		System.out.println("사진을 수정한 사람 : " + pbdto.getPhoto_member_email());
		
		Photo_BoardDTO old = this.photo_BoardService.getPhotoCont(pbdto.getPhoto_num());
		//사진을 등록했던 사람만 수정 가능
		
		if (!sess.equals(old.getPhoto_member_email())) { 
			// 로그인되어있는 사용자가 사진 작성자가 아닐때
			// 삭제 불가능
			result = 2;
			model.addAttribute("result", result);
			return "togetherview/photo_edit_result";
		} else {
			// 현재 사용자가 사진 작성자일때
			// 사진 삭제 가능
			
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
					
					return "togetherview/photo_edit_result";
				} else if (!(file[1].toLowerCase()).equals("jpg") && 
						!(file[1].toLowerCase()).equals("gif") && 
						!(file[1].toLowerCase()).equals("png")) {
					result = 4;
					model.addAttribute("result", result);
					return "togetherview/photo_edit_result";
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
				
				Photo_BoardDTO oldpt = this.photo_BoardService.getPhotoCont(pbdto.getPhoto_num());
				if (fileSize > 0 ) { 		// 첨부 파일이 수정되면
					pbdto.setPhoto_file(newfilename);	
				} else { 					// 첨부파일이 수정되지 않으면
					pbdto.setPhoto_file(oldpt.getPhoto_file());
				}
				
				result = photo_BoardService.photoUpdate(pbdto);
				
				model.addAttribute("club_num", pbdto.getClub_num());
				model.addAttribute("result", result);
				return "togetherview/photo_edit_result";
		}
		
		
	}

	
}

