package crafty.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ResponseRegisteredGoodsDetail { // 등록 굿즈 상세 페이지 공통DTO
	private int goodsId;
	private String goodsName;
	private String imgPath;
	private String imgName;
	private Date startDate;
	private Date endDate;
	private int salesNum; // 판매 건 수 
	private int salesTotalNum; // 총 굿즈 판매 개수
	private int salesTotalAmount; // 총 판매 금액
}
