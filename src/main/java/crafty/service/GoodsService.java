package crafty.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import crafty.dto.GoodsResponse;
import crafty.dto.ItemResponse;
import crafty.dto.ResponseGoodsDetail;
import crafty.dto.ResponseGoodsManagement;
import crafty.dto.ResponseNondisclosureRequest;
import crafty.dto.ResponseRegisterRequest;
import crafty.dto.ResponseRegisteredGoods;
import crafty.dto.ResponseRegisteredGoodsDetail;
import crafty.mapper.GoodsMapper;
import crafty.pagination.dto.MainCard;
import crafty.pagination.dto.PageRequestDTO;

@Service
public class GoodsService {
	
	@Autowired
	GoodsMapper goodsMapper;
	
	// 등록된 모든 굿즈를 반환하는 메서드
	public List<ResponseGoodsManagement> getManagementGoods(PageRequestDTO pageRequest) {
		List<ResponseGoodsManagement> goodsList = goodsMapper.getManagementGoods(pageRequest);
		
		return goodsList;
	}
	
	// 등록된 모든 굿즈의 개수를 반환하는 메서드
	public int getTotalManagementGoodsCount() {
		int totalCnt = goodsMapper.getTotalManagementGoodsCount();
		
		return totalCnt;
	}
	
	// 비공개 요청한 굿즈를 반환하는 메서드
	public List<ResponseNondisclosureRequest> getNondisclosureRequestGoods(PageRequestDTO pageRequest) {
		List<ResponseNondisclosureRequest> goodsList = goodsMapper.getNondisclosureRequestGoods(pageRequest);
		
		return goodsList;
	}
	
	// 비공개 요청한 굿즈의 개수를 반환하는 메서드
	public int getNondisclosureRequestGoodsCount() {
		int totalCnt = goodsMapper.getNondisclosureRequestGoodsCount();
		
		return totalCnt;
	}
	
	// 등록 요청한 굿즈를 반환하는 메서드
	public List<ResponseRegisterRequest> getRegisterRequestGoods(PageRequestDTO pageRequest) {
		List<ResponseRegisterRequest> goodsList = goodsMapper.getRegisterRequestGoods(pageRequest);
		
		return goodsList;
	}
	
	// 등록 요청한 굿즈의 개수를 반환하는 메서드
	public int getRegisterRequestGoodsCount() {
		int totalCnt = goodsMapper.getRegisterRequestGoodsCount();
		
		return totalCnt;
	}

	public List<MainCard> getMainGoods(PageRequestDTO pageRequest) {
		List<MainCard> goodsList = goodsMapper.getMainGoods(pageRequest);
		return goodsList;
	}

	public int getMainGoodsTotalCount(PageRequestDTO pageRequest) {
		int result = goodsMapper.getMainGoodsTotalCount(pageRequest);
		return result;
	}

	public void registGoods(GoodsResponse goodsResponse, List<ItemResponse> itemList, MultipartFile thumbnailFile,
			MultipartFile descriptionFile) {
		
	}
	
	// 굿즈 상세 정보
	public ResponseGoodsDetail getGoodsByGoodsId(int goodsId) throws SQLException{
		ResponseGoodsDetail goods = goodsMapper.getGoodsByGoodsId(goodsId);
		
		return goods;
	}
	
	// 굿즈 썸네일 
	public String getGoodsThumbnailImgNameByGoodsId(int goodsId) throws SQLException{
		String thumbnailImgName = goodsMapper.getGoodsThumbnailImgNameByGoodsId(goodsId);
				
		return thumbnailImgName;
	}
	
	// 굿즈 본문 이미지
	public String getGoodsContentImgNameByGoodsId(int goodsId) throws SQLException{
		String contentImgName = goodsMapper.getGoodsContentImgNameByGoodsId(goodsId);
		
		return contentImgName;
	}
	
	// 등록 굿즈 리스트 페이지
	public List<ResponseRegisteredGoods> getRegisteredGoodsByMemberId(HashMap<String, Object> hashmap) throws SQLException{
		
		List<ResponseRegisteredGoods> goodsList = goodsMapper.getRegisteredGoodsByMemberId(hashmap);
		
		return goodsList;
	}

	public int getTotalRegisteredGoodsByMemberId(int memberId) throws SQLException{
		
		int totalCnt = goodsMapper.getTotalRegisteredGoodsByMemberId(memberId);
		
		return totalCnt;
	}
	
	// 등록 굿즈 품목 별 판매량 확인 페이지
	public ResponseRegisteredGoodsDetail getRegisteredGoodsDetailByGoodsId(int goodsId) throws SQLException{
		
		ResponseRegisteredGoodsDetail goods = goodsMapper.getRegisteredGoodsDetailByGoodsId(goodsId);
		
		return goods;
	}
	
	// 굿즈 등록 요청 허가 메서드
	public int updateGoodsRegistrationStatusAllowByGoodsId(int goodsId) throws SQLException{
		
		int result = goodsMapper.updateGoodsRegistrationStatusAllowByGoodsId(goodsId);
		
		return result;
	}
	
	// 굿즈 등록 요청 불허 메서드
	public int updateGoodsRegistrationStatusDisallowByGoodsId(int goodsId) throws SQLException{
		
		int result = goodsMapper.updateGoodsRegistrationStatusDisallowByGoodsId(goodsId);
		
		return result;
	}
	
	// 굿즈 삭제 요청 허가 메서드 
	public int updateGoodsNondisclosureStatusByGoodsId(int goodsId) throws SQLException{
		int result = goodsMapper.updateGoodsNondisclosureStatusByGoodsId(goodsId);
		
		return result;
	}
	
}
