package crafty.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class DeliveryInfo {
	private String key;
	private String code;
	private String invoice;
}
