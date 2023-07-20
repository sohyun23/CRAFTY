package crafty.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import crafty.dto.OrderItems;
import crafty.mapper.OrderItemsMapper;

@Service
public class OrderItemsService {
	
	@Autowired
	OrderItemsMapper orderItemsMapper;
	
	@Transactional
	public void insertOrderItems(List<OrderItems> orderItemsList) throws Exception {
		
		int res = orderItemsMapper.insertOrderItems(orderItemsList);
		
		if(res == 0) {
			throw new Exception("주문 정보 생성 실패");
		}
	}

	// 결제 실패
	public int deleteOrderItemsByOrderId(int orderId) throws Exception {
		
		int res = orderItemsMapper.deleteOrderItemsByOrderId(orderId);
		
		if(res == 0) {
			throw new Exception("주문 정보 삭제 실패");			
		}
		
		return res;
	}

}
