package crafty.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import crafty.dto.Goods;
import crafty.dto.OpenAlarm;

@Mapper
public interface OpenAlarmMapper {
	public List<OpenAlarm> AlarmList();
	
	public List<Goods> getGoodsByMemberId(int memberId);
}
