package crafty.dto;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
public class GoodsResponse {

	private String	goodsName;
	private String	goodsIntro;
	private String	goodsCategory;
	private Date	startDate;
	private Date	endDate;
	private int		targetAmount;
	private Date	postDate;
	private String	bankCategory;
	private String	bankAccountNumber;
	private String itemList;
	
}
