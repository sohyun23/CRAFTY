package crafty.dto;

import java.util.Date;

import lombok.Data;

@Data
public class ResponsePurchaserList {
	private int orderId;
	private int memberId;
	private String nickname;
	private Date orderCreatedAt;
	private String paymentMean;
	private int totalAmount;
}
