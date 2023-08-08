package crafty.dto;

import java.sql.Date;
import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.persistence.Id;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member {
	@Id
	private int		memberId;
	private String	name;
	private String	nickname;
	private String	loginId;
	private String	loginPw;
	private String	phoneNum;
	private String	zoneCode;
	private String	roadAddress;
	private String	detailAddress;
	private String	profileImg;
	private String	profileIntroduction;
	private	String	email;
	private	Date	birth;
	private String	gender;
	private Timestamp	lastLoginDate;
	private	int		position;
	private	Date	memberCreatedAt;
	private	Date	memberUpdatedAt;

}
