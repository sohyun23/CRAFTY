package crafty.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import crafty.dto.Item;

@Mapper
public interface ItemMapper {
	List<Item> getItemsByGoodsId(int goodsId);
}
