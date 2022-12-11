package together.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import together.model.NoticeDTO;

@Repository
public class NoticeDAOImpl implements NoticeDAO{
	
	@Autowired
	private SqlSession sqlSession;
	
	//공지사항 새 글 작성
	public int insert (NoticeDTO noticeDto) {
		return sqlSession.insert("noticens.insert", noticeDto);
	}
	
	//공지사항 전체 글 개수
	public int getCount () {
		return sqlSession.selectOne("noticens.count");
	}
	
	//공지사항 전체 글 데이터
	public List<NoticeDTO> getNoticeList (int page) {
		return sqlSession.selectList("noticens.list", page);
	}
	
	//공지사항 특정 글 가져오기
	public NoticeDTO getNotice (int notice_num) {
		return sqlSession.selectOne("noticens.content", notice_num);
	}
	
	//공지사항 특정 글 삭제
	public int delete (int no) {
		return sqlSession.delete("noticens.delete", no);
	}
	
	//기존 글 수정
	public int update (NoticeDTO noticeDto) {
		return sqlSession.update("noticens.update", noticeDto);
	}
	
	//기존 글 수정 시 첨부파일 삭제
	public int fileDelete (int notice_num) {
		return sqlSession.update("noticens.fileDelete", notice_num);
	}
	
	//공지사항의 가장 최신글 3개 불러오기
	public List<NoticeDTO> getNoticeRecent () {
		return sqlSession.selectList("noticens.getNoticeRecent");
	}

}
