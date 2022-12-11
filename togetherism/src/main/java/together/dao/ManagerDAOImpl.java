package together.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import together.model.ClubDTO;
import together.model.ClubJoinInfo;
import together.model.Club_Member_JoinDTO;
import together.model.EventDTO;
import together.model.Event_User_AttendDTO;
import together.model.ManagerDTO;
import together.model.MemberDTO;
import together.model.MemberReportInfo;
import together.model.ReportDTO;

@Repository
public class ManagerDAOImpl implements ManagerDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	//관리자 1명의 정보 가져오기
	public ManagerDTO getManager (String manager_email) {
		return sqlSession.selectOne("managerns.getManager", manager_email);
	}
	
	//관리자 전체 정보 가져오기
	public List<ManagerDTO> getManagerlist (String sessionValue) {
		return sqlSession.selectList("managerns.getManagerlist", sessionValue);
	}
	
	//2일전 가입한 회원의 수
	public int get2dago() {
		return sqlSession.selectOne("managerns.get2dago");
	}
	
	//1일전 가입한 회원의 수
	public int get1dago() {
		return sqlSession.selectOne("managerns.get1dago");
	}
	
	//오늘 가입한 회원의 수
	public int getToday() {
		return sqlSession.selectOne("managerns.getToday");
	}
	
	//신고 많이 당한 회원 리스트
	public List<MemberReportInfo> getReport() {
		return sqlSession.selectList("managerns.getReport");
	}
	
	//전체 회원의 수
	public int memberCount() {
		return sqlSession.selectOne("managerns.memberCount");
	}
	
	//전체 회원 목록 가져오기
	public List<MemberDTO> memberList(int page) {
		return sqlSession.selectList("managerns.memberList", page);
	}
	
	//이메일, 닉네임 검색 목록 가져오기
	public List<MemberDTO> getSearch(MemberDTO memberDto) {
		return sqlSession.selectList("managerns.getSearch", memberDto);
	}
	
	//현재 활동중인 회원의 수
	public int nowMemeber() {
		return sqlSession.selectOne("managerns.nowMember");
	}
	
	//현재 활동중인 회원 목록 가져오기
	public List<MemberDTO> nowmemberList(int page) {
		return sqlSession.selectList("managerns.nowmemberList", page);
	}
	
	//특정 회원 1명의 정보 가져오기
	public MemberDTO getMember(MemberDTO member_email) {
		return sqlSession.selectOne("managerns.getMember", member_email);
	}
	
	//특정 회원 1명의 신고 횟수 가져오기
	public int reportCount(MemberDTO member_email) {
		return sqlSession.selectOne("managerns.reportCount", member_email);
	}
	
	//특정 회원의 모임장 리스트 가져오기
	public List<ClubDTO> getClub(MemberDTO member_email) {
		return sqlSession.selectList("managerns.getClub", member_email);
	}
	
	//특정 회원의 가입 모임 리스트 가져오기
	public List<ClubJoinInfo> getJoinclub(MemberDTO member_email) {
		return sqlSession.selectList("managerns.getJoinclub", member_email);
	}
	
	//특정 회원이 참석한 이벤트 목록에서 event_num 가져오기
	public List<Event_User_AttendDTO> getAttendevent(MemberDTO member_email){
		return sqlSession.selectList("managerns.getAttendevent", member_email);
	}
	
	//특정 회원이 참석한 이벤트 목록 가져오기
	public List<EventDTO> getEvent(int event_num) {
		return sqlSession.selectList("managerns.getEevent", event_num);
	}
	
	//특정 회원 강제 탈퇴
	public void memberDelete(MemberDTO member_email) {
		sqlSession.update("managerns.memberDelete", member_email);
		
	}
}
