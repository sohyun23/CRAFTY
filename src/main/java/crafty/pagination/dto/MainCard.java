package crafty.pagination.dto;

import lombok.Builder;
import lombok.Data;

@Data
public class MainCard {
	private String cardImgPath;
	private String cardInfo;
	
	@Builder
	public MainCard(String cardImgPath, String cardInfo) {
		super();
		this.cardImgPath = cardImgPath;
		this.cardInfo = cardInfo;
	}
}
