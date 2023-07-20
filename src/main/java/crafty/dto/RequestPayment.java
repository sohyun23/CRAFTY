package crafty.dto;

import lombok.Data;

@Data
public class RequestPayment {
	private String name;
	private String phoneNum;
	private String email;
	private int	orderId; 
}
