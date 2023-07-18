package crafty.dto;

import java.util.Arrays;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor
@Data
public class MainCategoryList {
	private List<String> categoryList;
	
	public MainCategoryList() {
		String[] array = {"전체", "푸드" ,"잡화" ,"뷰티" ,"유아" ,"반려동물"};		
		this.categoryList = Arrays.asList(array);	
	}
}
