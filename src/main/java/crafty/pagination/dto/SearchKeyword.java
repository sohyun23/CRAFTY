package crafty.pagination.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SearchKeyword {
	private String keyWord;
	private String dropDownProgress;
	private String dropDownSortBy;
	private String category;
}
