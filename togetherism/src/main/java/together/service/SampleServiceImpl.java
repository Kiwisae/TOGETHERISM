package together.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import together.dao.SampleDAO;
import together.model.SampleDTO;

@Service
public class SampleServiceImpl implements SampleService{
	
	@Autowired
	private SampleDAO sampleDao;
	
	public SampleDTO testselect(String pw) {
		System.out.println("Service arrived");

		return sampleDao.testselect(pw);
	}
}
