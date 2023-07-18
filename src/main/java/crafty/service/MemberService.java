package crafty.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import crafty.dto.Member;
import crafty.dto.ResponseProfile;
import crafty.mapper.MemberMapper;
import crafty.repository.MemberRepository;

@Service
public class MemberService {

	@Autowired
	MemberMapper memberMapper;
	private MemberRepository memberRepository;
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
        
        System.out.println(1);
        Member member = memberMapper.getMemberById(params);
        System.out.println(member);
        
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
    public String resetPw(Member member) throws Exception {
        Member foundMember = memberMapper.getMemberByIdAndPhone(member);
        if (foundMember != null) {
            String newPw = generateTempPw();
            String encryptedPassword = BCrypt.hashpw(newPw, BCrypt.gensalt());
            foundMember.setLoginPw(encryptedPassword);
            memberMapper.updateMemberPassword(foundMember);
            sendEmail(foundMember.getEmail(), newPw);
            return newPw;
        } else {
            throw new Exception("Member not found");
        }
    }

	private void sendEmail(String email, String newPw) {
		// 이메일 전송 설정
		
	}

	private String generateTempPw() {
		// 비밀번로 재설정해서 전송
		return null;
	}
    
}
