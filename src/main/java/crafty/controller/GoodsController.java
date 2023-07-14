package crafty.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import crafty.dto.Goods;
import crafty.dto.GoodsResponse;
import crafty.dto.Item;
import crafty.dto.ItemResponse;
import crafty.dto.Orders;
import crafty.dto.ResponseGoodsDetail;
import crafty.dto.ResponseGoodsManagement;
import crafty.dto.ResponseNondisclosureRequest;
import crafty.dto.ResponseRegisterRequest;
import crafty.pagination.dto.MainCard;
import crafty.pagination.dto.PageRequestDTO;
import crafty.pagination.dto.PageResponseDTO;
import crafty.pagination.dto.SearchKeyword;
import crafty.service.GoodsDescriptionImgService;
import crafty.service.GoodsService;
import crafty.service.ItemService;
import crafty.service.OrdersService;

@Controller
public class GoodsController {
	
	@Autowired
	GoodsService goodsService;
	
	@Autowired
	GoodsDescriptionImgService goodsImgService;
	
	@Autowired
	OrdersService ordersService;
	
	@Autowired
	ItemService itemService;
	
	@GetMapping(value="/main")
	public String main(@ModelAttribute PageRequestDTO pageRequest, Model model) {		
		pageRequest.setAmount(1);		
		List<MainCard> goodsList = goodsService.getMainGoods(pageRequest);		
		int total = goodsService.getMainGoodsTotalCount(pageRequest);		
		PageResponseDTO pageResponse = new PageResponseDTO(total, 5, pageRequest);
		model.addAttribute("goodsList", goodsList);
		model.addAttribute("pageInfo", pageResponse);
		
		return "main";
	}

	@GetMapping(value="/main/search?keyword={keyword}&ongoing={ongoing}&order={order}&pageNum={pageNum}&amount={amount}")
	public String searchOrderBy(@RequestParam("keyword") SearchKeyword keyword,
								@RequestParam("ongoing") int ongoing,
								@RequestParam("order") int order,
								@RequestParam("pageNum") int pageNum,
								@RequestParam("amount") int amount) {
		

		return "main";
	}
	
	@GetMapping(value="/goods/{goodsId}")
	public String goodsDetail(@PathVariable("goodsId") int goodsId, Model model) {
		ResponseGoodsDetail goods = goodsService.getGoodsByGoodsId(goodsId);
		String thumbnailImgName = goodsService.getGoodsThumbnailImgNameByGoodsId(goodsId);
		String contentImgName = goodsService.getGoodsContentImgNameByGoodsId(goodsId);
		List<Item> itemList = itemService.getItemsByGoodsId(goodsId);
		
		model.addAttribute("goods", goods);
		model.addAttribute("thumbnailImgName", thumbnailImgName);
		model.addAttribute("contentImgName", contentImgName);
		model.addAttribute("itemList", itemList);
		
		return "goodsDetail";
	}
	
	// 굿즈 등록 페이지 전환 메서드
	@GetMapping(value="/register")
	public String registerGoodsForm() {
		
		return "registerGoods";
	}
	
