package crafty.mapper;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import org.apache.ibatis.annotations.Mapper;

import crafty.dto.Goods;
import crafty.dto.Likes;
import crafty.pagination.dto.MainCard;

@Mapper
public interface LikesMapper {
	public List<Likes> LikeList(); 
	
	public List<Goods> getGoodsByMemberId(int memberId);
	
	// 좋아요
	public int insertLikeByGoodsIdAndMemberId(HashMap<String, Object> hashmap) throws SQLException;

	public int deleteLikeByLikeId(int likeId) throws SQLException;
	
	public List<MainCard> getLikedGoodsByMemberId(HashMap hashmap) throws SQLException;
	
	public int getLikedGoodsTotalCount(int memberId) throws SQLException;
}
