package crafty.mapper;

import org.apache.ibatis.annotations.Mapper;

import crafty.dto.GoodsDesciptionImg;

@Mapper
public interface GoodsDescriptionImgMapper {

	// 굿즈 img 등록
	public int registerGoodsImg(GoodsDesciptionImg img);



}
