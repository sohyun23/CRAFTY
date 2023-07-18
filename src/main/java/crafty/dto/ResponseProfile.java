package crafty.dto;

import lombok.Data;

@Data
public class ResponseProfile {
	private int memberId;
	private String nickname;
	private String profileImg;
	private String profileIntroduction;
}
