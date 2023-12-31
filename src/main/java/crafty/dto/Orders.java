package crafty.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@AllArgsConstructor
@Builder
public class Orders {
	private int		orderId;
	private int		memberId;
	private int		goodsId;
	private int		itemTotalAmount;
	private int		deliveryFee;
	private int		totalAmount;
	private String 	paymentMean;	// 추가
	private String	deliveryNum;
	private String	deliveryCompany;
	private String	deliveryStatus;
	private Date	orderCreatedAt;
	private	Date	orderUpdatedAt;
}
