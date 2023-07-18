package crafty.service;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import crafty.dto.ResponseProfile;
import crafty.mapper.MemberMapper;

@Service
public class MemberService {

	@Autowired
	MemberMapper memberMapper;
	
	public ResponseProfile getProfileByMemberId(int memberId) throws SQLException {
		ResponseProfile profile = memberMapper.getProfileByMemberId(memberId);
		
		return profile;
	}

}
