package crafty.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Goods {
	private int		goodsId;
	private int		memeberId;
	private String	goodsName;
	private	Date	startDate;
	private	String	category;
	private String	introduction;
	private int		targetAmount;
	private	Date	postDate;
	private	String	bankName;
	private	String	bankAccountNumber;
	private int		aggrement;
	private int		ongoingStatus;
	private int		productionStatus;
	private int		registrationStatus;
	private int		nondisclosure_status;
	private Date	goodsCreatedAt;
	private	Date	goodsUpdatedAt;
}
