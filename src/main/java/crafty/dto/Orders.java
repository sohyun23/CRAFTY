package crafty.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Orders {
	private int		orderId;
	private int		memberId;
	private int		goodsId;
	private int		itemTotalAmount;
	private int		deliveryFee;
	private int		totalAmount;
	private String	deliveryNum;
	private String	deliveryCompany;
	private String	deliveryStatus;
	private Date	orderCreatedAt;
	private	Date	orderUpdatedAt;
}
