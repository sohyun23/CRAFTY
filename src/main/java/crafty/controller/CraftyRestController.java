package crafty.controller;

import java.sql.SQLException;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import crafty.service.GoodsService;
import crafty.service.LikesService;
import crafty.service.NondisclosureRequestService;
import crafty.service.OpenAlarmService;

@RestController
public class CraftyRestController {
	
	@Autowired
	GoodsService goodsService;
	
	@Autowired
	LikesService likesService;
	
	@Autowired
	NondisclosureRequestService nondisclosureRequestService;
	
	@Autowired
	OpenAlarmService openAlarmService;
	
	// 굿즈 등록 허가
	@GetMapping("/request/register/allow/{goodsId}")
	public String registerRequestAllow(@PathVariable("goodsId") int goodsId) throws Exception{
		int result = goodsService.updateGoodsRegistrationStatusAllowByGoodsId(goodsId);

		if(result == 0) {
			throw new Exception("다시 시도해주세요.");
		}
		
		return "등록 허가했습니다.";
	}
	
	// 굿즈 등록 불허
	@GetMapping("/request/register/disallow/{goodsId}")
	public String registerRequestDisallow(@PathVariable("goodsId") int goodsId) throws Exception{
		int result = goodsService.updateGoodsRegistrationStatusDisallowByGoodsId(goodsId);
		
		if(result == 0) {
			throw new Exception("다시 시도해주세요.");
		}
		
		return "등록 불허가했습니다.";
	}
	
	// 굿즈 비공개 허가
	@GetMapping("request/nondisclosure/allow/{goodsId}")
	public String nondisclosureRequestAllow(@PathVariable("goodsId") int goodsId) throws Exception, SQLException{
		int result = goodsService.updateGoodsNondisclosureStatusByGoodsId(goodsId);

		if(result == 0) {
			throw new Exception("다시 시도해주세요.");
		}
		
		return "비공개 허가했습니다.";
	}
	
	// 굿즈 비공개 불허
	@GetMapping("request/nondisclosure/disallow/{goodsId}")
	public String nondisclosureRequestDisallow(@PathVariable("goodsId") int goodsId) throws Exception, SQLException{
		int result = nondisclosureRequestService.updateNondisclosureRequestNondisclosureStatusByGoodsId(goodsId);
		
		if(result == 0) {
			throw new Exception("다시 시도해주세요.");
		}
		
		return "비공개 불허가했습니다.";
	}
	
	// 좋아요   메서드
	@GetMapping("goods/like/{goodsId}")
	public String like(HttpSession session, @PathVariable("goodsId") int goodsId) throws Exception {
		int memberId = (int) session.getAttribute("memberId");
		
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("goodsId", goodsId);
		hashmap.put("memberId", memberId);
		
		int result = likesService.insertLikeByGoodsIdAndMemberId(hashmap);
		
		if(result == 0) {
			throw new Exception("다시 시도해주세요.");
		}
		
		return "좋아요 성공";
	}
	
	// 좋아요 취소 메서드
	@GetMapping("goods/unlike/{likeId}")
	public String unlike(@PathVariable("likeId") int likeId) throws Exception {
		int result = likesService.deleteLikeByLikeId(likeId);
		
		if(result == 0) {
			throw new Exception("다시 시도해주세요.");
		}
		
		return "좋아요 취소 성공";
	}
	
	@ExceptionHandler(value = {Exception.class})
	public ResponseEntity<String> handleException(Exception e){
		return new ResponseEntity<String>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
