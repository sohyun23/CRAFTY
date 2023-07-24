package crafty.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import crafty.dto.MemberEmailInfo;
import crafty.dto.OrderItems;
import crafty.dto.Orders;
import crafty.dto.PaymentInfo;
import crafty.dto.RequestPayment;
import crafty.service.GoodsService;
import crafty.service.LikesService;
import crafty.service.MemberService;
import crafty.service.NondisclosureRequestService;
import crafty.service.OpenAlarmService;
import crafty.service.OrderItemsService;
import crafty.service.OrdersService;
import crafty.service.PaymentInfoService;

@RestController
public class CraftyRestController {
	
	private final JavaMailSender javaMailSender;
	
	@Autowired
	GoodsService goodsService;
	
	@Autowired
	LikesService likesService;
	
	@Autowired
	NondisclosureRequestService nondisclosureRequestService;
	
	@Autowired
	OpenAlarmService openAlarmService;
	
	@Autowired
	OrdersService ordersService;
	
	@Autowired
	OrderItemsService orderItemsService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	PaymentInfoService paymentInfoService;
	
	@Autowired
    public CraftyRestController(JavaMailSender javaMailSender) {
        this.javaMailSender = javaMailSender;
    }
	
	// 굿즈 등록 허가
	@GetMapping("/request/register/allow/{goodsId}")
	public String registerRequestAllow(@PathVariable("goodsId") int goodsId) throws Exception{
		int result = goodsService.updateGoodsRegistrationStatusAllowByGoodsId(goodsId);
		
		if(result != 0) {
			// 굿즈 등록 허가 메일 전송
			MemberEmailInfo member = memberService.getMemberEmailInfoByGoodsId(goodsId);
			
			String to = member.getEmail();
			String subject = member.getNickname() + "님이 등록 신청하신 굿즈가 등록 허가되었습니다.";
			String text = member.getNickname() + "님!\n"
	                    + "등록 신청하신 굿즈 '" + member.getGoodsName() + "'가 등록 허가 되었습니다!\n";
			
			SimpleMailMessage message = new SimpleMailMessage();
	        message.setTo(to);
	        message.setSubject(subject);
	        message.setText(text);
	        javaMailSender.send(message);
		} else {
			throw new Exception("다시 시도해주세요.");
		}
		
		return "등록 허가했습니다.";
	}
	
	// 굿즈 등록 불허
	@GetMapping("/request/register/disallow/{goodsId}")
	public String registerRequestDisallow(@PathVariable("goodsId") int goodsId) throws Exception{
		int result = goodsService.updateGoodsRegistrationStatusDisallowByGoodsId(goodsId);
		
		if(result != 0) {
			// 굿즈 등록 불허가 메일 전송
			MemberEmailInfo member = memberService.getMemberEmailInfoByGoodsId(goodsId);
			
			String to = member.getEmail();
			String subject = member.getNickname() + "님이 등록 신청하신 굿즈가 등록 불허가되었습니다.";
			String text = member.getNickname() + "님!\n"
	                    + "등록 신청하신 굿즈 '" + member.getGoodsName() + "'가 등록 불허가 되었습니다.\n";
			
			SimpleMailMessage message = new SimpleMailMessage();
	        message.setTo(to);
	        message.setSubject(subject);
	        message.setText(text);
	        javaMailSender.send(message);
		} else {
			throw new Exception("다시 시도해주세요.");
		}
		
		return "등록 불허가했습니다.";
	}
	
