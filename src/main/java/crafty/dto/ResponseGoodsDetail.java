package crafty.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ResponseGoodsDetail {
	private int goodsId;
	private String goodsName;
	private String introduction;
	private int memberId;
	private String nickname;
	private String profileImg;
	private Date startDate;
	private Date endDate;
	private int ongoingStatus;
	private int registrationStatus;
}
