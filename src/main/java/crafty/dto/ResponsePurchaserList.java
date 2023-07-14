package crafty.dto;

import java.util.Date;

import lombok.Data;

@Data
public class ResponsePurchaserList {
	private int orderId;
	private int memberId;
	private String nickname;
	private Date orderCreatedAt;	// java.util 클래스 -> 시간도 가져옴, java.sql 클래스 -> 날짜만 가져옴
	private String paymentMean;
	private int totalAmount;
}
