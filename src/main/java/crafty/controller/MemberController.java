package crafty.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import crafty.dto.Goods;
import crafty.dto.Member;
import crafty.dto.ResponseAttendedGoods;
import crafty.dto.ResponseProfile;
import crafty.pagination.dto.MainCard;
import crafty.pagination.dto.PageRequestDTO;
import crafty.pagination.dto.PageResponseDTO;
import crafty.service.GoodsService;
import crafty.service.LikesService;
import crafty.service.MemberService;
import crafty.service.OpenAlarmService;

/*
 * MemberController - signUp, find, likes, openAlarm, profile / profileEdit
 * */

@Controller
//@RequestMapping("member")
public class MemberController {

    @Autowired
    private MemberService memberService;
    
    @Autowired
    private GoodsService goodsService;
    
    @Autowired
    private LikesService likesService;
//    private MemberService memberService;
    
    @Autowired
    private OpenAlarmService openAlarmService;
    
    @RequestMapping(value = "/signUp", method = RequestMethod.GET)
    public String signUpForm() {
        return "signUp";
    }

    // 회원가입
    @PostMapping(value = "/signUp")
    public String signUp(@ModelAttribute Member member, @RequestParam("birthDate") String birthDate) throws SQLException, Exception {
        
    	// 생년월일 처리
        java.util.Date birthD = new java.text.SimpleDateFormat("yy/mm/dd").parse(birthDate);
        
        long birthL =  birthD.getTime();
        java.sql.Date birth = new java.sql.Date(birthL);
        
        
        member.setBirth(birth);
        member.setProfileImg("default");

        
        
        String encryptedPassword = BCrypt.hashpw(member.getLoginPw(), BCrypt.gensalt());
        member.setLoginPw(encryptedPassword);
        
        // 회원 가입 처리 
        memberService.signUp(member);
        
        
        return "redirect:/login";  // 회원가입 성공 시, 로그인 페이지로 redirect
    }

    
    // ID,PW는 비동기로 프론트 단에서 구현
    @GetMapping(value = "/find")
    public String findMember(Model model) {
//        model.addAttribute("member", new Member());
        return "find";
    }
    
    @PostMapping(value = "/findId")
    public ResponseEntity<String> findId(@ModelAttribute Member member) {
        try {
            String id = memberService.findId(member);
            return ResponseEntity.ok(id);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred.");
        }
    }
    
    @PostMapping(value = "/findPw")
    public ResponseEntity<String> findPw(@ModelAttribute Member member) {
        try {
            String pw = memberService.resetPw(member);
            return ResponseEntity.ok(pw);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred.");
        }
    }
    
    
    @GetMapping(value = "/likes")
    public String likeMember(HttpSession session, @ModelAttribute PageRequestDTO pageRequest, Model model) {
    	int memberId = (int) session.getAttribute("memberId");
    	
    	pageRequest.setAmount(6);
    	
    	HashMap<String, Object> hashmap = new HashMap<>();
    	hashmap.put("pageRequest", pageRequest);
    	hashmap.put("memberId", memberId);
    	
    	
    	try {   	
    		List<MainCard> goodsList = likesService.getLikedGoodsByMemberId(hashmap);
    		
    		int total = likesService.getLikedGoodsTotalCount(memberId);
    		PageResponseDTO pageResponse = new PageResponseDTO(total, 5, pageRequest);
    		
    		System.out.println(goodsList);
    		
    		model.addAttribute("goodsList", goodsList);
            model.addAttribute("pageInfo", pageResponse);
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	       
        return  "likedGoods";
    }

    @GetMapping(value = "/alarm")
    public String showAlarmSettings(HttpSession session, @ModelAttribute PageRequestDTO pageRequest, Model model) {
    	int memberId = (int) session.getAttribute("memberId");
    	
    	pageRequest.setAmount(6);
    	
    	HashMap<String, Object> hashmap = new HashMap<>();
    	hashmap.put("pageRequest", pageRequest);
    	hashmap.put("memberId", memberId);
    	
    	
    	try {
    		List<MainCard> goodsList = openAlarmService.openAlarmGoodsByMemberId(hashmap);
    		
    		int total = openAlarmService.openAlarmGoodsTotalCount(memberId);
    		PageResponseDTO pageResponse = new PageResponseDTO(total, 5, pageRequest);
    		
    		model.addAttribute("goodsList", goodsList);
            model.addAttribute("pageInfo", pageResponse);
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
      
        return "alarmedGoods";
    }
    
//    프로필, 프로필 수정
    @GetMapping(value = "/profile/{memberId}")
    public String showProfile(HttpSession session, @ModelAttribute PageRequestDTO pageRequest,
    						  @PathVariable("memberId") int memberId, Model model) throws SQLException {
    	int sessionMemberId = (int) session.getAttribute("memberId");
    	
    	// 한 페이지에 8개 카드 출력
    	pageRequest.setAmount(8);
    	
    	HashMap<String, Object> hashmap = new HashMap<>();
    	// 좋아요 누른 굿즈의 like_id를 가져오기 위해 session에 등록된 id도 parameter로 넘겨줌
    	// like_id가 있는 굿즈 -> 빨간 하트(클릭 시 좋아요 취소)
    	// like_id가 없는 굿즈 -> 하얀 하트(클릭 시 좋아요)
    	hashmap.put("sessionMemberId", sessionMemberId);
    	hashmap.put("profileMemberId", memberId);
    	hashmap.put("pageRequest", pageRequest);
    	
    	ResponseProfile profile = memberService.getProfileByMemberId(memberId);
		
		List<MainCard> goodsList = goodsService.getGoodsByMemberId(hashmap);
		
		int totalCnt = goodsService.getTotalGoodsByMemberId(memberId);
		
		PageResponseDTO pageResponse = new PageResponseDTO(totalCnt, 5, pageRequest);
    	
        model.addAttribute("profile", profile);
        model.addAttribute("goodsList", goodsList);
        model.addAttribute("pageResponse", pageResponse);
        
        return "profile";
    }

    @GetMapping(value = "/profile/edit")
    public String showProfileEditForm(Model model, HttpSession session) {
//        // 프로필 수정 페이지
    	int sessionMemberId = (int) session.getAttribute("memberId");
    	
        memberService.getMemberByMemberId(sessionMemberId);
    	model.addAttribute("memberId", sessionMemberId);
        return "profileEdit";
    }

    @PostMapping(value = "/profile/edit")
    public String editProfile(@ModelAttribute("member") Member memberUpdatedAt, HttpSession session) {
        // 프로필 수정 후 다시 프로필 페이지로 이동 
    	int sessionMemberId = (int) session.getAttribute("memberId");
    	
    	memberService.updateMember(sessionMemberId, memberUpdatedAt);
        
        return "profileEdit";
//      crafty/profile/{id}
    }
}
