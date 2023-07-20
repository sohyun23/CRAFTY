package crafty.mapper;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import crafty.dto.Orders;
import crafty.dto.PaymentInfo;
import crafty.dto.ResponseAttendedGoods;
import crafty.dto.ResponseAttendedGoodsDetail;
import crafty.dto.ResponseRegisteredGoodsDetailOrders;

@Mapper
public interface OrdersMapper {

	public List<Orders> getOrdersByGoodsId(HashMap<String, Object> hashMap);

	public int getPurchaserListCount(int goodsId);
	
	public List<ResponseAttendedGoods> getOrdersByMemberId(HashMap<String, Object> hashmap) throws SQLException;

	public int getTotalAttendedGoodsByMemberId(int memberId) throws SQLException;

	public ResponseAttendedGoodsDetail getOrderByOrderId(HashMap<String, Object> hashmap) throws SQLException;

	public List<ResponseRegisteredGoodsDetailOrders> getRegisteredGoodsDetailOrdersByGoodsId(
			HashMap<String, Object> hashmap) throws SQLException;

	public int updateDeliveryInfoByOrderId(HashMap<String, Object> hashmap) throws SQLException;
	
	// 주문 번호 생성
	public int createOrderId() throws SQLException;
	
	// 주문 정보 생성
	public int insertOrders(Orders order) throws SQLException;

}
