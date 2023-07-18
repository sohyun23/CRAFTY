package crafty.pagination.dto;

import lombok.Data;

@Data
public class PageResponseDTO {
	
	// 화면 하단 출력할 페이지 개수(10)
    private int pageCount;
    
    // (화면)시작 페이지 번호, 종료 페이지 번호
    private int startPage, endPage;
    
    // 이전 페이지, 다음 페이지 이동
    private boolean prev, next;
    
    // 전체 개수
    private int total;

    // 마지막 페이지
    private int realEnd;
    
    // 키워드
    private String keyword;
    
    private PageRequestDTO pageRequest;

    public PageResponseDTO(){}

    public PageResponseDTO(int total, int pageCount, PageRequestDTO pageRequest) {
        this.total = total;
        this.pageCount = pageCount;
        this.pageRequest = pageRequest;
        this.keyword = pageRequest.getKeyword();
        
        this.endPage = (int)(Math.ceil(pageRequest.getPageNum() * 1.0 / pageCount)) * pageCount;
        this.startPage = endPage - (pageCount - 1);

        realEnd = (int)(Math.ceil(total * 1.0 / pageRequest.getAmount()));

        if(endPage > realEnd){
        	this.endPage = realEnd;
        }

        this.prev = this.startPage > 1;
        this.next = this.endPage < realEnd;
    }
}