package crafty.paginatino.dto;

import lombok.Builder;
import lombok.Data;

@Data
public class PageRequestDTO {
	// 현재 페이지 번호
	private int pageNum;
	
	// 페이지당 출력할 데이터 개수
	private int amount;
	
	// 추가
	// 검색 키워드
	private String keyword;
	
	// 초기화
	public PageRequestDTO() {
		this(1, 5);
	}
	
	// 추가
	public PageRequestDTO(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}

	//  키워드 추가 전
//	@Builder
//	public PageRequestDTO(int pageNum, int amount) {
//		this.pageNum = pageNum;
//		this.amount = amount;
//	}
	
	// 키워드 추가 후
	@Builder
	public PageRequestDTO(int pageNum, int amount, String keyword) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.keyword = keyword;
	}
	
}
