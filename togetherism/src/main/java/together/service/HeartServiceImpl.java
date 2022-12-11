package together.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import together.dao.HeartDAO;
import together.model.ClubHeartJoin;
import together.model.HeartDTO;

@Service
public class HeartServiceImpl implements HeartService {
	
	@Autowired
	private HeartDAO heartDao;

	public int insertHeart(HeartDTO heartdto) throws Exception{
		return heartDao.insertHeart(heartdto);
	}
	
	public void removeHeart(HeartDTO heartdto) throws Exception{
		heartDao.removeHeart(heartdto);
	}
	
	// 내가 좋아요한 모임 리스트
	@Override
	public List<ClubHeartJoin> getHeartList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return heartDao.getHeartList(map);
	}
	
	public int getHeartListCount(Map<String, Object> map) throws Exception {
		return heartDao.getHeartListCount(map);
	}
	
	public HeartDTO heart_check(HeartDTO heartdto) throws Exception {
	return heartDao.heart_check(heartdto);
	}
}
