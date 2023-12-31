package crafty.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@AllArgsConstructor
@Builder
public class Goods {
	private int		goodsId;
	private int		memberId;
	private String	goodsName;
	private	String	startDate;
	private	String	endDate;
	private	String	category;
	private String	introduction;
	private int		targetAmount;
	private	String	postDate;
	private	String	bankName;
	private	String	bankAccountNumber;
	private int		aggrement;
	private int		ongoingStatus;
	private int		productionStatus;
	private int		registrationStatus;
	private int		nondisclosureStatus;
	private Date	goodsCreatedAt;
	private	Date	goodsUpdatedAt;
}
