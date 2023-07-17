package crafty.service;

import java.sql.SQLException;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import crafty.mapper.NondisclosureRequestMapper;

@Service
public class NondisclosureRequestService {
	
	@Autowired
	NondisclosureRequestMapper nondisclosureRequestMapper;

	public int insertNondisclosureRequest(HashMap<String, Object> hashmap) throws SQLException {
		int result = nondisclosureRequestMapper.insertNondisclosureRequest(hashmap);
		
		return result;
	}
	
	// 굿즈 비공개 불허
	public int updateNondisclosureRequestNondisclosureStatusByGoodsId(int goodsId) throws SQLException{
		int result = nondisclosureRequestMapper.updateNondisclosureRequestNondisclosureStatusByGoodsId(goodsId);
		
		return result;
	}
}
