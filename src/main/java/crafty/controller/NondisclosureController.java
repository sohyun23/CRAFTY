package crafty.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class NondisclosureController {
	
	@PostMapping(value="/request/nondisclosure")
	public String requestNondisclosure() {
		
		return "registeredGoodsDetail";
	}
}
