package crafty.dto;

import java.util.Date;

import lombok.Data;

@Data
public class ResponseNondisclosureRequest {
	private int		goodsId;
	private String	goodsName;
	private int		memberId;
	private String	nickname;
	private Date	nondisclosureCreatedAt;
	private String	nondisclosureReason;
}
