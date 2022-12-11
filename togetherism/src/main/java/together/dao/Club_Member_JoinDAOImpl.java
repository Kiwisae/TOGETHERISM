package together.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import together.model.ClubDTO;
import together.model.ClubMemberInfo;
import together.model.Club_Member_JoinDTO;
import together.model.MemberDTO;

@Repository
public class Club_Member_JoinDAOImpl implements Club_Member_JoinDAO{

	@Autowired
	private SqlSession sqlSession;
	
	public Club_Member_JoinDTO getJoin(Club_Member_JoinDTO cmjdto) {
		return sqlSession.selectOne("club_member_joinns.joincont",cmjdto);
	}
	
	// member 테이블과 연동할 것, merge 후 수정
	public MemberDTO getMember(String sess) {
		return sqlSession.selectOne("club_member_joinns.membercont",sess);
	}
	
	public int clubJoin(Club_Member_JoinDTO cmj) {
		return sqlSession.insert("club_member_joinns.join",cmj);
	}
	
	// club 테이블과 연동할 것, merge 후 수정, 클럽 멤버수 한명 증가
	public void updateMemberCount(int club_num) {
		sqlSession.update("club_member_joinns.updatecount",club_num);
	}
	
	public List<Club_Member_JoinDTO> getClubMember(int club_num){
		return sqlSession.selectList("club_member_joinns.clubmember",club_num);
	}
	
	// club 테이블과 연동할 것, merge 후 수정, 클럽 하나 상세정보가져오기
	public ClubDTO getClubCont(int club_num) {
		return sqlSession.selectOne("club_member_joinns.clubcont",club_num);
	}
	
	public List<ClubDTO> getJoinedClub(Map<String, Object> map){
		return sqlSession.selectList("club_member_joinns.joinedclub",map);
	}
	
	// club 테이블과 연동할 것, merge 후 수정, 특정 클럽번호들의 클럽 리스트 가져오기
	public List<ClubDTO> getClubList(List<Club_Member_JoinDTO> cmjlist){
		return sqlSession.selectList("club_member_joinns.clublist",cmjlist);
	}
	
	// 모임장인지 확인
	public String getClubHostYN(Club_Member_JoinDTO cmjdto) {
		return sqlSession.selectOne("club_member_joinns.clubhostyn", cmjdto);
	}
	
	public int leaveClub(Club_Member_JoinDTO cmjdto) {
		return sqlSession.delete("club_member_joinns.leave",cmjdto);
	}
	
	// club 테이블과 연동할 것, merge 후 수정, 탈퇴 후 클럽 멤버수 1명 감소
	public void minusMemberCount(int club_num) {
		sqlSession.update("club_member_joinns.minuscount",club_num);
	}
	
	public List<Club_Member_JoinDTO> getMyClub(Map<String, Object> map){
		return sqlSession.selectList("club_member_joinns.myclub", map);
	}
	
	// club 테이블과 연동할 것, merge 후 수정, 상세페이지 이동시 모임의 조회수 증가
	public void getUpdateViewCount(int club_cum) {
		sqlSession.update("club_member_joinns.updatevc", club_cum);
	}
	
	// member 테이블과 club_member_join 조인, 특정 클럽의 멤버 리스트 가져오기
	public List<ClubMemberInfo> getMemberList(int club_num){
		return sqlSession.selectList("club_member_joinns.memberlist",club_num);
	}
	

	// club 테이블과 연동할 것, merge 후 수정, 모임 리스트 개수 구하기
	public int getClubListCount(Map<String, Object> map) {
		return sqlSession.selectOne("club_member_joinns.listcount",map);
	}
	
	// club 테이블과 연동할 것, merge 후 수정, 모임 리스트 가져오기
	public List<ClubDTO> getClubListAll(Map<String, Object> map){
		return sqlSession.selectList("club_member_joinns.clublistall",map);
	}
	
	// club 테이블과 연동할 것, merge 후 수정, 모임 프리뷰 리스트 가져오기
	public List<ClubDTO> getClubListPreview(String preview){
		return sqlSession.selectList("club_member_joinns.clublistpre",preview);
	}
	
	// 내가 가입된 모임 리스트 출력 : 내가 가입된 모임 리스트 개수
	public int getjoinedClubListCount(String sess) {
		return sqlSession.selectOne("club_member_joinns.joinedclubcount",sess);
	}
	// 내가 운영하는 모임 리스트 출력 : 내가 운영하는 모임 리스트 개수
	public int getmyClubListCount(String sess) {
		return sqlSession.selectOne("club_member_joinns.myclubcount",sess);
	}
}
