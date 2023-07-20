package crafty.controller;
 
import java.sql.SQLException;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import crafty.service.GoodsService;
import crafty.service.LikesService;
import crafty.service.NondisclosureRequestService;
import crafty.service.OpenAlarmService;

@RestController
public class CraftyAlarmController {
    
    @Autowired
    GoodsService goodsService;
    
    @Autowired
    LikesService likesService;
    
    @Autowired
    NondisclosureRequestService nondisclosureRequestService;
    
    @Autowired
    OpenAlarmService openAlarmService;

    // 알람 설정 메서드
    @GetMapping("goods/alarm/{goodsId}")
    public String alarm(HttpSession session, @PathVariable("goodsId") int goodsId) throws Exception {
        int memberId = (int) session.getAttribute("memberId");
        
        HashMap<String, Object> hashmap = new HashMap<>();
        hashmap.put("goodsId", goodsId);
        hashmap.put("memberId", memberId);
        
        int result = openAlarmService.insertAlarmByGoodsIdAndMemberId(hashmap);
        
        if(result == 0) {
            throw new Exception("다시 시도해주세요.");
        }
        
        return "좋아요 성공";
    }
    
    // 알람 취소 메서드
    @GetMapping("goods/unalarm/{alarmId}")
    public String unalarm(@PathVariable("alarmId") int alarmId) throws Exception {
        int result = openAlarmService.deleteAlarmByAlarmId(alarmId);
        
        if(result == 0) {
            throw new Exception("다시 시도해주세요.");
        }
        
        return "알림 신청 취소 성공";
    }
    
    @ExceptionHandler(value = {Exception.class})
    public ResponseEntity<String> handleException(Exception e){
        return new ResponseEntity<String>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
    }
}