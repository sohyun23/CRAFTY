package crafty.dto;

import lombok.Data;

@Data
public class ResponseAttendedGoodsDetail {
	private int	goodsId;
	private String goodsName;
	private String imgPath;
	private String imgName;
	private int deliveryFee;
	private int totalAmount;
	private String deliveryNum;
	private String deliveryCompany;
	private String deliveryStatus;
	private String name;
	private String phoneNum;
	private String zoneCode;
	private String roadAddress;
	private String detailAddress;
}
