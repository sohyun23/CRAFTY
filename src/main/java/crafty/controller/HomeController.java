package crafty.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	@GetMapping("registerGoods")
	public String main() {
		return "registerGoods";
	}
	
	@GetMapping("/main")
	public String mainPage() {
		return "main";
	}
}
