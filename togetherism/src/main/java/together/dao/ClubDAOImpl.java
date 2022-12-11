package together.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import together.model.ClubDTO;
import together.model.Club_Member_JoinDTO;

@Repository
public class ClubDAOImpl implements ClubDAO {

	@Autowired
	private SqlSession sqlSession;

	// 모임 이름 중복 체크

	@Transactional
	public int checkClubName(String club_name) throws Exception {
		int re = -1;
		ClubDTO cto = sqlSession.selectOne("club_name_check", club_name);
		if (cto != null)
			re = 1;
		return re;
	}

	// 모임 등록
	@Transactional
	public void insertClub(ClubDTO club) throws Exception {
		System.out.println(club.getClub_num());
		System.out.println(club.getClub_host_email());
		System.out.println(club.getClub_name());
		System.out.println(club.getClub_image());
		System.out.println(club.getClub_region());
		System.out.println(club.getClub_keyword());
		System.out.println(club.getClub_info());
		System.out.println(club.getClub_member_count());
		System.out.println(club.getClub_member_limit());
		System.out.println(club.getClub_interest());
		System.out.println(club.getClub_chat());
		System.out.println(club.getClub_reg_date());
		System.out.println(club.getClub_del_yn());
		System.out.println(club.getClub_del_date());
		System.out.println(club.getClub_viewcount());

		sqlSession.insert("clubns.club", club);

	}

	public int insertclub_member_join(Club_Member_JoinDTO clubmj) throws Exception {

		System.out.println(clubmj.getJoin_num());
		System.out.println(clubmj.getMember_email());
		System.out.println(clubmj.getClub_num());
		System.out.println(clubmj.getJoin_hello());
		System.out.println(clubmj.getClub_host_yn());

		return sqlSession.insert("clubns.insertclub_member_join", clubmj);
	}

	public ClubDTO bringclubname(String club_name) throws Exception {
		return (ClubDTO) sqlSession.selectOne("clubns.bringclubname", club_name);
	}

	public ClubDTO getClubCont(int club_num) throws Exception {
		return (ClubDTO) sqlSession.selectOne("clubns.club_cont", club_num);

	}

	public void club(ClubDTO cedto) throws Exception {
		sqlSession.update("clubns.club_edit", cedto);
	}

	// 모임 정보 수정
	@Transactional
	public int updateClub(ClubDTO club) throws Exception {

		System.out.println(club.getClub_num());
		System.out.println(club.getClub_name());
		System.out.println(club.getClub_image());
		System.out.println(club.getClub_region());
		System.out.println(club.getClub_keyword());
		System.out.println(club.getClub_info());
		System.out.println(club.getClub_member_limit());
		System.out.println(club.getClub_interest());
		System.out.println(club.getClub_chat());

		return sqlSession.update("clubns.updateClub", club);
	}

	// 모임 삭제
	@Transactional
	public void deleteClub(int club_num) throws Exception {
		sqlSession.update("clubns.deleteClub", club_num);
	}

}