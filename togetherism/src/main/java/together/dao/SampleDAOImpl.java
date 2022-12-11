package together.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import together.model.SampleDTO;

@Repository
public class SampleDAOImpl implements SampleDAO{
	/*
	 * 의미 없는 샘플 페이지, 이 페이지를 참고하셔서 각자 DAO 클래스를 만드시면 됩니다
	 */
	@Autowired
	private SqlSession sqlSession;
	
	public SampleDTO testselect(String pw) {
		System.out.println("DAO arrived");

		return (SampleDTO)(sqlSession.selectList("samplens.test", pw)).get(0);
	}
}
