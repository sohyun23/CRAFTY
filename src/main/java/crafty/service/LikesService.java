package crafty.service;

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


	
	
	//출력시킬 것
	
	//id로 필터링
	  
	
}
