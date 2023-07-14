package crafty.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
//@NoArgsConstructor
public class ItemResponse {

	private String	itemName;
	private int	itemPrice;
	private String	itemComposition;
	private int	itemQuantity;
	
}
