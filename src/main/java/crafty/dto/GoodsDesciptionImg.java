package crafty.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@AllArgsConstructor
@Builder
public class GoodsDesciptionImg {
	private int		imgId;
	private int		goodsId;
	private String	imgPath;
	private String	imgOriginalName;
	private String	imgName;
	private	int		imgPosition;
	private Date	ImgCreatedAt;
	private	Date	ImgUpdatedAt;
}
