package crafty.controller;

import java.sql.SQLException;
import java.util.Map;

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
	
	@Autowired
//	private BCryptPasswordEncoder passwordEncoder;
	
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
		System.out.println(id);
		System.out.println(pw);

	    // id, pw로 db정보를 가져옴
	    Member member = memberService.getMemberById(id);

		System.out.println(member);
		 
		boolean result = BCrypt.checkpw(pw, member.getLoginPw());
		
		System.out.println(result);
		 if (member != null && result) {
			 	// DB에 저장된 암호화된 비밀번호를 가져옴
			 
		        // 로그인 성공
		        session.setAttribute("id", id);
		        session.setAttribute("memberId", member.getMemberId());
		        session.setAttribute("position", member.getPosition()); 
		        
		        String profileImg = member.getProfileImg();
		        if (profileImg != null) {
		            session.setAttribute("profileImg", profileImg);
		        } else {
		            session.setAttribute("profileImg", "default-profile-img.jpg"); // 기본값 설정
		        }        
		        
		        model.addAttribute("nickname", member.getNickname());
		        		               
//		        System.out.println(member);
		        
		        String returnData = "{\"nickname\": \"" + member.getNickname() + "\"}";

//		        System.out.println(returnData);
		        
		        return returnData;
//		        return "{\"success\": true}";
		        
		    } else {
		        // 로그인 실패
		        return "{\"success\": false}";
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
