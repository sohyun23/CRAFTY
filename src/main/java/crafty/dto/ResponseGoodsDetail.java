package crafty.dto;

import lombok.Data;

@Data
public class ResponseGoodsDetail {
	private int goodsId;
	private String goodsName;
	private String introduction;
	private int memberId;
	private String nickname;
	private String profileImg;
}
