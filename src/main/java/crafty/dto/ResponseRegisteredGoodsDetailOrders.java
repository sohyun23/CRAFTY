package crafty.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ResponseRegisteredGoodsDetailOrders {
	private int orderId;
	private Date orderCreatedAt;
	private String orderItems;
	private int totalAmount;
	private int memberId;
	private String nickname;
	private String deliveryNum;
}
