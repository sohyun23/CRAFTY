package crafty.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import crafty.dto.Goods;
import crafty.dto.OpenAlarm;
import crafty.mapper.OpenAlarmMapper;

@Service
public class OpenAlarmService {
	@Autowired
	OpenAlarmMapper openAlarmMapper;
	
	//객체?
	public List<Goods> getAlarmByMemberId(int memberId){
		List<Goods> goodsList = openAlarmMapper.getGoodsByMemberId(memberId);
		
		return goodsList;
	}
}
