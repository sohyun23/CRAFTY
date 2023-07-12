package crafty.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Likes {
	private int		likeId;
	private int		memberId;
	private int		goodsId;
}
