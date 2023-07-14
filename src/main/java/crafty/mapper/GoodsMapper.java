package crafty.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import crafty.dto.ResponseGoodsDetail;
import crafty.dto.ResponseGoodsManagement;
import crafty.dto.ResponseNondisclosureRequest;
import crafty.dto.ResponseRegisterRequest;
import crafty.pagination.dto.MainCard;
import crafty.pagination.dto.PageRequestDTO;

@Mapper
public interface GoodsMapper {
	
	// 관리자 - 모든 굿즈
	public List<ResponseGoodsManagement> getManagementGoods(PageRequestDTO pageRequest);
	
	public int getTotalManagementGoodsCount();

	// 관리자 - 비공개 요청
	public List<ResponseNondisclosureRequest> getNondisclosureRequestGoods(PageRequestDTO pageRequest);

	public int getNondisclosureRequestGoodsCount();

	// 관리자 - 등록 요청
	public List<ResponseRegisterRequest> getRegisterRequestGoods(PageRequestDTO pageRequest);

	public int getRegisterRequestGoodsCount();
	
	// 메인 페이지
	public List<MainCard> getMainGoods(PageRequestDTO pageRequest);

	public int getMainGoodsTotalCount(PageRequestDTO pageRequest);
	
	public ResponseGoodsDetail getGoodsByGoodsId(int goodsId);
	
	public String getGoodsThumbnailImgNameByGoodsId(int goodsId);
	
	public String getGoodsContentImgNameByGoodsId(int goodsId);

}
