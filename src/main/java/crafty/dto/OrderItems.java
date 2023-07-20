package crafty.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@AllArgsConstructor
@Builder
public class OrderItems {
	private int		orderItemsId;
	private int		orderId;
	private int		itemId;
	private Date	orderItemCreatedAt;
	private Date	orderItemUpdatedAt;
}
