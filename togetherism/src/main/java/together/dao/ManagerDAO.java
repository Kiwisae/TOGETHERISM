package together.dao;

import java.util.List;

import together.model.ClubDTO;
import together.model.ClubJoinInfo;
import together.model.Club_Member_JoinDTO;
import together.model.EventDTO;
import together.model.Event_User_AttendDTO;
import together.model.ManagerDTO;
import together.model.MemberDTO;
import together.model.MemberReportInfo;
import together.model.ReportDTO;

public interface ManagerDAO {
	
	public ManagerDTO getManager (String manager_email);
	public List<ManagerDTO> getManagerlist(String sessionValue);
	public int get2dago();
	public int get1dago();
	public int getToday();
	public List<MemberReportInfo> getReport();
	public int memberCount();
	public List<MemberDTO> memberList(int page);
	public List<MemberDTO> getSearch(MemberDTO memberDto);
	public int nowMemeber();
	public List<MemberDTO> nowmemberList(int page);
	public MemberDTO getMember(MemberDTO member_email);
	public int reportCount(MemberDTO member_email);
	public List<ClubDTO> getClub(MemberDTO member_email);
	public List<ClubJoinInfo> getJoinclub(MemberDTO member_email);
	public List<Event_User_AttendDTO> getAttendevent(MemberDTO member_email);
	public List<EventDTO> getEvent(int event_num);
	public void memberDelete(MemberDTO member_email);
	
}
