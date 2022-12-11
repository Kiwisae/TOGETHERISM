package together.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import together.dao.ClubDAO;
import together.model.ClubDTO;
import together.model.Club_Member_JoinDTO;

@Service
public class ClubServiceImpl implements ClubService{
	
	@Autowired
	private ClubDAO clubDao;
	

	
	@Transactional
	public int checkClubName(String cn) throws Exception{
		return clubDao.checkClubName(cn);
	}
	
//	@Transactional
	public void insertClub(ClubDTO club) throws Exception{
		clubDao.insertClub(club);
	}
	
	
// 모임 가입 테이블에 member_email 넣기 
	public int insertClub_Member_Join(Club_Member_JoinDTO clubmj) throws Exception{
		return clubDao.insertclub_member_join(clubmj);
	}
	
	public ClubDTO bringclubname(String club_name) throws Exception{
		return clubDao.bringclubname(club_name);
	}
	
//	@Transactional
	public int updateClub(ClubDTO cedit) throws Exception{
		return clubDao.updateClub(cedit);
	}
	
//	@Transactional
	public void deleteClub(int club_num) throws Exception{
		clubDao.deleteClub(club_num);
	}
	
	//내용 보기 
	public ClubDTO club_cont(int club_num) throws Exception{
		
		ClubDTO clubdto = clubDao.getClubCont(club_num);
		
		return clubdto;
	}
	
	//수정
	public void club(ClubDTO cedto) throws Exception{
		clubDao.updateClub(cedto);
	}


}