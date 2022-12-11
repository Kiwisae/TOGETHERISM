package together.controller;

import java.io.File;
import java.util.StringTokenizer;
import java.util.UUID;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

//import com.sun.glass.ui.Size;

import together.model.ClubDTO;
import together.model.Club_Member_JoinDTO;
import together.service.ClubService;
import together.service.ClubServiceImpl;

@Controller
public class ClubController {

	@Autowired
	private ClubService clubservice;

	// 모임 폼으로 바로 가는..
	@RequestMapping(value = "/club.do")
	public String club() throws Exception {

		return "togetherview/club";
	}

	// 모임명 중복체크 ajax
	@RequestMapping(value = "/club_namecheck.do", method = RequestMethod.POST)
	public String club_namecheck(@RequestParam("club_name") String cn, Model model) throws Exception {
		System.out.println("club_name:" + cn);

		int result = clubservice.checkClubName(cn);
		if (result == 1)
			System.out.println("중복 club_name");
		if (result == -1)
			System.out.println("사용 가능한 club_name");

		model.addAttribute("result", result);

		return "togetherview/clubNameCheckResult";
	}

	// 모임 등록
	@RequestMapping(value = "/club_save.do", method = RequestMethod.POST)
	public String club_save(@RequestParam("club_image1") MultipartFile mf, ClubDTO clubdto, HttpServletRequest request,
			HttpSession session, Model model) throws Exception {

		System.out.println("Club 컨트롤러 들어옴");

		String session_email = (String) session.getAttribute("email");

		String filename = mf.getOriginalFilename();
		int size = (int) mf.getSize();
		String path = request.getRealPath("upload");
		System.out.println("path:" + path);

		int result = 0;
		String file[] = new String[2];

		String newfilename = "";

		if (filename != "") { // 중복파일

			String extension = filename.substring(filename.lastIndexOf("."), filename.length());
			System.out.println("extension:" + extension);

			UUID uuid = UUID.randomUUID();

			newfilename = uuid.toString() + extension;
			System.out.println("newfilename:" + newfilename);

			StringTokenizer st = new StringTokenizer(filename, ".");
			file[0] = st.nextToken();
			file[1] = st.nextToken();

			if (size > 1000000) {
				result = 1;
				model.addAttribute("result", result);
			} else if (!file[1].toLowerCase().equals("jpg") && !file[1].toLowerCase().equals("gif")
					&& !file[1].toLowerCase().equals("png")) {
				result = 2;
				model.addAttribute("result", result);

				return "togetherview/club_uploadResult";

			}

		}

		if (size > 0) { // 첨부파일 전송된 경우
			mf.transferTo(new File(path + "/" + newfilename));

		}

		clubdto.setClub_image(newfilename);
		clubdto.setClub_host_email(session_email);

		clubservice.insertClub(clubdto);

		Club_Member_JoinDTO clubmjdto = new Club_Member_JoinDTO();

		ClubDTO old = clubservice.bringclubname(clubdto.getClub_name());

		clubmjdto.setClub_num(old.getClub_num());
		clubmjdto.setMember_email(old.getClub_host_email());

		int result2 = clubservice.insertClub_Member_Join(clubmjdto);

		if (result2 == 1) {
			model.addAttribute("club_num", clubdto.getClub_num());
			model.addAttribute("result2", result2);
		}
		return "togetherview/club_welcome_first";
	}

	// 내용보기
	@RequestMapping(value = "/club_detail.do")
	public String club_cont(@RequestParam("club_num") int club_num, @RequestParam("state") String state, Model model)
			throws Exception {

		System.out.println("ClubController 넘어옴");

		System.out.println(state);
		// 상세정보
		ClubDTO clubdto = clubservice.club_cont(club_num); // club_num = 7

		model.addAttribute("club_cont", clubdto);

		model.addAttribute("club_num", club_num); // club_num = 7
//			model.addAttribute("page", page);

		if (state.equals("cont")) {
			return "togetherview/club_welcome";
		} else if (state.equals("edit")) { // 수정폼
			return "togetherview/club_edit";
		} else if (state.equals("del")) { // 삭제폼
			return "togetherview/club_delete";
		}
		return null;
	}

	// 수정
	@RequestMapping(value = "/club_edit_save.do", method = RequestMethod.POST)
	public String club_edit_save(@RequestParam("club_image1") MultipartFile mf, ClubDTO clubdto,
			HttpServletRequest request, Model model) throws Exception {

		System.out.println("ClubController 수정들어옴");

		// 모임 수정
		String filename = mf.getOriginalFilename();
		int size = (int) mf.getSize();

		String path = request.getRealPath("upload");
		System.out.println("path:" + path);
		System.out.println("여기서 막힘1");

		int result = 0;
		String file[] = new String[2];

		String newfilename = "";
		System.out.println("여기서 막힘2");

		if (filename != "") { // 중복파일

			String extension = filename.substring(filename.lastIndexOf("."), filename.length());
			System.out.println("extension:" + extension);

			UUID uuid = UUID.randomUUID();

			newfilename = uuid.toString() + extension;
			System.out.println("newfilename:" + newfilename);

			StringTokenizer st = new StringTokenizer(filename, ".");
			file[0] = st.nextToken();
			file[1] = st.nextToken();

			if (size > 1000000) {
				result = 1;
				model.addAttribute("result", result);

				return "togetherview/club_uploadResult";
			} else if (!(file[1].toLowerCase()).equals("jpg") && !(file[1].toLowerCase()).equals("gif")
					&& !(file[1].toLowerCase()).equals("png")) {

				result = 2;
				model.addAttribute("result", result);

				return "togetherview/club_uploadResult";
			}

		}

		if (size > 0) { // 첨부파일 전송된 경우
			mf.transferTo(new File(path + "/" + newfilename));
		}

		ClubDTO old = clubservice.club_cont(clubdto.getClub_num());
		System.out.println(clubdto.getClub_num());
		System.out.println("222"+old.getClub_image());
		// ClubDTO 같은 객체 사용하지 않고 새로운 객체 생성하여 사용하기
		if (size > 0) { // 첨부파일이 수정된 경우
			clubdto.setClub_image(newfilename);
		} else {
			clubdto.setClub_image(old.getClub_image());
		}

//		clubdto.setMembe
		// 수정 메소드 호출
		int result1 = clubservice.updateClub(clubdto);
		if (result1 == 1)
			System.out.println("수정 성공");

		model.addAttribute("club_num", clubdto.getClub_num());
		model.addAttribute("result1", result1);

		return "togetherview/club_welcome";

	}

	/* 모임 삭제 */
	@RequestMapping(value = "/club_delete.do")
	public String club_delete(@RequestParam("club_num") int club_num, Model model) throws Exception {

		System.out.println("ClubController 삭제들어옴");

		ClubDTO clubdto = clubservice.club_cont(club_num);
		System.out.println(clubdto);

		clubservice.deleteClub(club_num);

		model.addAttribute("clubdto", clubdto);

		return "redirect:/my_club.do";
	}

	@RequestMapping(value = "/club_deleteResult.do", method = RequestMethod.GET)
	public String club_deleteResult(Model model) throws Exception {

		return "togetherview/club_deleteResult";
	}

}
