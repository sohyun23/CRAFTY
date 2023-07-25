package crafty.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import crafty.dto.MemberEmailInfo;
import crafty.dto.OrderItems;
import crafty.dto.Orders;
import crafty.dto.PaymentInfo;
import crafty.dto.ResponseAttendedGoods;
import crafty.dto.ResponseAttendedGoodsDetail;
import crafty.dto.ResponseRegisteredGoodsDetailOrders;
import crafty.mapper.MemberMapper;
import crafty.mapper.OrdersMapper;

@Service
public class OrdersService {
	
	private final JavaMailSender javaMailSender;
	
	@Autowired
    public OrdersService(JavaMailSender javaMailSender) {
        this.javaMailSender = javaMailSender;
    }
	
	@Autowired
	OrdersMapper ordersMapper;
	
	@Autowired
	OrderItemsService orderItemsService;
	
	@Autowired
	PaymentInfoService paymentInfoService;
	
	@Autowired
	MemberMapper memberMapper;
	
	public List<Orders> getOrdersByGoodsId(HashMap hashMap) {
		List<Orders> ordersList = ordersMapper.getOrdersByGoodsId(hashMap);
		
		return ordersList;
	}

	public int getPurchaserListCount(int goodsId) {
		
		int total = ordersMapper.getPurchaserListCount(goodsId);
		
		return total;
	}

	public List<ResponseAttendedGoods> getOrdersByMemberId(HashMap<String, Object> hashmap) throws SQLException{
		List<ResponseAttendedGoods> orderList = ordersMapper.getOrdersByMemberId(hashmap);
		
		return orderList;
	}

	public int getTotalAttendedGoodsByMemberId(int memberId) throws SQLException{
		
		int total = ordersMapper.getTotalAttendedGoodsByMemberId(memberId);
		
		return total;
	}

	public ResponseAttendedGoodsDetail getOrderByOrderId(HashMap<String, Object> hashmap) throws SQLException{
		
		ResponseAttendedGoodsDetail order = ordersMapper.getOrderByOrderId(hashmap);
		
		return order;
	}

	public List<ResponseRegisteredGoodsDetailOrders> getRegisteredGoodsDetailOrdersByGoodsId(
			HashMap<String, Object> hashmap) throws SQLException{
		List<ResponseRegisteredGoodsDetailOrders> orderList = ordersMapper.getRegisteredGoodsDetailOrdersByGoodsId(hashmap);
		
		return orderList;
	}

	public int updateDeliveryInfoByOrderId(HashMap<String, Object> hashmap) throws SQLException {
		int result = ordersMapper.updateDeliveryInfoByOrderId(hashmap);
		
		return result;
	}
	
	// 주문 번호 생성
	public int createOrderId() throws SQLException {
		
		int createdOrderId = ordersMapper.createOrderId();
		
		return createdOrderId;
	}

	// 결제 정보 생성
	@Transactional
	public boolean insertOrders(Orders order, List<Integer> itemIdList, PaymentInfo payInfo) throws Exception {
		boolean result = false;
		
		// order 생성
		int orderRes = ordersMapper.insertOrders(order);
		
		if(orderRes != 0) {
			// order_items 생성
		    List<OrderItems> orderItemsList = new ArrayList<OrderItems>();
		    for(int i = 0; i < itemIdList.size(); i++) {
		    	OrderItems orderItem = OrderItems.builder()
		    			.orderId(order.getOrderId())
		    			.itemId(itemIdList.get(i))
		    			.build();
		    	orderItemsList.add(orderItem);
		    };
			
		    // order_items 
		    orderItemsService.insertOrderItems(orderItemsList);
		    
		    // payment_info
		    paymentInfoService.insertPaymentInfo(payInfo);
		    
		    // 결제 정보 메일 전송
		    MemberEmailInfo member = memberMapper.getMemberEmailInfoByOrderId(order.getOrderId());
			
			String to = member.getEmail();
			String subject = "[CRAFTY] " + member.getGoodsName() + "주문 내역을 안내드립니다.";
			String text = member.getNickname() + "님이 주문하신 굿즈 결제 내역을 알려드립니다.\n"
						 + "굿즈명: " + member.getGoodsName() + "\n"
						 + "결제 금액: " + order.getTotalAmount();
	                    
			
			SimpleMailMessage message = new SimpleMailMessage();
	        message.setTo(to);
	        message.setSubject(subject);
	        message.setText(text);
	        javaMailSender.send(message);
		    
		    result = true;
		} else {
			throw new Exception("주문 정보 생성 실패");
		}
				
		return result;
	}
	
}
