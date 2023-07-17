package crafty.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ResponseAttendedGoods {
	private int orderId;
	private int goodsId;
	private String goodsName;
	private Date orderCreatedAt;
	private int ongoingStatus;
	private int productionStatus;
}