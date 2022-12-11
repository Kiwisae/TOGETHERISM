package together.controller;

import java.io.File;
import java.io.PrintWriter;
import java.util.StringTokenizer;
import java.util.UUID;

import java.util.List;

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

import com.ibatis.sqlmap.engine.scope.SessionScope;

import together.model.ManagerDTO;
import together.model.NoticeDTO;
import together.service.ManagerService;
import together.service.ManagerServiceImpl;
import together.service.NoticeServiceImpl;

@Controller
public class NoticeController {
	@Autowired
	private NoticeServiceImpl noticeService;
	
	//공지사항 작성 폼 진입
	@RequestMapping("notice_writeForm.do")
	public String notice_writeForm () throws Exception {
		
		System.out.println("공지사항 작성폼 컨트롤러 진입");

		return "togetherview/notice_writeForm";
	}
	
	//공지사항 작성 완료
	@RequestMapping("notice_write.do")
	public String notice_write (NoticeDTO noticeDto, Model model,
								HttpServletRequest request,
								@RequestParam("notice_file1") MultipartFile mf) throws Exception {
		
		
		String fileName = mf.getOriginalFilename(); 	// 원래의 파일 이름
		int size = (int) mf.getSize();					// 파일의 용량
		
		String path = request.getRealPath("upload");	// 첨부파일 저장 경로
		System.out.println("mf : "+mf);
		System.out.println("fileName : "+fileName);
		System.out.println("size : "+size);
		System.out.println("Path : "+path);
		int resultFile = 0;
		
		String file[] = new String[2];					// file[0]:uuid파일명저장, file[1]:파일의 확장자
		String newFilename = "";						// uuid 파일명을 저장할 변수 초기화
		
		// 글 작성 시 파일 첨부
		if(size > 0) {
			
			//파일명 중복 문제 해결
			String extension = fileName.substring(fileName.lastIndexOf("."));
			System.out.println("extexntion : "+extension);
			
			UUID uuid = UUID.randomUUID();
			
			newFilename = uuid.toString() + extension;
			System.out.println("newFilename : "+newFilename);
			
			StringTokenizer st = new StringTokenizer(fileName, ".");
			file[0] = st.nextToken();	// 파일명
			file[1] = st.nextToken();	// 확장자
			
			// 첨부파일 관련 에러 조건문
			if(size > 1000000) {								// 파일 용량 1MB를 초과했을 때
				resultFile = 1;
				model.addAttribute("resultFile", resultFile);
				System.out.println("파일 크기가 지정된 용량을 초과했습니다.");
				
				return "togetherview/notice/notice_fileError";
			} else if (!file[1].equals("jpg") &&				// 지정한 파일 확장자가 아닐 때
					   !file[1].equals("gif") &&
					   !file[1].equals("png")) {
				resultFile = 2;
				model.addAttribute("resultFile", resultFile);
				System.out.println("지정된 확장자가 아닙니다.");
				
				return "togetherview/notice_fileError";
			}
		}
		
		// 글 작성 실행 시 첨부파일이 있을 경우 (size > 0)
		if(size > 0) {
			mf.transferTo(new File(path + "/" + newFilename));
		}
		
		System.out.println();
		
		noticeDto.setNotice_file(newFilename);				// notice_file 컬럼에 newFilename 값 주입
		
		//공지사항 새 글 작성
		int result = noticeService.insert(noticeDto);
		if(result == 1) System.out.println("공지사항 작성 완료");
		
		model.addAttribute("noticeDto", noticeDto);
		model.addAttribute("result", result);
		
		return "togetherview/notice_write";
	}
	
	//공지사항 게시판 목록
	@RequestMapping("notice_list.do")
	public String notice_list (HttpServletRequest request, 
							   Model model) throws Exception {
		System.out.println("공지사항 게시판 목록 컨트롤러 진입");
		
		//page : 현재 페이지, limit : 한 화면에 출력할 페이지 개수
		int page = 1;
		int limit = 10;
		
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		//공지사항 전체 글 개수
		int noticeCount = noticeService.getCount();
		System.out.println("데이터 개수: "+noticeCount);
		
		//공지사항 전체 글 데이터 리스트 객체로 가져오기
		List<NoticeDTO> noticeList = noticeService.getNoticeList(page);
		System.out.println("게시판 글 출력: "+noticeList);
		
		//1 블럭당 페이지 개수
		int pageCount = noticeCount / limit + ((noticeCount%limit == 0) ? 0 : 1);
		int startPage = ((page - 1) / 10) * limit + 1;	// 1, 11, 21, 31 ...
		int endPage = startPage + 10 - 1;				// 10, 20, 30, 40 ...
		
		if (endPage > pageCount) endPage = pageCount;
		
		model.addAttribute("page", page);
		model.addAttribute("noticeCount", noticeCount);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		
		System.out.println("글목록 구하기 성공");
		
		return "togetherview/notice_list";
	}

	//공지사항 글 상세 페이지
	@RequestMapping("notice_content.do")
	public String notice_content(int notice_num, int page, 
								 Model model) throws Exception {
		
		System.out.println("글 상세 내용 컨트롤러 진입");

		//공지사항 특정 글 가져오기
		NoticeDTO noticeDto = noticeService.getNotice(notice_num);
		
		//글 내용의 줄바꿈 처리
		String notice_content = noticeDto.getNotice_content().replace("\n", "<br>");
		
		model.addAttribute("notice_content", notice_content);
		model.addAttribute("noticeDto", noticeDto);
		model.addAttribute("page", page);
		
		return "togetherview/notice_content";
	}
	
