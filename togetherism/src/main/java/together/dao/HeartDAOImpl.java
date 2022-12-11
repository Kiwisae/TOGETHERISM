package together.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import together.model.ClubHeartJoin;
import together.model.HeartDTO;

@Repository
public class HeartDAOImpl implements HeartDAO{
	
	@Autowired
	private SqlSession sqlSession;	

	public int insertHeart(HeartDTO heartdto) throws Exception {
		return sqlSession.insert("heartns.insert_heart", heartdto);
				
	}
	
	public void removeHeart(HeartDTO heartdto) throws Exception {
		sqlSession.delete("heartns.remove_heart", heartdto);
		
	}
	
	//내가 좋아요한 모임 리스트
	public List<ClubHeartJoin> getHeartList(Map<String, Object> map) throws Exception {
		List<ClubHeartJoin> list = sqlSession.selectList("heartns.heart_list", map);

		return list;
	}
	
	public int getHeartListCount(Map<String, Object> map) throws Exception{
		return sqlSession.selectOne("heartns.heart_listcount", map);
	}
	
//	//Heart Check
	public HeartDTO heart_check(HeartDTO heartdto) throws Exception{
		return sqlSession.selectOne("heartns.heart_check", heartdto);
		
	}
	
}
