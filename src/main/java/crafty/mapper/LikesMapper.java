package crafty.mapper;

import java.util.List;
import java.util.Optional;

import org.apache.ibatis.annotations.Mapper;

import crafty.dto.Goods;
import crafty.dto.Likes;

@Mapper
public interface LikesMapper {
	public List<Likes> LikeList(); 
	
	public List<Goods> getGoodsByMemberId(int memberId);
}
