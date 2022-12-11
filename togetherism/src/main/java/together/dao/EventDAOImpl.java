package together.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import together.model.ClubDTO;
import together.model.EventDTO;

@Repository
public class EventDAOImpl implements EventDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	public int eventCreate(EventDTO event) {
		System.out.println(event.getClub_host_email());
		System.out.println(event.getClub_num());
		System.out.println(event.getEvent_file());
		System.out.println(event.getEvent_info());
		System.out.println(event.getEvent_num());
		System.out.println(event.getEvent_spot_lat());
		System.out.println(event.getEvent_spot_long());
		System.out.println(event.getEvent_title());
		System.out.println(event.getEvent_date());
		System.out.println(event.getEvent_reg_date());
		return sqlSession.insert("eventns.create",event);
	}
	
	public int getEventListCount(EventDTO event) {
		return sqlSession.selectOne("eventns.listcount", event);
	}
	
	public List<EventDTO> getEventList(EventDTO event){
		return sqlSession.selectList("eventns.eventlist", event);
	}
	
	public EventDTO getEventCont(int event_num) {
		return sqlSession.selectOne("eventns.eventcont", event_num);
	}
	public int eventUpdate(EventDTO event) {
		return sqlSession.update("eventns.update", event);
	}
	public int eventDelete(int event_num) {
		return sqlSession.delete("eventns.delete",event_num);
	}
	
	// club_num 에 해당하는 모든 이벤트 가져오기
	public List<EventDTO> getEventListWithCN(int club_num){
		return sqlSession.selectList("eventns.eventlistall", club_num);
	}
	
	// club table 연동, club 데이터 1개 상세정보 가져오기
	public ClubDTO getClubCont(int club_num) {
		return sqlSession.selectOne("eventns.clubcont", club_num);
	}
}
