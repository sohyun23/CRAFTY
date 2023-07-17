package crafty.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ResponseRegisteredGoods {
	private int goodsId;
	private String goodsName;
	private Date goodsCreatedAt;
	private int ongoingStatus;
	private int productionStatus;
	private int registrationStatus;
}
