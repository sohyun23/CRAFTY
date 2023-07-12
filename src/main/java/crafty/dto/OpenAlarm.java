package crafty.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class OpenAlarm {
	private int		alarmId;
	private int		memberId;
	private int		goodsId;
	private Date	sendDate;
}
