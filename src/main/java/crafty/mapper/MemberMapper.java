package crafty.mapper;
import java.sql.Timestamp;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import crafty.dto.Member;
import crafty.dto.MemberEmailInfo;
import crafty.dto.RequestPayment;
import crafty.dto.ResponseProfile;

@Mapper
public interface MemberMapper {
		// login
		Member getMemberById(Map<String, Object> params);
		
		// signUp(insert Member)
		int signUp(Member member) throws SQLException;

		// signUp(validation)
		boolean isIdExists(String id);
		boolean isNicknameExists(String nickname);
		boolean isPhoneNumberExists(String phoneNumber);
		boolean isEmailExists(String email);
		
		// find id
		Member getMemberByNameAndPhone(Member member);
		// find pw
		Member getMemberByIdAndPhone(Member member);
		// reset pw
		void updateMemberPassword(@Param("loginPw") String loginPw, @Param("memberId") int memberId);


		// Member getMemberByMemberId(int memberId);

		void updateMemberLastLoginDate(int memberId, Timestamp lastLoginDate);

		// profile update & member_update_date
		void updateMember(Member member);
		
		// last login date(time stamp)
		void updateLastLoginDate(Member member);

	ResponseProfile getProfileByMemberId(int memberId) throws SQLException;
	
	// 결제 정보 저장을 위한 멤버 정보
	RequestPayment getMemberByMemberId(int memberId) throws SQLException;
	
	// 오픈 알람 메일 전송을 위한 멤버 리스트
	List<MemberEmailInfo> getAlarmedMemberEmail() throws SQLException;

	// 굿즈 허가 / 불허가 메일 전송을 위한 멤버 정보
	MemberEmailInfo getMemberEmailInfoByGoodsId(int goodsId) throws SQLException;
	
}
