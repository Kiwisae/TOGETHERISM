package together.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import together.model.Photo_BoardDTO;

@Repository
public class Photo_BoardDAOImpl implements Photo_BoardDAO{
	
	@Autowired
	private SqlSession sqlSession;
	
	// 사진 등록
	public int photoCreate(Photo_BoardDTO pbdto) {
		return sqlSession.insert("photo_boardns.create", pbdto);
	}
	
	// 사진 리스트 총 개수
	public int getPhotoListCount(int club_num){
		return sqlSession.selectOne("photo_boardns.listcount",club_num);
	}
	
	// 사진 리스트
	public List<Photo_BoardDTO> getPhotoList(Map<String, Integer> map){
		return sqlSession.selectList("photo_boardns.list",map);
	}
	
	// 사진 삭제
	public int photoDelete(int photo_num) {
		return sqlSession.delete("photo_boardns.delete", photo_num);
	}
	// 사진 상세 정보
	public Photo_BoardDTO getPhotoCont(int photo_num) {
		return sqlSession.selectOne("photo_boardns.cont", photo_num);
	}
	
	// 사진 수정
	public int photoUpdate(Photo_BoardDTO pbdto) {
		return sqlSession.update("photo_boardns.update",pbdto);
	}
}
