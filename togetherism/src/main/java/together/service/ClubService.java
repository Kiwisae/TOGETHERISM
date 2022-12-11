package together.service;

import together.model.ClubDTO;
import together.model.Club_Member_JoinDTO;

public interface ClubService {
	
	public int checkClubName(String cn) throws Exception;
	
	public void insertClub(ClubDTO club) throws Exception;
	
	public int insertClub_Member_Join(Club_Member_JoinDTO clubmj) throws Exception;
	
	public ClubDTO bringclubname(String club_name) throws Exception;
	
	public int updateClub(ClubDTO cedit) throws Exception;
	
	public void deleteClub(int club_num) throws Exception;
	
	public ClubDTO club_cont(int club_num) throws Exception;
	
	public void club(ClubDTO cedto) throws Exception;
		
	
}
