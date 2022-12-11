package together.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import together.dao.ReportDAOImpl;
import together.model.ReportDTO;

@Service
public class ReportServiceImpl implements ReportService{
	
	@Autowired
	private ReportDAOImpl reDAO;

	@Override
	public int reportCount(String member_email) throws Exception {
		// TODO Auto-generated method stub
		
		return reDAO.reportCount(member_email);
	}

	@Override
	public ReportDTO reportCheck(ReportDTO report) throws Exception {
		// TODO Auto-generated method stub
		return reDAO.reportCheck(report);
	}

	@Override
	public int reportInsert(ReportDTO report) throws Exception {
		// TODO Auto-generated method stub
		return reDAO.reportInsert(report);
	}

}
