package together.service;


import java.util.HashMap;
import java.util.List;

import together.model.Club_Member_JoinDTO;
import together.model.EventDTO;
import together.model.Event_User_AttendDTO;

public interface Event_User_AttendService {
	
	public Event_User_AttendDTO attendCheck(Event_User_AttendDTO euadto) throws Exception;
	
	public Club_Member_JoinDTO joinCheck(Club_Member_JoinDTO cmjdto) throws Exception;
	
	public int attendInsert(Event_User_AttendDTO euadto) throws Exception;
	
	public int attendDelete(Event_User_AttendDTO euadto) throws Exception;
	
	public List<EventDTO> attendMylist(HashMap<String, Object> hm) throws Exception;
	
	public int attendMylistCount(String email) throws Exception;

}
