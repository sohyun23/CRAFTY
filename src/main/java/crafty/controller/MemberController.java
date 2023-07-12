package crafty.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import crafty.dto.Member;

/*
 * MemberController - signUp, find, likes, openAlarm, profile / profileEdit
 * */

@Controller
@RequestMapping("/member")
public class MemberController {

	// 멤버 서비스 만들면 주석 제거
	@Autowired
//	private MemberService memberService;
	
	@GetMapping("/signUp")
	public String signUpFornm() {
		return "signUp";
	}
	
	// 이 부분도 멤버 서비스, Dto 만들면 주석 삭제
	@PostMapping("/signUp")
	public String signUp(@ModelAttribute("member") Member member) {
		// 회원 가입 로직 구현
//		memberService.signUp(member);
		
		return "login";  // 회원가입 성공 시, 로그인 페이지로 이동
	}
	
	@PostMapping("/find")
	public String findMember(@RequestParam("id") String id, @RequestParam("password") String password) {
		// ID, PW 찾기 로직 구현
		// id, password를 이용한 검색 수행
		return "searchResult"; // 찾기한 결과 반환 id는 alert("id"), pw는 이메일로 재설정이 가능한 링크 전송
	}
	
	@PostMapping("/{id}/likes")
    public String likeMember(@PathVariable("id") Long id) {
        // 좋아요 기능 로직 구현
        // id를 이용하여 해당 멤버에 좋아요 처리
        return "redirect:/member/profile/" + id;
    }

    @GetMapping("/{id}/alarms")
    public String showAlarmSettings(@PathVariable("id") Long id) {
        // 알림 설정 페이지 로직 구현
        // id를 이용하여 해당 멤버의 알림 설정 페이지 반환
        return "alarmSettings";
    }
	
//    프로필, 프로필 수정
    @GetMapping("/profile/{id}")
    public String showProfile(@PathVariable("id") Long id, Model model) {
//        Member member = memberService.getMemberById(id);
//        model.addAttribute("member", member);
        return "profile";
    }

    @GetMapping("/profile/{id}/edit")
    public String showProfileEditForm(@PathVariable("id") Long id, Model model) {
//        Member member = memberService.getMemberById(id);
//        model.addAttribute("member", member);
        return "profileEdit";
    }

    @PostMapping("/profile/{id}/edit")
    public String editProfile(@PathVariable("id") Long id, @ModelAttribute("member") Member editedMember) {
//        memberService.updateMember(id, editedMember);
    	
        return "redirect:/member/profile/" + id;
    }
}
