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
//@RequestMapping("member")
public class MemberController {

    @Autowired
//    private MemberService memberService;
    
    @GetMapping(value ="/signUp")
    public String signUpForm() {
        return "signUp";
    }
    
    // 이 부분도 멤버 서비스, Dto 만들면 주석 삭제
    @PostMapping(value = "/signUp")
    public String signUp() {
        // 회원 가입 로직 구현
//        memberService.signUp(member);
        
        return "login";  // 회원가입 성공 시, 로그인 페이지로 이동
    }
    
    @GetMapping(value="/find")
    public String find() {
    	
    	return "find";
    }
    
//    ID,PW는 비동기로 프론트 단에서 구현
    @PostMapping(value = "/find")
    public String findMember(@RequestParam("login_id") String loginId, @RequestParam("login_pw") String loginPw) {
        // ID, PW 찾기 로직 구현
        // id, password를 이용한 검색 수행
        return "login"; // 찾기한 결과 반환 id는 alert(), pw는 이메일로 재설정이 가능한 링크 전송
    }
    
    @GetMapping(value = "/likes")
    public String likeMember() {
        // 좋아요 기능 로직 구현
        // id를 이용하여 해당 멤버에 좋아요 처리
        return "alarmedGoods";
    }

    @GetMapping(value = "/alarm")
    public String showAlarmSettings() {
        // 알림 확인 페이지 로직 구현
        // id를 이용하여 해당 멤버의 알림 확인 페이지 반환
        return "alarmedGoods";
    }
    
//    프로필, 프로필 수정
    @GetMapping(value = "/profile/{memberId}")
    public String showProfile(@PathVariable("memberId") String memberId, Model model) {
//        Member member = memberService.getMemberById(id);
//        model.addAttribute("member", member);
        return "profile";
    }

    @GetMapping(value = "/profile/edit")
    public String showProfileEditForm(Model model) {
//        // 프로필 수정 페이지
//        Member member = memberService.getMemberById(id);
//        model.addAttribute("member", member);
        return "profileEdit";
    }

    @PostMapping(value = "/profile/edit")
    public String editProfile(@ModelAttribute("member") Member memberUpdatedAt) {
        // 프로필 수정 후 다시 프로필 페이지로 이동 
//        memberService.updateMember(id, memberUpdatedAt);
        
        return "profileEdit";
//      crafty/profile/{id}
    }
}
