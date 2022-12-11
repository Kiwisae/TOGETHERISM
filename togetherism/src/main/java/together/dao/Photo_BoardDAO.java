package together.dao;

import java.util.List;
import java.util.Map;

import together.model.Photo_BoardDTO;

public interface Photo_BoardDAO {

	// 사진 등록
	public int photoCreate(Photo_BoardDTO pbdto);
	
	// 사진 리스트 총 개수
	public int getPhotoListCount(int club_num);
	
	// 사진 리스트
	public List<Photo_BoardDTO> getPhotoList(Map<String, Integer> map);
	
	// 사진 삭제
	public int photoDelete(int photo_num);
	
	// 사진 상세 정보
	public Photo_BoardDTO getPhotoCont(int photo_num);
	
	// 사진 수정
	public int photoUpdate(Photo_BoardDTO pbdto);
}
