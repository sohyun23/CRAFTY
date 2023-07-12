package crafty.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Item {
	private int		itemId;
	private int		goodsId;
	private String	itemName;
	private int		itemPrice;
	private String	itemConfiguration;
	private int		itemStock;
	private Date	itemCreatedAt;
	private Date	itemUpdatedAt;
}
