package crafty.pagination.dto;


import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor
@Data
public class MainCard {
	private int goodsId;
	private String goodsName;
	private String introduction;
	private String imgPath;
	private String imgName;
	private String category;
	private int total;
	private int targetAmount;
	private int likeId;
	private int alarmId;
}
