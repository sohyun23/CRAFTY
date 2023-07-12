package crafty.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Member {
	private int		memberId;
	private String	name;
	private String	nickname;
	private String	LoginId;
	private String	LoginPw;
	private String	phoneNum;
	private String	zoneCode;
	private String	roadAddress;
	private String	detailAddress;
	private String	profileImg;
	private	String	email;
	private	Date	birth;
	private String	gender;
	private Date	lastLoginDate;
	private	int		position;
	private	Date	memberCreatedAt;
	private	Date	memberUpdatedAt;
}
