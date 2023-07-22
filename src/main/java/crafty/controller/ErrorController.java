package crafty.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import crafty.dto.ErrorCode;
import crafty.dto.ErrorResponse;

@Controller
public class ErrorController {
	
	@GetMapping("/error/{errorCode}")
	public String errorPage(@PathVariable("errorCode") String errorCode,
							Model model) {
		
		System.out.println(errorCode);
		String errorMsg = ErrorCode.getMessageByCode(errorCode);
		model.addAttribute("errorMsg", errorMsg);
		
		return "error";
	}
}
