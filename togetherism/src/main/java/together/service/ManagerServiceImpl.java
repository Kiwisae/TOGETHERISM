package together.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import together.dao.ManagerDAOImpl;
import together.model.ClubDTO;
import together.model.ClubJoinInfo;
import together.model.Club_Member_JoinDTO;
import together.model.EventDTO;
import together.model.Event_User_AttendDTO;
import together.model.ManagerDTO;
import together.model.MemberDTO;
import together.model.MemberReportInfo;
import together.model.ReportDTO;

@Service
public class ManagerServiceImpl implements ManagerService {
	
	@Autowired
	ManagerDAOImpl managerDao;
	
	//관리자 1명의 정보 가져오기
	public ManagerDTO getManager (String manager_email) {
		return managerDao.getManager(manager_email);
	}
	
	//관리자 전체 정보 가져오기
	public List<ManagerDTO> getManagerlist (String sessionValue) {
		return managerDao.getManagerlist(sessionValue);
	}
	
	//2일전 가입한 회원의 수
	public int get2dago() {
		return managerDao.get2dago();
	}
	
	//1일전 가입한 회원의 수
	public int get1dago() {
		return managerDao.get1dago();
	}
	
	//오늘 가입한 회원의 수
	public int getToday() {
		return managerDao.getToday();
	}
	
	//신고 많이 당한 회원 리스트
	public List<MemberReportInfo> getReport() {
		return managerDao.getReport();
	}
	
	//전체 회원의 수
	public int memberCount() {
		return managerDao.memberCount();
	}
	
	//전체 회원 목록 가져오기
	public List<MemberDTO> memberList(int page) {
		return managerDao.memberList(page);
	}
	
	//검색 목록 가져오기
	public List<MemberDTO> getSearch(MemberDTO memberDto) {
		return managerDao.getSearch(memberDto);
	}
	
	//현재 활동중인 회원의 수
	public int nowMemeber() {
		return managerDao.nowMemeber();
	}
	
	//현재 활동중인 회원 목록 가져오기
	public List<MemberDTO> nowmemberList(int page) {
		return managerDao.nowmemberList(page);
	}
	
	//특정 회원 1명의 정보 가져오기
	public MemberDTO getMember(MemberDTO member_email) {
		return managerDao.getMember(member_email);
	}
	
	//특정 회원 1명의 신고 횟수 가져오기
	public int reportCount(MemberDTO member_email) {
		return managerDao.reportCount(member_email);
	}
	
	//특정 회원의 모임장 리스트 가져오기
	public List<ClubDTO> getClub(MemberDTO member_email) {
		return managerDao.getClub(member_email);
	}
	
	//특정 회원의 가입 모임 리스트 가져오기
	public List<ClubJoinInfo> getJoinclub(MemberDTO member_email) {
		return managerDao.getJoinclub(member_email);
	}
	
	//특정 회원이 참석한 이벤트 목록에서 event_num 가져오기
	public List<Event_User_AttendDTO> getAttendevent(MemberDTO member_email){
		return managerDao.getAttendevent(member_email);
	}
	
	//특정 회원이 참석한 이벤트 목록 가져오기
	public List<EventDTO> getEvent(int event_num) {
		return managerDao.getEvent(event_num);
	}
	
	//특정 회원 강제 탈퇴
	public void memberDelete(MemberDTO member_email) {
		managerDao.memberDelete(member_email);
		
	}
}
