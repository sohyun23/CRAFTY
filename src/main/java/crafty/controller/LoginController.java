package crafty.controller;

import java.sql.SQLException;
import java.util.Map;
import java.sql.Timestamp;

import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import crafty.dto.Member;
import crafty.service.MemberService;

@Controller
public class LoginController {
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginForm() {
		return "login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	@ResponseBody // 필요한 경우, 응답을 JSON으로 반환하기 위해 추가
	public String login(@RequestBody Map<String, String> data, HttpSession session,
						Model model) throws Exception {
	    String id = data.get("id");
	    String pw = data.get("pw");

	    // id로  멤버 db정보를 가져옴
	    Member member = memberService.getMemberById(id);
	    System.out.println(id);
		
		// DB에 저장된 암호화된 비밀번호를 가져옴
		boolean result = BCrypt.checkpw(pw, member.getLoginPw());
		
		System.out.println(result);
		
		
		
		 if (member != null && result) { // id, pw와 같다면
			 
		        // 로그인 성공
		        session.setAttribute("id", id);
		        session.setAttribute("memberId", member.getMemberId());
		        session.setAttribute("position", member.getPosition()); 
		        session.setAttribute("profileImg", member.getProfileImg());
		                
		        
		        model.addAttribute("nickname", member.getNickname());
		        
		        // 로그인 성공 시 last_login_date 업데이트
		        Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
		        memberService.updateLastLoginDate(member.getMemberId(), currentTimestamp);
		        
		        String returnData = "{\"nickname\": \"" + member.getNickname() + "\"}";

		        System.out.println(returnData);
		        
		        return returnData;
//		        return "{\"success\": true}";
		        
		        
//		        throws Ex 으로 예외 처리 
		    } else {
		        // 로그인 실패
//		        return "{\"success\": false}";
		    	// 입력 정보가 다를 때 처리하는 로직 작성
		    	throw new Exception("로그인 실패");
		    }
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		
		if(session != null) {
			session.invalidate();
		}
		
		return "redirect:/login";
	}
	
	
	
}
