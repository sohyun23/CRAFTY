package crafty.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import crafty.dto.Goods;
import crafty.dto.GoodsResponse;
import crafty.dto.Item;
import crafty.dto.ItemResponse;
import crafty.dto.Orders;
import crafty.dto.ResponseAttendedGoods;
import crafty.dto.ResponseAttendedGoodsDetail;
import crafty.dto.ResponseGoodsDetail;
import crafty.dto.ResponseGoodsManagement;
import crafty.dto.ResponseNondisclosureRequest;
import crafty.dto.ResponseRegisterRequest;
import crafty.dto.ResponseRegisteredGoods;
import crafty.dto.ResponseRegisteredGoodsDetail;
import crafty.dto.ResponseRegisteredGoodsDetailOrders;
import crafty.dto.ResponseRegisteredGoodsSalesByItem;
import crafty.pagination.dto.MainCard;
import crafty.pagination.dto.PageRequestDTO;
import crafty.pagination.dto.PageResponseDTO;
import crafty.pagination.dto.SearchKeyword;
import crafty.service.GoodsDescriptionImgService;
import crafty.service.GoodsService;
import crafty.service.ItemService;
import crafty.service.NondisclosureRequestService;
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
	
	@Autowired
	NondisclosureRequestService nondisclosureRequestService;
	
	@Value("${delivery.trackker.key}")
	private String deliveryKey;
	
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
	public String goodsDetail(@PathVariable("goodsId") int goodsId, Model model) throws SQLException{
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
	
	// 참여 굿즈 내역 페이지
	@GetMapping(value="/goods/attended")
	public String attendedGoods(@ModelAttribute PageRequestDTO pageRequest, Model model) throws SQLException{
		// 로그인 완성되면 세션에 등록된 memberId로 교체
		int memberId = 6;
		
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("memberId", memberId);
		hashmap.put("pageRequest", pageRequest);
		
		List<ResponseAttendedGoods> orderList = ordersService.getOrdersByMemberId(hashmap);
		
		int totalCnt = ordersService.getTotalAttendedGoodsByMemberId(memberId);
		
		PageResponseDTO pageResponse = new PageResponseDTO(totalCnt, 5, pageRequest);
		
		model.addAttribute("orderList", orderList);
		model.addAttribute("pageInfo", pageResponse);
		
		return "attendedGoods";
	}
	
	@GetMapping(value="/goods/attended/{orderId}")
	public String attendedGoodDetail(@PathVariable("orderId") int orderId, Model model) throws SQLException{
		
		ResponseAttendedGoodsDetail order = ordersService.getOrderByOrderId(orderId);
		List<Item> itemList = itemService.getItemsByOrderId(orderId);
		
		model.addAttribute("order", order);
		model.addAttribute("itemList", itemList);
		model.addAttribute("deliveryKey", deliveryKey);
		
		return "attendedGoodsDetail";
	}
	
	// 등록 굿즈 리스트 페이지
	@GetMapping(value="/goods/registered")
	public String registeredGoods(@ModelAttribute PageRequestDTO pageRequest, Model model) throws SQLException{
		// 로그인 완성되면 세션에 등록된 memberId로 교체
		int memberId = 1;
		
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("memberId", memberId);
		hashmap.put("pageRequest", pageRequest);
		
		List<ResponseRegisteredGoods> goodsList = goodsService.getRegisteredGoodsByMemberId(hashmap);
		
		int totalCnt = goodsService.getTotalRegisteredGoodsByMemberId(memberId);
		
		PageResponseDTO pageResponse = new PageResponseDTO(totalCnt, 5, pageRequest);
		
		model.addAttribute("goodsList", goodsList);
		model.addAttribute("pageInfo", pageResponse);
		
		return "registeredGoods";
	}
	
	// 등록 굿즈 상세 페이지 - 참여 내역
	@GetMapping(value="/goods/registered/{goodsId}")
	public String registerGoodsDetail(@PathVariable("goodsId") int goodsId,
									  @ModelAttribute PageRequestDTO pageRequest, Model model) throws SQLException{
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("goodsId", goodsId);
		hashmap.put("pageRequest", pageRequest);
		
		// 굿즈 정보
		ResponseRegisteredGoodsDetail goods = goodsService.getRegisteredGoodsDetailByGoodsId(goodsId);
		
		// 해당 굿즈 주문 건 당 필요 데이터
		List<ResponseRegisteredGoodsDetailOrders> orderList = ordersService.getRegisteredGoodsDetailOrdersByGoodsId(hashmap);
		
		// 해당 굿즈 전체 주문 건 수
		int totalCnt = ordersService.getPurchaserListCount(goodsId);
		
		PageResponseDTO pageResponse = new PageResponseDTO(totalCnt, 5, pageRequest);
		
		model.addAttribute("goods", goods);
		model.addAttribute("orderList", orderList);
		model.addAttribute("pageInfo", pageResponse);
		
		return "registeredGoodsDetail";
	}
	
	// 참여 내역에서 삭제 신청 폼 제출 시 실행되는 메서드
	@PostMapping("/request/delete/submit")
	public String deleteRequestSubmit(@RequestParam("deleteReason") String reason, @RequestParam("goodsId") int goodsId) throws Exception, SQLException  {
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("reason", reason);
		hashmap.put("goodsId", goodsId);
		
		int result = nondisclosureRequestService.insertNondisclosureRequest(hashmap);

		if(result != 1) {
			throw new Exception("다시 시도해주세요.");
		}
		
		return "redirect:/goods/registered/" + Integer.toString(goodsId);
	}
	
	// 운송장 정보 등록 폼 제출 시 실행되는 메서드
	@PostMapping("/delivery/info/submit")
	public String deliveryInfoSubmit(@RequestParam("company") String company, @RequestParam("deliveryNum") String deliveryNum,
			  @RequestParam("orderId") int orderId, @RequestParam("goodsId") int goodsId) throws Exception, SQLException {
		
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("company", company);
		hashmap.put("deliveryNum", deliveryNum);
		hashmap.put("orderId", orderId);
		
		int result = ordersService.updateDeliveryInfoByOrderId(hashmap);
		
		if(result != 1) {
			throw new Exception("다시 시도해주세요.");
		}
		
		return "redirect:/goods/registered/" + Integer.toString(goodsId);
	}
	
	// 등록 굿즈 상세 페이지 - 품목 별 판매량
	@GetMapping(value="/goods/registered/sales/{goodsId}")
	public String registerGoodsSalesByItem(@ModelAttribute PageRequestDTO pageRequest,
											@PathVariable("goodsId") int goodsId, Model model) throws SQLException{
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("goodsId", goodsId);
		hashmap.put("pageRequest", pageRequest);
		
		ResponseRegisteredGoodsDetail goods = goodsService.getRegisteredGoodsDetailByGoodsId(goodsId);
		
		List<ResponseRegisteredGoodsSalesByItem> itemList = itemService.getRegisteredGoodsSalesByItemByGoodsId(hashmap);
		
		int totalCnt = itemService.getTotalRegisteredGoodsSalesByItemByGoodsId(goodsId);
		
		PageResponseDTO pageResponse = new PageResponseDTO(totalCnt, 5, pageRequest);
		
		model.addAttribute("goods", goods);
		model.addAttribute("itemList", itemList);
		model.addAttribute("pageInfo", pageResponse);
		
		return "registeredGoodsSalesByItem";
	}
	
	
	// 품목 별 판매량에서 삭제 신청 폼 제출 시 실행되는 메서드
	@PostMapping("/sales/request/delete/submit")
	public String salesDeleteRequestSubmit(@RequestParam("deleteReason") String reason, @RequestParam("goodsId") int goodsId) throws Exception, SQLException  {
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("reason", reason);
		hashmap.put("goodsId", goodsId);
		
//		int result = nondisclosureRequestService.insertNondisclosureRequest(hashmap);
//
//		if(result != 1) {
//			throw new Exception("다시 시도해주세요.");
//		}
			
		return "redirect:/goods/registered/sales/" + Integer.toString(goodsId);
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
