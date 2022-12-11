package together.service;

import java.util.List;
import java.util.Map;

import together.model.ClubDTO;
import together.model.ClubMemberInfo;
import together.model.Club_Member_JoinDTO;
import together.model.MemberDTO;

public interface Club_Member_JoinService {
	
	// 가입정보 가져오기 : 중복 가입 방지
	public Club_Member_JoinDTO getJoin(Club_Member_JoinDTO cmjdto);
	
	// member 테이블과 연동할 것, merge 후 수정
	public MemberDTO getMember(String sess);
	
	// 모임가입 테이블에 insert 해서 회원이 모임을 가입
	public int clubJoin(Club_Member_JoinDTO cmj);
	
	// club 테이블과 연동할 것, merge 후 수정, 클럽 멤버수 한명 증가
	public void updateMemberCount(int club_num);
	
	// 모임에 가입된 회원 리스트 불러오기
	public List<Club_Member_JoinDTO> getClubMember(int club_num);

	// club 테이블과 연동할 것, merge 후 수정, 클럽 하나 상세정보가져오기
	public ClubDTO getClubCont(int club_num);
	
	// 내가 가입한 모임 목록을 가져오기
	public List<ClubDTO> getJoinedClub(Map<String, Object> map);
	
	// club 테이블과 연동할 것, merge 후 수정, 특정 클럽번호들의 클럽 리스트 가져오기
	public List<ClubDTO> getClubList(List<Club_Member_JoinDTO> cmjlist);
	
	// 모임장인지 확인
	public String getClubHostYN(Club_Member_JoinDTO cmjdto);
	
	// 모임 탈퇴
	public int leaveClub(Club_Member_JoinDTO cmjdto);
	
	// club 테이블과 연동할 것, merge 후 수정, 탈퇴 후 클럽 멤버수 1명 감소
	public void minusMemberCount(int club_num);
	
	// 내가 운영하는 모임의 리스트 구하기
	public List<Club_Member_JoinDTO> getMyClub(Map<String, Object> map);
	
	// club 테이블과 연동할 것, merge 후 수정, 상세페이지 이동시 모임의 조회수 증가
	public void getUpdateViewCount(int club_cum);
	
	// member 테이블과 club_member_join 조인, 특정 클럽의 멤버 리스트 가져오기
	public List<ClubMemberInfo> getMemberList(int club_num);
	
	// club 테이블과 연동할 것, merge 후 수정, 모임 리스트 개수 구하기
	public int getClubListCount(Map<String, Object> map);
	
	// club 테이블과 연동할 것, merge 후 수정, 모임 리스트 가져오기
	public List<ClubDTO> getClubListAll(Map<String, Object> map);
	
	// club 테이블과 연동할 것, merge 후 수정, 모임 프리뷰 리스트 가져오기
	public List<ClubDTO> getClubListPreview(String preview);
	
	// 내가 가입된 모임 리스트 출력 : 내가 가입된 모임 리스트 개수
	public int getjoinedClubListCount(String sess);
	
	// 내가 운영하는 모임 리스트 출력 : 내가 운영하는 모임 리스트 개수
	public int getmyClubListCount(String sess);
}
