package crafty.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import crafty.dto.Item;
import crafty.mapper.ItemMapper;

@Service
public class ItemService {
	
	@Autowired
	ItemMapper itemMapper;
	
	public List<Item> getItemsByGoodsId(int goodsId) {
		List<Item> itemList = itemMapper.getItemsByGoodsId(goodsId);
		
		return itemList;
	}


}
