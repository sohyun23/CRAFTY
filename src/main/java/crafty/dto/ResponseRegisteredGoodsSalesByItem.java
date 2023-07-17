package crafty.dto;

import lombok.Data;

@Data
public class ResponseRegisteredGoodsSalesByItem {
	private String itemName;
	private int itemPrice;
	private int salesTotalNum; // 판매 개수
	private int salesTotalAmount; // 판매 금액
}
