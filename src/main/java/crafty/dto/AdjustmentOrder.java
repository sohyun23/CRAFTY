package crafty.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class AdjustmentOrder {
	private int		adjustmentOrderId;
	private int		goodsId;
	private int		lastTotalAmount;
	private Date	adjustmentCreatedAt;
	private	Date	adjustmentUpdatedAt;
}
