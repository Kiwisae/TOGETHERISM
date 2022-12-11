package together.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import together.model.Club_Member_JoinDTO;
import together.model.EventDTO;
import together.model.Event_User_AttendDTO;

@Repository
public class Event_User_AttendDAOImpl implements Event_User_AttendDAO{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public Event_User_AttendDTO attendCheck(Event_User_AttendDTO euadto) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("attend_check", euadto);
	}

	@Override
	public Club_Member_JoinDTO joinCheck(Club_Member_JoinDTO cmjdto) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("join_check", cmjdto);
	}

	@Override
	public int attendInsert(Event_User_AttendDTO euadto) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("attend_insert", euadto);
	}

	@Override
	public int attendDelete(Event_User_AttendDTO euadto) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete("attend_delete", euadto);
	}

	@Override
	public List<EventDTO> attendMylist(HashMap<String, Object> hm) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("attend_mylist", hm);
	}

	@Override
	public int attendMylistCount(String email) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("attend_mylistcount", email);
	}
	
	
}
