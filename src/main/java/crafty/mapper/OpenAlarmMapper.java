package crafty.mapper;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import crafty.dto.Goods;
import crafty.dto.OpenAlarm;
import crafty.dto.ResponseGoodsManagement;
import crafty.pagination.dto.PageRequestDTO;
import crafty.pagination.dto.MainCard;

@Mapper
public interface OpenAlarmMapper {
	
    // 좋아요
    public int insertAlarmByGoodsIdAndMemberId(HashMap<String, Object> hashmap) throws SQLException;

    public int deleteAlarmByAlarmId(int alarmId) throws SQLException;
    
	public List<MainCard> openAlarmGoodsByMemberId(HashMap hashmap) throws SQLException;
	
	public int openAlarmGoodsTotalCount(int memberId) throws SQLException;
}
