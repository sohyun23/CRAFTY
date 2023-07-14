package crafty.service;

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
	public ResponseGoodsDetail getGoodsByGoodsId(int goodsId) {
		ResponseGoodsDetail goods = goodsMapper.getGoodsByGoodsId(goodsId);
		
		return goods;
	}
	
	// 굿즈 썸네일 
	public String getGoodsThumbnailImgNameByGoodsId(int goodsId) {
		String thumbnailImgName = goodsMapper.getGoodsThumbnailImgNameByGoodsId(goodsId);
				
		return thumbnailImgName;
	}
	
	// 굿즈 본문 이미지
	public String getGoodsContentImgNameByGoodsId(int goodsId) {
		String contentImgName = goodsMapper.getGoodsContentImgNameByGoodsId(goodsId);
		
		return contentImgName;
	}
	
}
