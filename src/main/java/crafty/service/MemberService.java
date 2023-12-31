package crafty.service;

import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import crafty.dto.Member;
import crafty.dto.MemberEmailInfo;
import crafty.dto.RequestPayment;
import crafty.dto.ResponseProfile;
import crafty.mapper.MemberMapper;
import crafty.repository.MemberRepository;

@Service
public class MemberService {

	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	private MemberRepository memberRepository;
	
	@Autowired
    private JavaMailSender emailSender;
	
	public ResponseProfile getProfileByMemberId(int memberId) throws SQLException {
		ResponseProfile profile = memberMapper.getProfileByMemberId(memberId);
		
		return profile;
	}
	
	@Autowired
    public MemberService(MemberMapper memberMapper,JavaMailSender emailSender) {
        this.memberMapper = memberMapper;
        this.emailSender = emailSender;
    }

	// login
    public Member getMemberById(String id) throws Exception {
    	Map<String, Object> params = new HashMap<>();
        params.put("id", id);
        
        Member member = memberMapper.getMemberById(params);

        if(member == null) {
            throw new Exception("아이디 또는 비밀번호가 틀렸습니다.");
        }
        
        return member;
    }

    // check password logic
    public boolean checkPw(String id, String pw) throws Exception {
        Member member = getMemberById(id);
        return BCrypt.checkpw(pw, member.getLoginPw());
    }
    
    // signUp
    public boolean signUp(Member member) throws SQLException, Exception {
        boolean result = false;
        int res = memberMapper.signUp(member);
        if(res != 0) {
            result = true;
        } else {
            throw new Exception("회원 가입 실패");
        }
        return result;
    }
    
    // 회원가입 유효성 검사
    public boolean isNicknameExists(String nickname) {
    	     	
    	System.out.println("nickname :" + nickname);
    	
    	if(memberMapper.isNicknameExists(nickname) > 0) {
    		return true;
    	}
    	else {
    		return false;
    	}			
    }

    public boolean isIdExists(String id) {
    	if(memberMapper.isIdExists(id) > 0) {
    		return true;
    	}
    	else {
    		return false;
    	}
    }
    
    public boolean isPhoneNumExists(String phoneNum) {
    	if(memberMapper.isPhoneNumExists(phoneNum) > 0) {
    		return true;
    	}
    	else {
    		return false;
    	}
    }

    public boolean isEmailExists(String email) {
    	if(memberMapper.isEmailExists(email) > 0) {
    		return true;
    	}
    	else {
    		return false;
    	}
    }
    
    
    // findAccount   
    // find id
    public String findId(Member member) throws Exception {
        Member foundMember = memberMapper.getMemberByNameAndPhone(member);
        if (foundMember != null) {
            return foundMember.getLoginId();
        } else {
            throw new Exception("Member not found");
        }
    }
    // reset pw
    // findPw
    public String resetPw(Member member) throws Exception {
        Member foundMember = memberMapper.getMemberByIdAndPhone(member);
        if (foundMember != null) {
        	// 임시 비밀번호 생성
            String newPw = generateTempPw();
            
            // 비밀번호 해싱
            String encryptedPassword = BCrypt.hashpw(newPw, BCrypt.gensalt());
            
            // 해싱된 비밀번호로 멤버의 로그인 비밀번호 업데이트
            foundMember.setLoginPw(encryptedPassword);
            memberMapper.updateMemberPassword(foundMember.getLoginPw(), foundMember.getMemberId());
            
            // 임시 비밀번호를 이메일로 전송
            sendEmail(foundMember.getEmail(), newPw);
            
            return ":)";
        } else {
        	// 유효하지 않는 ID or 전화번호일 경우 예외 발생
            throw new Exception("Invalid loginId or phone number.");
        }
    }    

