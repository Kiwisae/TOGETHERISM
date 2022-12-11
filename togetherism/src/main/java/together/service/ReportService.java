package together.service;

import together.model.ReportDTO;

public interface ReportService {
	
	public int reportCount(String member_email) throws Exception;
	
	public ReportDTO reportCheck(ReportDTO report) throws Exception;
	
	public int reportInsert(ReportDTO report) throws Exception;

}
