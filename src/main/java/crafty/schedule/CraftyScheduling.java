package crafty.schedule;

import java.time.LocalTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import crafty.dto.MemberEmailInfo;
import crafty.mapper.GoodsMapper;
import crafty.mapper.MemberMapper;

@Service
public class CraftyScheduling {
	
	private final JavaMailSender javaMailSender;
	
	@Autowired
	GoodsMapper goodsMapper;
	
	@Autowired
	MemberMapper memberMapper;
	
    @Autowired
    public CraftyScheduling(JavaMailSender javaMailSender) {
        this.javaMailSender = javaMailSender;
    }
    
//    @Scheduled(cron = "0/5 * * * * *", zone = "Asia/Seoul")
//    public void scheduleTest() {
//    	System.out.println(LocalTime.now());
//    }
	
	// 매일 정각, 오픈 예정 굿즈의 상태를 진행중으로 변경
	@Scheduled(cron = "0 0 0 * * *", zone = "Asia/Seoul")
	public void updateGoodsStatusToInProgress() throws Exception {
		goodsMapper.updateGoodsStatusToInProgress();
	}
	
	// 매일 정각, 목표 금액에 도달하지 못한 진행중인 굿즈의 상태를 종료로 변경
	@Scheduled(cron = "0 0 0 * * *", zone = "Asia/Seoul")
	public void updateGoodsStatusToInCompletedAndFailure() throws Exception {
		goodsMapper.updateGoodsStatusToInCompletedAndFailure();
	}
	
	// 매일 정각, 목표 금액에 도달한 진행중인 굿즈의 상태를 종료로 변경
	@Scheduled(cron = "0 0 0 * * *", zone = "Asia/Seoul")
	public void updateGoodsStatusToInCompletedAndSuccess() throws Exception {
		goodsMapper.updateGoodsStatusToInCompletedAndSuccess();
	}
	
	// 매일 정각, 알림신청한 유저들에게 메일 발송
	@Scheduled(cron = "0 0 0 * * *", zone = "Asia/Seoul")
	public void sendEmailToAlarmedMembers() throws Exception {
		// 알림 보내야 할 멤버의 이메일과 굿즈 이름 List 가져오기
		List<MemberEmailInfo> memberList = memberMapper.getAlarmedMemberEmail();
		
		// for문으로 메일 보내기
		for(MemberEmailInfo member : memberList) {
			String to = member.getEmail();
			String subject = "[CRAFTY]" + member.getNickname() + "님이 알림 신청하신 굿즈가 내일 자정에 오픈됩니다!";
			String text = member.getNickname() + "님!\n"
	                    + "알림 신청하신 굿즈" + member.getGoodsName() + "가 내일 자정에 오픈됩니다!\n"
	                    + "기회를 놓치지 마세요!\n";
			
			SimpleMailMessage message = new SimpleMailMessage();
	        message.setTo(to);
	        message.setSubject(subject);
	        message.setText(text);
	        javaMailSender.send(message);
		}
		
		
	}
}
