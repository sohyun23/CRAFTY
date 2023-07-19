package crafty.mapper;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import crafty.dto.Goods;
import crafty.dto.ResponseGoodsDetail;
import crafty.dto.ResponseGoodsManagement;
import crafty.dto.ResponseNondisclosureRequest;
import crafty.dto.ResponseRegisterRequest;
import crafty.dto.ResponseRegisteredGoods;
import crafty.dto.ResponseRegisteredGoodsDetail;
import crafty.pagination.dto.MainCard;
import crafty.pagination.dto.PageProperties;
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
	public List<MainCard> getMainGoods(@Param("pageRequest") PageRequestDTO pageRequest,
									   @Param("pageProperties") PageProperties pageProperties,
									   @Param("keyword") String keyword);

	public int getMainGoodsTotalCount(@Param("pageRequest") PageRequestDTO pageRequest,
								      @Param("pageProperties") PageProperties pageProperties,
								      @Param("keyword") String keyword);
	
	public ResponseGoodsDetail getGoodsByGoodsId(int goodsId) throws SQLException;
	
	public String getGoodsThumbnailImgNameByGoodsId(int goodsId) throws SQLException;
	
	public String getGoodsContentImgNameByGoodsId(int goodsId) throws SQLException;

	public List<ResponseRegisteredGoods> getRegisteredGoodsByMemberId(HashMap<String, Object> hashmap) throws SQLException;

	public int getTotalRegisteredGoodsByMemberId(int memberId) throws SQLException;
	
	// 등록 굿즈 상세 공통
	public ResponseRegisteredGoodsDetail getRegisteredGoodsDetailByGoodsId(int goodsId) throws SQLException;
	
	// 굿즈 등록 허가
	public int updateGoodsRegistrationStatusAllowByGoodsId(int goodsId) throws SQLException;
	
	// 굿즈 등록 불허
	public int updateGoodsRegistrationStatusDisallowByGoodsId(int goodsId) throws SQLException;
	
	// 굿즈 삭제 허가 
	public int updateGoodsNondisclosureStatusByGoodsId(int goodsId) throws SQLException;
	
	// 프로필 페이지 굿즈 리스트
	public List<MainCard> getGoodsByMemberId(HashMap<String, Object> hashmap) throws SQLException;
	
	public int getTotalGoodsByMemberId(int memberId) throws SQLException;
	
	// 굿즈 등록 
	public int registerGoods(Goods goods) throws Exception;
}
