package crafty.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import crafty.dto.Item;
import crafty.dto.ResponseRegisteredGoodsSalesByItem;
import crafty.mapper.ItemMapper;

@Service
public class ItemService {
	
	@Autowired
	ItemMapper itemMapper;
	
	public List<Item> getItemsByGoodsId(int goodsId) {
		List<Item> itemList = itemMapper.getItemsByGoodsId(goodsId);
		
		return itemList;
	}

	public List<Item> getItemsByOrderId(int orderId) {
		
		List<Item> itemList = itemMapper.getItemsByOrderId(orderId);
		
		return itemList;
	}
	
	// 등록 굿즈 상세 페이지 - 품목 별 판매량
	public List<ResponseRegisteredGoodsSalesByItem> getRegisteredGoodsSalesByItemByGoodsId(
			HashMap<String, Object> hashmap) throws SQLException{
		
		List<ResponseRegisteredGoodsSalesByItem> itemList = itemMapper.getRegisteredGoodsSalesByItemByGoodsId(hashmap);
		
		return itemList;
	}

	public int getTotalRegisteredGoodsSalesByItemByGoodsId(int goodsId) throws SQLException{
		
		int totalCnt = itemMapper.getTotalRegisteredGoodsSalesByItemByGoodsId(goodsId);
		
		return totalCnt;
	}


}
