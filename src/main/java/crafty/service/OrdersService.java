package crafty.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import crafty.dto.Orders;
import crafty.dto.ResponseAttendedGoods;
import crafty.dto.ResponseAttendedGoodsDetail;
import crafty.dto.ResponseRegisteredGoodsDetailOrders;
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

}
