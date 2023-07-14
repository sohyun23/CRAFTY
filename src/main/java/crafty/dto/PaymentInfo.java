package crafty.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class PaymentInfo {
	private int		paymentId;
	private int		orderId;
	private String	impUid;
	private int		payAmount;
	private String	paymentMean;	// 추가
	private	String	status;
	private Date	payCreatedAt;
	private	Date	payUpdatedAt;
}
