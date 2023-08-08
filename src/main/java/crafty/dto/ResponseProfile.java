package crafty.dto;

import lombok.Data;

@Data
public class ResponseProfile {
	private int memberId;
	private String profileImg;
	private String nickname;
	private String profileIntroduction;
	private String email;
	private String zoneCode;
	private String roadAddress;
	private String detailAddress;
}
