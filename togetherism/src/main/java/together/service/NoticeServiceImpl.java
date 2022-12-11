package together.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import together.dao.NoticeDAO;
import together.dao.NoticeDAOImpl;
import together.model.NoticeDTO;

@Service
public class NoticeServiceImpl implements NoticeService {
	@Autowired
	private NoticeDAOImpl noticeDao;
	
	//공지사항 새 글 작성
	public int insert (NoticeDTO noticeDto){
		return noticeDao.insert(noticeDto);
	}
	
	//공지사항 전체 글 개수
	public int getCount(){
		return noticeDao.getCount();
	}
	
	//공지사항 전체 글 데이터
	public List<NoticeDTO> getNoticeList (int page) {
		return noticeDao.getNoticeList(page);
	}
	
	//공지사항 특정 글 가져오기
	public NoticeDTO getNotice (int notice_num){
		return noticeDao.getNotice(notice_num);
	}
	
	//공지사항 특정 글 삭제
	public int delete (int no){
		return noticeDao.delete(no);
	}
	
	//기존 글 수정
	public int update (NoticeDTO noticeDto){
		return noticeDao.update(noticeDto);
	}
	
	//기존 글 수정 시 첨부파일 삭제
	public int fileDelete (int notice_num) {
		return noticeDao.fileDelete(notice_num);
	}
	
	//공지사항의 가장 최신글 3개 불러오기
	public List<NoticeDTO> getNoticeRecent () {
		return noticeDao.getNoticeRecent();
	}

}
