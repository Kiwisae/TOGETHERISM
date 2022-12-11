package together.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import together.model.Club_Member_JoinDTO;
import together.model.MemberDTO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int checkMemberEmail(String member_email) throws Exception {
		// TODO Auto-generated method stub
	
		int re = -1;	// 사용 가능한 ID
		MemberDTO member = (MemberDTO) sqlSession.selectOne("member_emailcheck", member_email);
		
		if (member != null)
			re = 1; 	// 중복id
		return re;
	}
	
	@Override
	public int checkMemberNickname(String member_nickname) throws Exception {
		// TODO Auto-generated method stub
		int re = -1;	// 사용 가능한 닉네임
		MemberDTO member = (MemberDTO) sqlSession.selectOne("member_nickcheck", member_nickname);
		
		if (member != null)
			re = 1; 	// 중복 닉네임
		
		
		return re;
	}

	@Override
	public void insertMember(MemberDTO member) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("member_insert", member);
	}

	@Override
	public MemberDTO userCheck(String email) throws Exception{
		// TODO Auto-generated method stub
		return (MemberDTO) sqlSession.selectOne("member_usercheck", email);
	}

	@Override
	public void updateMember(MemberDTO member) throws Exception{
		// TODO Auto-generated method stub
		sqlSession.update("member_edit", member);
	}

	@Override
	public MemberDTO findPwd(MemberDTO member) throws Exception{
		// TODO Auto-generated method stub
		return sqlSession.selectOne("member_pwfind", member);
	}

	@Override
	public MemberDTO findemail(MemberDTO member) throws Exception{
		// TODO Auto-generated method stub
		return sqlSession.selectOne("member_emailfind", member);
	}

	@Override
	public void deleteMember(MemberDTO member) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("member_delete", member);
	}

	@Override
	public List<Club_Member_JoinDTO> checkHost(String email) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("member_hostCheck", email);
	}

	@Override
	public void deleteJoinclub(String email) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete("club_member_join_delete", email);
	}

	@Override
	public void deleteHeart(String email) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete("heart_delete", email);
	}

	@Override
	public void deleteEventattend(String email) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete("event_attend_delete", email);
	}

	@Override
	public void reduceClubmemeber(String email) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("reduce_Clubmemeber", email);
	}
	
}
