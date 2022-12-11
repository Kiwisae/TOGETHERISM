package together.service;

import java.util.List;
import java.util.Map;

import together.model.ClubHeartJoin;
import together.model.HeartDTO;

public interface HeartService {
	public int insertHeart(HeartDTO heartdto) throws Exception;
	
	public void removeHeart(HeartDTO heartdto) throws Exception;
	
	public List<ClubHeartJoin> getHeartList(Map<String, Object> map) throws Exception;
	
	public int getHeartListCount(Map<String, Object> map) throws Exception;
	
	public HeartDTO heart_check(HeartDTO heartdto) throws Exception;

}
