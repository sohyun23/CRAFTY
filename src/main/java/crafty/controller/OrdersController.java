package crafty.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class OrdersController {
	
	@PostMapping("/register/delivery/info")
	public String registerDeliveryInfo() {
		
		return "registeredGoodsDetail";
	}
}
