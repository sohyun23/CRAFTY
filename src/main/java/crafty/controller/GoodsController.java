package crafty.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import crafty.dto.Goods;

@Controller
public class GoodsController {
	@GetMapping(value="/main")
	public String main() {
		
		return "main";
	}
	
	@GetMapping(value="/main?ongoing={ongoing}&order={order}")
	public String mainOrderBy(@RequestParam("ongoing") int ongoing, @RequestParam("order") int order) {
		
		return "main";
	}
	
	@GetMapping(value="/main/search?keyword={keyword}")
	public String search(@RequestParam("keyword") String keyword) {
		
		return "main";
	}
	
	@GetMapping(value="/main/search?keyword={keyword}&ongoing={ongoing}&order={order}")
	public String searchOrderBy(@RequestParam("keyword") String keyword,
								@RequestParam("ongoing") int ongoing,
								@RequestParam("order") int order) {
		
		return "main";
	}
	
	@GetMapping(value="/goods/{goodsNum}")
	public String goodsDetail(@PathVariable("goodsNum") int goodsNum) {
		
		return "goodsDetail";
	}
	
	// 굿즈 등록 페이지 전환 메서드
	@GetMapping(value="/register")
	public String registerGoodsForm() {
		
		return "registerGoods";
	}
	
	// 굿즈 등록 페이지 전환 메서드
	@PostMapping(value="/register/goods")
	public String registerGoods(@ModelAttribute Goods newGoods) {
		// 등록한 굿즈 정보 db에 저장
	
		return "registerGoods";
	}
	
	@GetMapping(value="/goods/attended")
	public String attendedGoods() {
		
		return "attendedGoods";
	}
	
	@GetMapping(value="/goods/attended/{orderId}")
	public String attendedGoodDetail(@PathVariable("orderId") int orderId) {
		
		return "attendedGoodsDetail";
	}
	
	@PostMapping(value="/goods/registered/{goodsId}")
	public String registerGoodsDetail(@PathVariable("goodsId") int goodsId) {
		
		return "registeredGoodsDetail";
	}
	
	@PostMapping(value="/goods/registered/sales/{goodsId}")
	public String registerGoodsSalesByItem(@PathVariable("goodsId") int goodsId) {
		
		return "registeredGoodsSalesByItem";
	}
	
	
}
