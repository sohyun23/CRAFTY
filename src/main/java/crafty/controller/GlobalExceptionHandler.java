package crafty.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.ModelAndView;

import crafty.dto.CustomException;
import crafty.dto.ErrorCode;
import crafty.dto.ErrorResponse;
import lombok.extern.slf4j.Slf4j;

//@Slf4j
//@ControllerAdvice
//public class GlobalExceptionHandler {
//	
////	@ExceptionHandler(CustomException.class)
//	public ModelAndView handleCustomException(CustomException cx
////										Model model
//			){
//		System.out.println("---");
//		ErrorCode errorCode = cx.getErrorCode();
//		String errorMsg = errorCode.getMsg();
////		ErrorResponse response = new ErrorResponse(cx.getErrorCode());
//        ModelAndView mv = new ModelAndView("/error");
//        mv.addObject("errorCode", errorCode);
//        mv.addObject("errorMsg", errorMsg);
//        return mv;
////	    ErrorCode errorCode = cx.getErrorCode();
////	    System.out.println(errorCode);
////        String errorMsg = errorCode.getMsg();
////
////        model.addAttribute("errorCode", errorCode);
////        model.addAttribute("errorMsg", errorMsg);
////
////        log.error("CustomException occurred: ", errorMsg);
////        v;
////        return "redirect:/error";
//    }
//	
//	
//	 @ExceptionHandler(Exception.class)
//    public ResponseEntity<ErrorResponse> handleException(Exception ex){
//        log.error("handleException",ex);
//        ErrorResponse response = new ErrorResponse(ErrorCode.INTERNAL_SERVER_ERROR);
//        return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
//    }
//}
