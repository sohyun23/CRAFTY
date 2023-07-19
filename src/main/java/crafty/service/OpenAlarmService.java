package crafty.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import crafty.dto.Goods;
import crafty.dto.OpenAlarm;
import crafty.mapper.OpenAlarmMapper;
import crafty.pagination.dto.MainCard;
import crafty.pagination.dto.PageRequestDTO;

@Service
public class OpenAlarmService {
	@Autowired
	OpenAlarmMapper openAlarmMapper;
	
	//객체?
	public List<MainCard> openAlarmGoodsByMemberId(HashMap<String, Object> hashmap) throws SQLException {
		List<MainCard> goodsList = openAlarmMapper.openAlarmGoodsByMemberId(hashmap);
		
		return goodsList;
	}
	
	public int openAlarmGoodsTotalCount(int memberId) throws SQLException {
	    int result = openAlarmMapper.openAlarmGoodsTotalCount(memberId);
	    return result;
	}
}
