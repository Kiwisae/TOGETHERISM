package together.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import together.dao.MemberDAOImpl;
import together.model.Club_Member_JoinDTO;
import together.model.MemberDTO;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberDAOImpl memberDao;
	
	

	@Override
	public int checkMemberEmail(String member_email) throws Exception {
		// TODO Auto-generated method stub
		return memberDao.checkMemberEmail(member_email);
	}
	

	@Override
	public int checkMemberNickname(String member_nickname) throws Exception {
		// TODO Auto-generated method stub
		return memberDao.checkMemberNickname(member_nickname);
	} 

	@Override
	public void insertMember(MemberDTO member) throws Exception {
		// TODO Auto-generated method stub
		memberDao.insertMember(member);
	}

	@Override
	public MemberDTO userCheck(String email) throws Exception {
		// TODO Auto-generated method stub
		return memberDao.userCheck(email);
	
	}

	@Override
	public void updateMember(MemberDTO member) throws Exception{
		// TODO Auto-generated method stub
		memberDao.updateMember(member);
	}

	@Override
	public MemberDTO findPwd(MemberDTO member) throws Exception{
		// TODO Auto-generated method stub
		return memberDao.findPwd(member);
	}


	@Override
	public MemberDTO findemail(MemberDTO member) throws Exception{
		// TODO Auto-generated method stub
		return memberDao.findemail(member);
	}

	@Override
	public void deleteMember(MemberDTO member) throws Exception{
		// TODO Auto-generated method stub
		memberDao.deleteMember(member);
		
	}


	@Override
	public List<Club_Member_JoinDTO> checkHost(String email) throws Exception {
		// TODO Auto-generated method stub
		return memberDao.checkHost(email);
	}


	@Override
	public void deleteJoinclub(String email) throws Exception {
		memberDao.deleteJoinclub(email);
	}


	@Override
	public void deleteHeart(String email) throws Exception {
		// TODO Auto-generated method stub
		memberDao.deleteHeart(email);
	}


	@Override
	public void deleteEventattend(String email) throws Exception {
		// TODO Auto-generated method stub
		memberDao.deleteEventattend(email);
	}


	@Override
	public void reduceClubmemeber(String email) throws Exception {
		// TODO Auto-generated method stub
		memberDao.reduceClubmemeber(email);
	}


	
}