	//공지사항 글 수정 폼 진입
	@RequestMapping("notice_modifyForm.do")
	public String notice_modifyForm(int notice_num, int page, 
									Model model) throws Exception {
		
		//공지사항 특정 글 가져오기
		NoticeDTO noticeDto = noticeService.getNotice(notice_num);
		System.out.println("첨부파일명: "+noticeDto.getNotice_file());
		
		model.addAttribute("noticeDto", noticeDto);
		model.addAttribute("page", page);
		
		System.out.println("글 수정폼 컨트롤러 진입");
		
		return "togetherview/notice_modifyForm";
	}
	
	//공지사항 글 수정 실행
	@RequestMapping("notice_modify.do")
	public String notice_modify (NoticeDTO noticeDto, Model model,
			HttpServletRequest request,	int page,
			@RequestParam("notice_file1") MultipartFile mf) throws Exception {
		
		System.out.println(noticeService.getNotice(noticeDto.getNotice_num()));
		System.out.println("글 수정 컨트롤러 진입");
		
		//공지사항 특정 글 가져오기
		noticeService.getNotice(noticeDto.getNotice_num());
		
		String fileName = mf.getOriginalFilename();
		int size = (int) mf.getSize();
		
		String path = request.getRealPath("upload");
		System.out.println("mf : "+mf);
		System.out.println("fileName : "+fileName);
		System.out.println("size : "+size);
		System.out.println("Path : "+path);
		int resultFile = 0;
		
		String file[] = new String[2];
		String newFilename = "";
		
		// 글 작성 시 파일 첨부
		if(size > 0) {
			
			//파일명 중복 문제 해결
			String extension = fileName.substring(fileName.lastIndexOf("."));
			System.out.println("extexntion : "+extension);
			
			UUID uuid = UUID.randomUUID();
			
			newFilename = uuid.toString() + extension;
			System.out.println("newFilename : "+newFilename);
			
			StringTokenizer st = new StringTokenizer(fileName, ".");
			file[0] = st.nextToken();	// 파일명
			file[1] = st.nextToken();	// 확장자
			
			if(size > 1000000) {
				resultFile = 1;
				model.addAttribute("fileResult", resultFile);
				
				return "togetherview/notice/notice_fileResult";
			} else if (!file[1].equals("jpg") &&
					   !file[1].equals("gif") &&
					   !file[1].equals("png")) {
				resultFile = 2;
				model.addAttribute("resultFile", resultFile);
				
				return "togetherview/notice_fileResult";
			}
		}
		
		if(size > 0) {
			mf.transferTo(new File(path + "/" + newFilename));
		}
		
		NoticeDTO oldFilename = noticeService.getNotice(noticeDto.getNotice_num());
		System.out.println("oldFilename파일명: "+oldFilename.getNotice_file());
		
		//수정폼에서 첨부파일을 수정할 경우 or 수정안할 경우
		if (size > 0) {
			noticeDto.setNotice_file(newFilename);
			
		} else {
			noticeDto.setNotice_file(oldFilename.getNotice_file());
		}
		
		//기존 글 수정
		int result = noticeService.update(noticeDto);
		System.out.println("글 수정 컨트롤러 2");
		if(result == 1) System.out.println("공지사항 수정 완료");
		
		model.addAttribute("noticeDto", noticeDto);
		model.addAttribute("oldFilename", oldFilename);
		model.addAttribute("result", result);
		model.addAttribute("page", page);
		
		return "togetherview/notice_modify";
	}
	
	//공지사항 삭제
	@RequestMapping("notice_delete.do")
	public String notice_deleteReally (int notice_num, 
									   Model model) throws Exception {
		
		System.out.println("글 삭제 컨트롤러 진입");
		
		//공지사항 특정 글 삭제
		int result = noticeService.delete(notice_num);
		if(result == 1 ) System.out.println("글 삭제 완료");
		
		model.addAttribute("result", result);
		
		return "togetherview/notice_delete";
	}
	
	//수정폼의 첨부파일 삭제
	@RequestMapping("notice_modifyFile.do")
	public String notice_modifyFile (int notice_num, 
									 Model model) throws Exception {
		
		System.out.println("수정폼의 첨부파일 삭제 컨트롤러 진입");
		//기존 글 수정 시 첨부파일 삭제
		int result = noticeService.fileDelete(notice_num);
		if(result == 1) System.out.println("notice_file 컬럼 null 처리 완료");
		
		model.addAttribute("result", result);
		
		return "togetherview/notice_fileResult";
	}
	
	//공지사항 최신글 3개 가져오기
	@RequestMapping("notice_recent.do")
	public String notice_recent (Model model) throws Exception {
		
		List<NoticeDTO> noticeRecent = noticeService.getNoticeRecent();
		
		String noticeRecent0 = noticeRecent.get(0).getNotice_title();
		int noticeRnum0 = noticeRecent.get(0).getNotice_num();
		
		model.addAttribute("noticeRecent0", noticeRecent0);
		model.addAttribute("noticeRnum0", noticeRnum0);
		
		return "togetherview/header_notice";
	}

}
