package crafty.pagination.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor
@Data
public class PageProperties {
    private String category;
    private int ongoing;
    private int order;
}
