package crafty.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import crafty.dto.Orders;
import crafty.mapper.OrdersMapper;

@Service
public class OrdersService {

	@Autowired
	OrdersMapper ordersMapper;
	
	public List<Orders> getOrdersByGoodsId(HashMap hashMap) {
		List<Orders> ordersList = ordersMapper.getOrdersByGoodsId(hashMap);
		
		return ordersList;
	}

	public int getPurchaserListCount(int goodsId) {
		
		int total = ordersMapper.getPurchaserListCount(goodsId);
		
		return total;
	}

}
