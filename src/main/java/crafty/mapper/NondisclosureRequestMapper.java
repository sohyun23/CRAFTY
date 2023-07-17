package crafty.mapper;

import java.sql.SQLException;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NondisclosureRequestMapper {

	int insertNondisclosureRequest(HashMap<String, Object> hashmap) throws SQLException;
	
	int updateNondisclosureRequestNondisclosureStatusByGoodsId(int goodsId) throws SQLException;
}
