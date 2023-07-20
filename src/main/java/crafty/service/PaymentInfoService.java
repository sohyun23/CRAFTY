package crafty.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import crafty.dto.PaymentInfo;
import crafty.mapper.PaymentInfoMapper;

@Service
public class PaymentInfoService {
	
	@Autowired
	PaymentInfoMapper paymentInfoMapper;

	public int insertPaymentInfo(PaymentInfo payInfo) throws Exception{
		
		int paymentRes = paymentInfoMapper.insertPaymentInfo(payInfo);
		
		return paymentRes;
	}
	
	
}
