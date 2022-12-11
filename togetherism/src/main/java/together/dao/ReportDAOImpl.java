package together.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import together.model.ReportDTO;

@Repository
public class ReportDAOImpl implements ReportDAO{

	@Autowired
	private SqlSession sqlSession;

	
	@Override
	public int reportCount(String member_email) throws Exception {
		// TODO Auto-generated method stub
		return ((Integer)sqlSession.selectOne("report_count", member_email)).intValue();

	}


	@Override
	public ReportDTO reportCheck(ReportDTO report) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("report_check", report);
	}


	@Override
	public int reportInsert(ReportDTO report) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("report_insert", report);
	}
	
	
	
}
