package together.service;

import java.util.List;

import together.model.ClubDTO;
import together.model.EventDTO;

public interface EventService {
	// 이벤트 생성
	public int eventCreate(EventDTO event);
	
	// 이벤트 목록 출력 : 이벤트 개수 구하기
	public int getEventListCount(EventDTO event);
	
	// 이벤트 목록 출력 : 이벤트 리스트 가져오기
	public List<EventDTO> getEventList(EventDTO event);
	
	// 이벤트 상세 정보 가져오기
	public EventDTO getEventCont(int event_num);
	
	// 이벤트 수정
	public int eventUpdate(EventDTO event);
	
	// 이벤트 삭제
	public int eventDelete(int event_num);
	
	// club_num 에 해당하는 모든 이벤트 가져오기
	public List<EventDTO> getEventListWithCN(int club_num);
	
	// club table 연동, club 데이터 1개 상세정보 가져오기
	public ClubDTO getClubCont(int club_num);
}
