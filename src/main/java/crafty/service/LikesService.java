package crafty.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import crafty.dto.Goods;
import crafty.dto.Likes;
import crafty.mapper.LikesMapper;

@Service
public class LikesService {
	
	@Autowired
	LikesMapper likesMapper;
	
	//객체?
	public List<Goods> getGoodsByMemberId(int memberId) {
		List<Goods> goodsList = likesMapper.getGoodsByMemberId(memberId);
		
		return goodsList;
	}
	
	// 좋아요 
	public int insertLikeByGoodsIdAndMemberId(HashMap<String, Object> hashmap) throws SQLException {
		int result = likesMapper.insertLikeByGoodsIdAndMemberId(hashmap);
		
		return result;
	}
	
	// 좋아요 취소
	public int deleteLikeByLikeId(int likeId) throws SQLException {
		int result = likesMapper.deleteLikeByLikeId(likeId);
		
		return result;
	}


	
	
	//출력시킬 것
	
	//id로 필터링
	  
	
}
