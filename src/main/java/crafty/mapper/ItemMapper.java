package crafty.mapper;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import crafty.dto.Item;
import crafty.dto.ResponseRegisteredGoodsSalesByItem;

@Mapper
public interface ItemMapper {
	List<Item> getItemsByGoodsId(int goodsId);

	List<Item> getItemsByOrderId(int orderId);
	
	// 등록 굿즈 품목 별 판매량 확인 페이지
	List<ResponseRegisteredGoodsSalesByItem> getRegisteredGoodsSalesByItemByGoodsId(
			HashMap<String, Object> hashmap) throws SQLException;

	int getTotalRegisteredGoodsSalesByItemByGoodsId(int goodsId) throws SQLException;
	
	// item 등록
	public int registerGoodsItems(List<Item> itemList);
}
