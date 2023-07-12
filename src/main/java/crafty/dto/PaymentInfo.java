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
	private	String	status;
	private Date	orderCreatedAt;
	private	Date	orderUpdatedAt;
}
