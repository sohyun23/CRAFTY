package crafty.mapper;

import org.apache.ibatis.annotations.Mapper;

import crafty.dto.PaymentInfo;

@Mapper
public interface PaymentInfoMapper {

	int insertPaymentInfo(PaymentInfo payInfo) throws Exception;
	
}
