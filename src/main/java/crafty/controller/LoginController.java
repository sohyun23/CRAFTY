package crafty.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {
	
	@Autowired
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		return "login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginForm(@RequestParam("id") String id, 
							@RequestParam("pw") String pw,
							HttpSession session,
							Model model) throws SQLException, Exception{
		String view = "error";
		
//		Member member = memberService.getMemberByIdAndPw(id, pw);
		 
//		session.setAttribute("id", member.login_id());
			 
		// success login -> main
		// fail login	  -> error or alert("다시 로그인 해주십시오")
		view = "redirect:/main";
		
		return view;
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		
		if(session != null) {
			session.invalidate();
		}
		
		return "redirect:/main";
	}
	
}