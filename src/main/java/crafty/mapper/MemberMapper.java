package crafty.mapper;

import java.sql.SQLException;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import crafty.dto.Member;
import crafty.dto.RequestPayment;
import crafty.dto.ResponseProfile;

@Mapper
public interface MemberMapper {
	// login
	Member getMemberById(Map<String, Object> params);
	
	// signUp(insert Member)
	int signUp(Member member) throws SQLException;
	
	// find id
	Member getMemberByNameAndPhone(Member member);
	// find pw
	Member getMemberByIdAndPhone(Member member);
	// reset pw
	void updateMemberPassword(Member foundMember);

	ResponseProfile getProfileByMemberId(int memberId) throws SQLException;

	RequestPayment getMemberByMemberId(int memberId) throws SQLException;
	
	
}
