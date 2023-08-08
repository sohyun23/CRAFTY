package crafty.dto;


import lombok.Getter;

@Getter
public class CustomException extends RuntimeException {

	private ErrorCode errorCode;
	
	public CustomException(String msg, ErrorCode errorCode) {
		super(msg);
		this.errorCode = errorCode;
	}
	
	
}
