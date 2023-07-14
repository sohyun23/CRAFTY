package crafty.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import crafty.dto.Orders;

@Mapper
public interface OrdersMapper {

	public List<Orders> getOrdersByGoodsId(HashMap hashMap);

	public int getPurchaserListCount(int goodsId);

}
