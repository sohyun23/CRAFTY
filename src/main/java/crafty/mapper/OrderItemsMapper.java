package crafty.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import crafty.dto.OrderItems;

@Mapper
public interface OrderItemsMapper {

	int insertOrderItems(List<OrderItems> orderItemsList) throws Exception;

	int deleteOrderItemsByOrderId(int orderId) throws Exception;

}
