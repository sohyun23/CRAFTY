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
	
	// 메인 - 오늘 가장 많이 팔린 굿즈
	public List<MainCard> getMostOrderGoods() throws Exception;
	
	// 메인 - 오늘 오픈한 굿즈
	public List<MainCard> getDebutGoods() throws Exception;
	
	// 메인 - 오픈 예정 굿즈
	public List<MainCard> getOpenScheduledGoods() throws Exception;
	
	public ResponseGoodsDetail getGoodsByGoodsId(HashMap<String, Object> hashmap) throws SQLException;
	
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
	
	public int getTotalGoodsByMemberId(@Param("memberId") int memberId, @Param("ongoing") int ongoing) throws SQLException;
	
	// 굿즈 등록 
	public int registerGoods(Goods goods) throws Exception;
	
	// 오픈 예정 굿즈의 상태를 진행중으로 변경
	public void updateGoodsStatusToInProgress() throws Exception;
	
	// 매일 정각, 목표 금액에 도달하지 못한 진행중인 굿즈의 상태를 종료로 변경
	public void updateGoodsStatusToInCompletedAndFailure() throws Exception;
	
	// 매일 정각, 목표 금액에 도달한 진행중인 굿즈의 상태를 종료로 변경
	public void updateGoodsStatusToInCompletedAndSuccess() throws Exception;
}
