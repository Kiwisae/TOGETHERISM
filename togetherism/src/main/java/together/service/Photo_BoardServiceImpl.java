package together.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import together.dao.Photo_BoardDAO;
import together.model.Photo_BoardDTO;

@Service
public class Photo_BoardServiceImpl implements Photo_BoardService{

	@Autowired
	private Photo_BoardDAO photo_BoardDAO;
	
	// 사진 등록
	public int photoCreate(Photo_BoardDTO pbdto) {
		return photo_BoardDAO.photoCreate(pbdto);
	}
	
	// 사진 리스트 총 개수
	public int getPhotoListCount(int club_num) {
		return photo_BoardDAO.getPhotoListCount(club_num);
	}
	
	// 사진 리스트
	public List<Photo_BoardDTO> getPhotoList(Map<String, Integer> map){
		return photo_BoardDAO.getPhotoList(map);
	}
	
	// 사진 삭제
	public int photoDelete(int photo_num) {
		return photo_BoardDAO.photoDelete(photo_num);
	}
	
	// 사진 상세 정보
	public Photo_BoardDTO getPhotoCont(int photo_num) {
		return photo_BoardDAO.getPhotoCont(photo_num);
	}
	
	// 사진 수정
	public int photoUpdate(Photo_BoardDTO pbdto) {
		return photo_BoardDAO.photoUpdate(pbdto);
	}
}
