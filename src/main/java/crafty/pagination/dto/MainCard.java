package crafty.pagination.dto;


import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor
@Data
public class MainCard {
	private int goodsId;
	private String goodsName;
	private int aggrement;
	private String introduction;
	private String imgPath;
	private String imgOriginalName;
	private String category;
}