	// 굿즈 비공개 허가
	@GetMapping("request/nondisclosure/allow/{goodsId}")
	public String nondisclosureRequestAllow(@PathVariable("goodsId") int goodsId) throws Exception, SQLException{
		int result = goodsService.updateGoodsNondisclosureStatusByGoodsId(goodsId);

		if(result != 0) {
			// 굿즈 삭제 허가 메일 전송
			MemberEmailInfo member = memberService.getMemberEmailInfoByGoodsId(goodsId);
			
			String to = member.getEmail();
			String subject = member.getNickname() + "님이 삭제 신청하신 굿즈가 삭제 허가되었습니다.";
			String text = member.getNickname() + "님!\n"
	                    + "삭제 신청하신 굿즈 '" + member.getGoodsName() + "'가 삭제 허가 되었습니다.\n";
			
			SimpleMailMessage message = new SimpleMailMessage();
	        message.setTo(to);
	        message.setSubject(subject);
	        message.setText(text);
	        javaMailSender.send(message);
		} else {
			throw new Exception("다시 시도해주세요.");
		}
		
		return "비공개 허가했습니다.";
	}
	
	// 굿즈 비공개 불허
	@GetMapping("request/nondisclosure/disallow/{goodsId}")
	public String nondisclosureRequestDisallow(@PathVariable("goodsId") int goodsId) throws Exception, SQLException{
		int result = nondisclosureRequestService.updateNondisclosureRequestNondisclosureStatusByGoodsId(goodsId);
		
		if(result != 0) {
			// 굿즈 삭제 불허가 메일 전송
			MemberEmailInfo member = memberService.getMemberEmailInfoByGoodsId(goodsId);
			
			String to = member.getEmail();
			String subject = member.getNickname() + "님이 삭제 신청하신 굿즈가 삭제 불허가되었습니다.";
			String text = member.getNickname() + "님!\n"
	                    + "삭제 신청하신 굿즈 '" + member.getGoodsName() + "'가 삭제 불허가 되었습니다.\n";
			
			SimpleMailMessage message = new SimpleMailMessage();
	        message.setTo(to);
	        message.setSubject(subject);
	        message.setText(text);
	        javaMailSender.send(message);
		} else {
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
	
	
	// 주문 번호와 주문자 정보 생성
	@GetMapping("/create/consumer/info")
	public RequestPayment createOrderId(HttpSession session) throws Exception {
		int memberId = (int) session.getAttribute("memberId");
		
		// 주문자 정보
		RequestPayment requestPayment = memberService.getMemberByMemberId(memberId);
		// 주문 번호
		int createdOrderId = ordersService.createOrderId();
		
		requestPayment.setOrderId(createdOrderId);
		
		return requestPayment;
	}
	
	// 결제 - orders, order_items 메서드
	@PostMapping(value = "/payment/order")
	public int goodsOrder(HttpSession session, @RequestBody Map<String, Object> data) throws Exception {
		int orderId = Integer.parseInt((String)data.get("orderId"));
		String impUid = (String) data.get("impUid");
		int payAmount = (int) data.get("payAmount");
		String paymentMean = (String) data.get("paymentMean");
		String status = (String) data.get("status");
		int memberId = (int) session.getAttribute("memberId");
		int goodsId = (int) data.get("goodsId");
		int totalPrice = (int) data.get("totalPrice");
		int delivery = (int) data.get("delivery");
		int totalPayPrice = (int) data.get("totalPayPrice");
		List<Integer> itemIdList = (List<Integer>) data.get("itemIdList");
		
		// 주문 정보
		Orders order = Orders.builder()
				.orderId(orderId)
				.memberId(memberId)
				.goodsId(goodsId)
				.itemTotalAmount(totalPrice)
				.deliveryFee(delivery)
				.totalAmount(totalPayPrice)
				.build();
		
		// 결제 정보
		PaymentInfo payInfo = PaymentInfo.builder()
				 .orderId(orderId)
				 .impUid(impUid)
				 .payAmount(payAmount)
				 .paymentMean(paymentMean)
				 .status(status)
				 .build();
		
		boolean res = ordersService.insertOrders(order, itemIdList, payInfo);
		
		// res가 false
		if(!res) {
			throw new Exception("결제 정보 저장 실패");
		}
		
		return orderId;
	}
}
