package crafty.controller;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
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
public class MemberController {

    @Autowired
    private MemberService memberService;
    
    @Autowired
    private GoodsService goodsService;
    
    @Autowired
    private LikesService likesService;
    
    @Autowired
    private OpenAlarmService openAlarmService;

    @GetMapping("/signUp")
    public String signUpForm(Model model) {
        model.addAttribute("member", new Member());
        return "signUp";
    }

    // 회원가입
    @PostMapping(value = "/signUp")
    public String signUp(@ModelAttribute Member member, @RequestParam("birthDate") String birthDate, Model model) throws SQLException, Exception {
        // 아이디 중복 확인
    	if (memberService.isIdExists(member.getLoginId())) {
            model.addAttribute("error", "이미 사용 중인 아이디입니다.");
            return "signUp";
        }
    	// 닉네임 중복 확인
        if (memberService.isNicknameExists(member.getNickname())) {
            model.addAttribute("error", "이미 사용 중인 닉네임입니다.");
            return "signUp";
        }
        
        // 휴대폰 번호 중복 확인
        if (memberService.isPhoneNumExists(member.getPhoneNum())) {
            model.addAttribute("error", "이미 사용 중인 휴대폰 번호입니다.");
            return "signUp";
        }
        
        // 이메일 중복 확인
        if (memberService.isEmailExists(member.getEmail())) {
            model.addAttribute("error", "이미 사용 중인 이메일입니다.");
            return "signUp";
        }
    	
    	
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
    public String findForm() {
        return "find";
    }
    
    @PostMapping(value = "/find")
    public ResponseEntity<String> find(@RequestParam(value = "name", required = false) String name, 
    								   @RequestParam(value ="phoneNum", required = false) String phoneNum, 
    								   @RequestParam(value = "loginId", required = false) String loginId,
    								   @RequestParam("action") String action) throws Exception {
    	// find id
    	if (action.equals("findId")) {
    	    Member member = new Member();
    	    member.setName(name);
    	    member.setPhoneNum(phoneNum);
    	    String id = memberService.findId(member);
    	    return ResponseEntity.ok(id);
    	} 
    	// reset pw
    	else if (action.equals("resetPw")) {
    	    Member member = new Member();
    	    member.setLoginId(loginId);
    	    member.setPhoneNum(phoneNum);
    	    String pw = memberService.resetPw(member);
    	    System.out.println(pw);
    	    return ResponseEntity.ok(pw);
    	}
    	return ResponseEntity.badRequest().body("Invalid action.");
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
    
//  프로필
    @GetMapping(value = "/profile/{memberId}")
    public String profile(@PathVariable("memberId") int memberId,
					            @ModelAttribute PageRequestDTO pageRequest,
					            HttpSession session, Model model) throws SQLException {
    	
    	int sessionMemberId = 0;
        if (session.getAttribute("memberId") != null) {
        	sessionMemberId = (int)session.getAttribute("memberId");
        }
        
        // 한 페이지에 8개 카드
        pageRequest.setAmount(8);
        int ongoing = 1; // 진행중인 굿즈 목록
        
    	HashMap<String, Object> hashmap = new HashMap<>();
    	// 좋아요 누른 굿즈의 like_id를 가져오기 위해 session에 등록된 id도 parameter로 넘겨줌
    	// like_id가 있는 굿즈 -> 빨간 하트(클릭 시 좋아요 취소)
    	// like_id가 없는 굿즈 -> 하얀 하트(클릭 시 좋아요)
    	hashmap.put("sessionMemberId", sessionMemberId);
    	hashmap.put("profileMemberId", memberId);
    	hashmap.put("ongoing", ongoing);
    	hashmap.put("pageRequest", pageRequest);
    	
    	ResponseProfile profile = memberService.getProfileByMemberId(memberId);
		List<MainCard> goodsList = goodsService.getGoodsByMemberId(hashmap);
		int totalCnt = goodsService.getTotalGoodsByMemberId(memberId, ongoing);
		PageResponseDTO pageResponse = new PageResponseDTO(totalCnt, 5, pageRequest);
    	
		model.addAttribute("ongoing", 1);
        model.addAttribute("profile", profile);
        model.addAttribute("goodsList", goodsList);
        model.addAttribute("pageInfo", pageResponse);
        
        return "profile";
    }
    
    // 진행 예정 굿즈
    @GetMapping(value = "/profile/{memberId}", params = "ongoing=0")
    public String profileOrderByScheduled(@PathVariable("memberId") int memberId,
					            @ModelAttribute PageRequestDTO pageRequest,
					            HttpSession session, Model model) throws SQLException {
    	System.out.println("ongoing:0");
    	int sessionMemberId = 0;
        if (session.getAttribute("memberId") != null) {
        	sessionMemberId = (int)session.getAttribute("memberId");
        }
        
        // 한 페이지에 8개 카드
        pageRequest.setAmount(8);
        int ongoing = 0; // 진행 예정 굿즈 목록
        
    	HashMap<String, Object> hashmap = new HashMap<>();
    	hashmap.put("sessionMemberId", sessionMemberId);
    	hashmap.put("profileMemberId", memberId);
    	hashmap.put("ongoing", ongoing);
    	hashmap.put("pageRequest", pageRequest);
    	
    	ResponseProfile profile = memberService.getProfileByMemberId(memberId);
		List<MainCard> goodsList = goodsService.getGoodsByMemberId(hashmap);
		int totalCnt = goodsService.getTotalGoodsByMemberId(memberId, ongoing);
		PageResponseDTO pageResponse = new PageResponseDTO(totalCnt, 5, pageRequest);
    	
		model.addAttribute("ongoing", 0);
        model.addAttribute("profile", profile);
        model.addAttribute("goodsList", goodsList);
        model.addAttribute("pageInfo", pageResponse);
        
        return "profile";
    }
    
    // 진행중인 굿즈
    @GetMapping(value = "/profile/{memberId}", params = "ongoing=1")
    public String profileOrderByIng(@PathVariable("memberId") int memberId,
					            @ModelAttribute PageRequestDTO pageRequest,
					            HttpSession session, Model model) throws SQLException {
    	
    	int sessionMemberId = 0;
        if (session.getAttribute("memberId") != null) {
        	sessionMemberId = (int)session.getAttribute("memberId");
        }
        
        // 한 페이지에 8개 카드
        pageRequest.setAmount(8);
        int ongoing = 1; // 진행 예정 굿즈 목록
        
    	HashMap<String, Object> hashmap = new HashMap<>();
    	hashmap.put("sessionMemberId", sessionMemberId);
    	hashmap.put("profileMemberId", memberId);
    	hashmap.put("ongoing", ongoing);
    	hashmap.put("pageRequest", pageRequest);
    	
    	ResponseProfile profile = memberService.getProfileByMemberId(memberId);
		List<MainCard> goodsList = goodsService.getGoodsByMemberId(hashmap);
		int totalCnt = goodsService.getTotalGoodsByMemberId(memberId, ongoing);
		PageResponseDTO pageResponse = new PageResponseDTO(totalCnt, 5, pageRequest);
    	
		model.addAttribute("ongoing", 1);
        model.addAttribute("profile", profile);
        model.addAttribute("goodsList", goodsList);
        model.addAttribute("pageInfo", pageResponse);
        
        return "profile";
    }
    
    // 종료된 굿즈
    @GetMapping(value = "/profile/{memberId}", params = "ongoing=2")
    public String profileOrderByCompleted(@PathVariable("memberId") int memberId,
					            @ModelAttribute PageRequestDTO pageRequest,
					            HttpSession session, Model model) throws SQLException {
    	
    	int sessionMemberId = 0;
        if (session.getAttribute("memberId") != null) {
        	sessionMemberId = (int)session.getAttribute("memberId");
        }
        
        // 한 페이지에 8개 카드
        pageRequest.setAmount(8);
        int ongoing = 2; // 진행 예정 굿즈 목록
        
    	HashMap<String, Object> hashmap = new HashMap<>();
    	hashmap.put("sessionMemberId", sessionMemberId);
    	hashmap.put("profileMemberId", memberId);
    	hashmap.put("ongoing", ongoing);
    	hashmap.put("pageRequest", pageRequest);
    	
    	ResponseProfile profile = memberService.getProfileByMemberId(memberId);
		List<MainCard> goodsList = goodsService.getGoodsByMemberId(hashmap);
		int totalCnt = goodsService.getTotalGoodsByMemberId(memberId, ongoing);
		PageResponseDTO pageResponse = new PageResponseDTO(totalCnt, 5, pageRequest);
    	
		model.addAttribute("ongoing", 2);
        model.addAttribute("profile", profile);
        model.addAttribute("goodsList", goodsList);
        model.addAttribute("pageInfo", pageResponse);
        
        return "profile";
    }
    
 // //    수정 중입니다 ~ 접속 안됩니다~ 일요일까지 작성해서 PR하겠습니다.
//  // profile Edit(get)
//  @GetMapping(value = "/profile/edit")
//  public String showProfileEditForm(Model model, HttpSession session) {
//      int sessionMemberId = (int) session.getAttribute("memberId");
//      // getMemberByMemberId 메소드 이름 바꿔서 사용 
//      Member member = memberService.getMemberByMemberId(sessionMemberId);
//      model.addAttribute("member", member);
//      return "profile/Edit";
//  }
 
//  // profile Edit(post)
//  @PostMapping(value = "/profile/edit")
//  public String editProfile(@ModelAttribute Member member, HttpSession session) {
//      int sessionMemberId = (int) session.getAttribute("memberId");
//      Timestamp currentTime = new Timestamp(System.currentTimeMillis());
//      member.setMemberUpdatedAt(currentTime);

//      // DB에 수정된 프로필 정보 저장
//      memberService.updateMember(member.getMemberId(), member.getProfileImg(), member.getProfileIntroduction(), member.getNickname(), member.getRoadAddress(), member.getDetailAddress(), member.getMemberUpdatedAt());

//      return "redirect:/profile/" + sessionMemberId;
//  }
}
