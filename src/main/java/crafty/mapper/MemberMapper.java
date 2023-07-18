package crafty.mapper;

import java.sql.SQLException;

import org.apache.ibatis.annotations.Mapper;

import crafty.dto.ResponseProfile;

@Mapper
public interface MemberMapper {

	ResponseProfile getProfileByMemberId(int memberId) throws SQLException;
	
	
	
}
