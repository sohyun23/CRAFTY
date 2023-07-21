package crafty.dto;

import lombok.Getter;

@Getter
public enum ErrorCode {

	
	NVALID_INPUT_VALUE(400, "COMMON-001", "유효성 검증에 실패했습니다."),
    INTERNAL_SERVER_ERROR(500, "COMMON-002", "서버에서 처리할 수 없는 오류입니다."),

    DUPLICATE_LOGIN(400, "ACCOUNT-001", "입력값이 중복되었습니다."),
    UNAUTHORIZED(401, "ACCOUNT-002", "인증에 실패하였습니다."),
    ACCOUNT_NOT_FOUND(404, "ACCOUNT-003", "해당 계정을 찾을 수 없습니다."),
    ROLE_NOT_EXISTS(403, "ACCOUNT-004", "권한이 존재하지 않습니다."),

    FAILED_TO_CREATE_GOODS(404, "GOODS-001", "굿즈 생성에 실패하였습니다." ),
    FILE_NOT_FOUND(404, "GOODS-002", "파일이 존재 하지 않습니다."),

    LIST_NOT_FOUND(404, "LIST-001", "목록을 불러오기 실패하였습니다."),

    FAILED_TO_NONDISCLOURE_REQUEST(404, "REQUEST-001", "다시 비공개 신청을 시도해 주세요."),
	FAILED_TO_DELIVERY_REQUEST(404, "REQUEST-002", "다시 운송장 번호를 입력해 주세요."),
	FAILED_TO_REGISTRATION_REQUEST(404, "REQUEST-003", "다시 등록 허가를 시도해 주세요.");
	
	private int status;
	private String code;
	private String msg;
	
	private ErrorCode(int status, String code, String msg) {
		this.status = status;
		this.code = code;
		this.msg = msg;
	}
	
	 // 에러 코드에 해당하는 에러 메시지를 반환하는 메서드
    public static String getMessageByCode(String code) {
        for (ErrorCode errorCode : ErrorCode.values()) {
            if (errorCode.getCode().equals(code)) {
                return errorCode.getMsg();
            }
        }
        return "해당하는 에러 코드가 없습니다.";
    }
	
	
}