	// 굿즈 등록 페이지 전환 메서드
		//[{"itemName":"1","itemPrice":"1","itemComposition":"1","itemQuantity":"1"},{"itemName":"2","itemPrice":"2","itemComposition":"2","itemQuantity":"2"}]
		@PostMapping(value="/register/goods")
		public String registerGoods(@RequestParam("thumbnailFile") MultipartFile thumbnailFile,
									@RequestParam("descriptionFile") MultipartFile descriptionFile,
									@ModelAttribute GoodsResponse goodsResponse){
			// 등록한 굿즈 정보 db에 저장
//			System.out.println(thumbnailFile);
//			System.out.println(goodsResponse.getGoodsName());
//			System.out.println(goodsResponse.getGoodsIntro());
//			System.out.println(goodsResponse.getGoodsCategory());
//			System.out.println(goodsResponse.getStartDate());
//			System.out.println(goodsResponse.getEndDate());
//			System.out.println(descriptionFile);
//			System.out.println(goodsResponse.getItemList());
//			System.out.println(goodsResponse.getTargetAmount());
//			System.out.println(goodsResponse.getPostDate());
//			System.out.println(goodsResponse.getBankCategory());
//			System.out.println(goodsResponse.getBankAccountNumber());

			try {
				
				// itemList : json to Object
				String jsonItemListStr = goodsResponse.getItemList();
				ObjectMapper objectMapper = new ObjectMapper();
				List<ItemResponse> itemList;
				itemList = objectMapper.readValue(jsonItemListStr, new TypeReference<List<ItemResponse>>() {});
				System.out.println(itemList);
				
				goodsImgService.registGoodsImg(thumbnailFile, descriptionFile);
				
				goodsService.registGoods(goodsResponse, itemList, thumbnailFile, descriptionFile );
				
				
			} catch (JsonMappingException e) {
				e.printStackTrace();
			} catch (JsonProcessingException e) {
				e.printStackTrace();
			}

			

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
	
	@GetMapping(value="/goods/registered")
	public String registeredGoods() {
		
		return "registeredGoods";
	}
	
	@GetMapping(value="/goods/registered/{goodsId}")
	public String registerGoodsDetail(@PathVariable("goodsId") int goodsId) {
		
		return "registeredGoodsDetail";
	}
	
	@GetMapping(value="/goods/registered/sales/{goodsId}")
	public String registerGoodsSalesByItem(@PathVariable("goodsId") int goodsId) {
		
		return "registeredGoodsSalesByItem";
	}
	
	// 관리자 - 등록된 모든 굿즈를 볼 수 있는 페이지
	@GetMapping("/admin/goods")
	public String goodsManagement(@ModelAttribute PageRequestDTO pageRequest, Model model) {
		
		List<ResponseGoodsManagement> goodsList = goodsService.getManagementGoods(pageRequest);
		
		int totalCnt = goodsService.getTotalManagementGoodsCount();
		
		PageResponseDTO pageResponse = new PageResponseDTO(totalCnt, 5, pageRequest);
		
		model.addAttribute("goodsList", goodsList);
		model.addAttribute("pageInfo", pageResponse);
		
		return "goodsManagement";
	}
	
	// 관리자 - 특정 굿즈의 판매 내역을 볼 수 있는 페이지, goodsId로 검색,
	@GetMapping("admin/goods/{goodsId}")
	public String goodsPurchaserList(@PathVariable("goodsId") int goodsId,
									 @ModelAttribute PageRequestDTO pageRequest, Model model) {
		HashMap<String, Object> hashMap = new HashMap<>();
		hashMap.put("goodsId", goodsId);
		hashMap.put("pageRequest", pageRequest);
		
		List<Orders> orderList = ordersService.getOrdersByGoodsId(hashMap);
		
		int totalCnt = ordersService.getPurchaserListCount(goodsId);
		
		PageResponseDTO pageResponse = new PageResponseDTO(totalCnt, 5, pageRequest);
		
		model.addAttribute("goodsId", goodsId);
		model.addAttribute("orderList", orderList);
		model.addAttribute("pageInfo", pageResponse);
		
		return "purchaserList";
	}
	
	// 관리자 - 등록 요청이 들어온 굿즈를 볼 수 있는 페이지
	@GetMapping("admin/request/register")
	public String registerRequest(@ModelAttribute PageRequestDTO pageRequest, Model model) {
		List<ResponseRegisterRequest> goodsList = goodsService.getRegisterRequestGoods(pageRequest);
		
		int totalCnt = goodsService.getRegisterRequestGoodsCount();
		
		PageResponseDTO pageResponse = new PageResponseDTO(totalCnt, 5, pageRequest);
		
		model.addAttribute("goodsList", goodsList);
		model.addAttribute("pageInfo", pageResponse);
		
		return "registerRequest";
	}
	
	// 관리자 - 비공개 요청이 들어온 굿즈를 볼 수 있는 페이지
	@GetMapping("admin/request/nondisclosure")
	public String deleteRequest(@ModelAttribute PageRequestDTO pageRequest, Model model) {
		List<ResponseNondisclosureRequest> goodsList = goodsService.getNondisclosureRequestGoods(pageRequest);
		
		int totalCnt = goodsService.getNondisclosureRequestGoodsCount();
		
		PageResponseDTO pageResponse = new PageResponseDTO(totalCnt, 5, pageRequest);
		
		model.addAttribute("goodsList", goodsList);
		model.addAttribute("pageInfo", pageResponse);
		
		return "deleteRequest";
	}
	
}
