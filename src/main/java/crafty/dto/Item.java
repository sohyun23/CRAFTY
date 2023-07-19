package crafty.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@AllArgsConstructor
@Builder
public class Item {
	private int		itemId;
	private int		goodsId;
	private String	itemName;
	private int		itemPrice;
	private String	itemComposition;
	private int		itemQuantity;
	private Date	itemCreatedAt;
	private Date	itemUpdatedAt;
}
