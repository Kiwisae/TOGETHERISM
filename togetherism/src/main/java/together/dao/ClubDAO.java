package together.dao;

import together.model.ClubDTO;
import together.model.Club_Member_JoinDTO;

public interface ClubDAO {

	public int checkClubName(String cn) throws Exception;

	public void insertClub(ClubDTO club) throws Exception;
	
	public int insertclub_member_join(Club_Member_JoinDTO clubmj) throws Exception;
	
	public ClubDTO bringclubname(String club_name) throws Exception;

	public int updateClub(ClubDTO cedit) throws Exception;

	public void deleteClub(int club_num) throws Exception;
	
	public ClubDTO getClubCont(int club_num) throws Exception;
	
	public void club(ClubDTO cedto) throws Exception;

}
