package together.service;

import java.util.List;

import together.model.Club_Member_JoinDTO;
import together.model.MemberDTO;


	public interface MemberService {
		
	public int checkMemberEmail(String member_email) throws Exception;
		
	public int checkMemberNickname(String member_nickname) throws Exception;
	
	public void insertMember(MemberDTO member) throws Exception;

	public MemberDTO userCheck(String email) throws Exception;

	public void updateMember(MemberDTO member) throws Exception;

	public MemberDTO findPwd(MemberDTO member) throws Exception;
	
	public MemberDTO findemail(MemberDTO member) throws Exception;

	public void deleteMember(MemberDTO member) throws Exception;
	
	public List<Club_Member_JoinDTO> checkHost(String email) throws Exception;
	
	public void deleteJoinclub(String email) throws Exception;
	
	public void deleteHeart(String email) throws Exception;
	
	public void deleteEventattend(String email) throws Exception;
	
	public void reduceClubmemeber(String email) throws Exception;

}
