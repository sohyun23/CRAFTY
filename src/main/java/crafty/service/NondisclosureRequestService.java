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
	
}