	private void sendEmail(String email, String newPw) {
		// 이메일 전송 설정
		SimpleMailMessage message = new SimpleMailMessage();
	    message.setTo(email);
	    message.setSubject("Crafty 비밀번호 재설정입니다 :)");
	    message.setText("당신의 새로운 비밀번호는 : " + newPw + "입니다.");
	    
		System.out.println("전송 메일: " + email);
	    System.out.println("변경된 비밀번호: " + newPw);
	    
	    emailSender.send(message);
	}
	
	// newPw :  String newPw = generateTempPw();
	private String generateTempPw() {
	    String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
	    StringBuilder sb = new StringBuilder();
	    Random random = new Random();

	    int length = 8; // 임시 비밀번호의 길이
	    for (int i = 0; i < length; i++) {
	        int index = random.nextInt(characters.length());
	        sb.append(characters.charAt(index));
	    }

	    return sb.toString();
	}
	

	// public Member getMemberByMemberId(int memberId) {
	// 	return memberMapper.getMemberByMemberId(memberId);
	// }
	
		// profile Edit
		public void updateMember(String profileImg, String nickname, String profileIntroduction, String email,
	            String zoneCode, String roadAddress, String detailAddress, Date memberUpdatedAt){
				Member member = memberRepository.findByEmail(email);
				if (member != null) {
				// 프로필 정보를 업데이트합니다.
					member.setProfileImg(profileImg);
					member.setNickname(nickname);
					member.setProfileIntroduction(profileIntroduction);
					member.setEmail(email);
					member.setZoneCode(zoneCode);
					member.setRoadAddress(roadAddress);
					member.setDetailAddress(detailAddress);
				// 변경사항을 저장합니다.
					memberRepository.save(member);
				} else {
					throw new RuntimeException("해당 회원을 찾을 수 없습니다.");
				}
		}

		
		
	public ResponseProfile getProfileEditByMemberId(int sessionMemberId) {			
		ResponseProfile profile = memberMapper.getProfileEditByMemberId(sessionMemberId);					
		return profile;	
	}


	// Last login date update
	public void updateLastLoginDate(int memberId, Timestamp lastLoginDate) {
	    Member member = new Member();
	    member.setMemberId(memberId);
	    member.setLastLoginDate(lastLoginDate);
	    memberMapper.updateLastLoginDate(member);
	}
	
	// 결제 주문자 정보
	public RequestPayment getMemberByMemberId(int memberId) throws Exception {
		
		RequestPayment requestPayment = memberMapper.getMemberByMemberId(memberId);
		
		if(requestPayment == null) {
			throw new Exception("주문 정보 생성 실패");
		}
		
		return requestPayment;

	}
	
	// 굿즈 등록/삭제 신청 메일 정보
	public MemberEmailInfo getMemberEmailInfoByGoodsId(int goodsId) throws Exception {
		MemberEmailInfo member = memberMapper.getMemberEmailInfoByGoodsId(goodsId);
		
		if(member == null) {
			throw new Exception("멤버 정보를 불러오지 못했습니다.");
		}
		
		return member;
	}
	
	// profile Edit
	@Transactional
	public void updateMember(String profileImgName, String nickname, String profileIntroduction, String email,
	                         String zoneCode, String roadAddress, String detailAddress, Date memberUpdatedAt) throws Exception {
	    Member member = memberRepository.findByEmail(email);
	    if (member != null) {
	        // 프로필 이미지 업로드된 파일명을 설정합니다.
	        member.setProfileImg(profileImgName);

	        // 프로필 정보를 업데이트합니다.
	        member.setNickname(nickname);
	        member.setProfileIntroduction(profileIntroduction);
	        member.setEmail(email);
	        member.setZoneCode(zoneCode);
	        member.setRoadAddress(roadAddress);
	        member.setDetailAddress(detailAddress);
	        member.setMemberUpdatedAt(memberUpdatedAt);

	        // 변경사항을 저장합니다.
	        memberRepository.save(member);
	    } else {
	        throw new RuntimeException("해당 회원을 찾을 수 없습니다.");
	    }
    }
    
}
