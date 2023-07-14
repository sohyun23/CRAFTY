package crafty.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ResponseRegisterRequest {
	private int		goodsId;
	private String	goodsName;
	private int		memberId;
	private String	nickname;
	private Date	goodsCreatedAt;
}
