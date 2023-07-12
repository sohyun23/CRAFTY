package crafty.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class NondisclosureRequest {
	private int		nondisclosureReqId;
	private int		goodsId;
	private String	nondisclosureReason;
	private Date	nondisclosureCreatedAt;
	private	Date	nondisclosureUpdatedAt;
}
