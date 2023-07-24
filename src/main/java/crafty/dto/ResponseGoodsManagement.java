package crafty.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ResponseGoodsManagement {
	private int		goodsId;
	private String	goodsName;
	private int		memberId;
	private String	nickname;
	private Long	amount;
	private	Date	adjustmentCreatedAt;
	private Long	lastTotalAmount;
}
