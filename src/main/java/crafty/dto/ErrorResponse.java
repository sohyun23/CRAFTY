package crafty.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
@AllArgsConstructor
public class ErrorResponse {

	private final String code;
    private final String message;
    
    
    public ErrorResponse(ErrorCode errorCode) {
    	super();
    	this.code = errorCode.getCode();
    	this.message = errorCode.getMsg();
    }


}
