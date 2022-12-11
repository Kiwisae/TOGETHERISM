package together.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import together.dao.Club_Member_JoinDAO;
import together.model.ClubDTO;
import together.model.ClubMemberInfo;
import together.model.Club_Member_JoinDTO;
import together.model.MemberDTO;

@Service
public class Club_Member_JoinServiceImpl implements Club_Member_JoinService {

	@Autowired
	private Club_Member_JoinDAO club_Member_JoinDAO;
	
	public Club_Member_JoinDTO getJoin(Club_Member_JoinDTO cmjdto) {
		return club_Member_JoinDAO.getJoin(cmjdto);
	}
	// member 테이블과 연동할 것, merge 후 수정
	public MemberDTO getMember(String sess) {
		return club_Member_JoinDAO.getMember(sess);
	}
	
	public int clubJoin(Club_Member_JoinDTO cmj) {
		return club_Member_JoinDAO.clubJoin(cmj);
	}
	
	// club 테이블과 연동할 것, merge 후 수정, 클럽 멤버수 한명 증가
	public void updateMemberCount(int club_num) {
		club_Member_JoinDAO.updateMemberCount(club_num);
	}
	
	public List<Club_Member_JoinDTO> getClubMember(int club_num){
		return club_Member_JoinDAO.getClubMember(club_num);
	}
	
	// club 테이블과 연동할 것, merge 후 수정, 클럽 하나 상세정보가져오기
	public ClubDTO getClubCont(int club_num) {
		return club_Member_JoinDAO.getClubCont(club_num);
	}
	
	public List<ClubDTO> getJoinedClub(Map<String, Object> map){
		return club_Member_JoinDAO.getJoinedClub(map);
	}
	
	// club 테이블과 연동할 것, merge 후 수정, 특정 클럽번호들의 클럽 리스트 가져오기
	public List<ClubDTO> getClubList(List<Club_Member_JoinDTO> cmjlist){
		return club_Member_JoinDAO.getClubList(cmjlist);
	}
	
	public String getClubHostYN(Club_Member_JoinDTO cmjdto) {
		return club_Member_JoinDAO.getClubHostYN(cmjdto);
	}
	
	public int leaveClub(Club_Member_JoinDTO cmjdto) {
		return club_Member_JoinDAO.leaveClub(cmjdto);
	}
	
	// club 테이블과 연동할 것, merge 후 수정, 탈퇴 후 클럽 멤버수 1명 감소
	public void minusMemberCount(int club_num) {
		club_Member_JoinDAO.minusMemberCount(club_num);
	}
	
	public List<Club_Member_JoinDTO> getMyClub(Map<String, Object> map){
		return club_Member_JoinDAO.getMyClub(map);
	}
	
	// club 테이블과 연동할 것, merge 후 수정, 상세페이지 이동시 모임의 조회수 증가
	public void getUpdateViewCount(int club_cum) {
		club_Member_JoinDAO.getUpdateViewCount(club_cum);
	}
	
	// member 테이블과 club_member_join 조인, 특정 클럽의 멤버 리스트 가져오기
	public List<ClubMemberInfo> getMemberList(int club_num){
		return club_Member_JoinDAO.getMemberList(club_num);
	}
	
	// club 테이블과 연동할 것, merge 후 수정, 모임 리스트 개수 구하기
	public int getClubListCount(Map<String, Object> map) {
		return club_Member_JoinDAO.getClubListCount(map);
	}
	
	// club 테이블과 연동할 것, merge 후 수정, 모임 리스트 가져오기
	public List<ClubDTO> getClubListAll(Map<String, Object> map){
		return club_Member_JoinDAO.getClubListAll(map);
	}
	
	// club 테이블과 연동할 것, merge 후 수정, 모임 프리뷰 리스트 가져오기
	public List<ClubDTO> getClubListPreview(String preview){
		return club_Member_JoinDAO.getClubListPreview(preview);
	}
	
	// 내가 가입된 모임 리스트 출력 : 내가 가입된 모임 리스트 개수
	public int getjoinedClubListCount(String sess) {
		return club_Member_JoinDAO.getjoinedClubListCount(sess);
	}
	
	// 내가 운영하는 모임 리스트 출력 : 내가 운영하는 모임 리스트 개수
	public int getmyClubListCount(String sess) {
		return club_Member_JoinDAO.getmyClubListCount(sess);
	}
}
