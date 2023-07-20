package crafty.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class PaymentInfo {
	private int		paymentId;
	private int		orderId;
	private String	impUid;
	private int		payAmount;
	private String	paymentMean;
	private	String	status;
	private Date	payCreatedAt;
	private	Date	payUpdatedAt;
}
