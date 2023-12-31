package crafty.service;

import java.io.File;
import java.io.FileOutputStream;
import java.nio.file.Files;
import java.sql.Date;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import crafty.dto.CustomException;
import crafty.dto.ErrorCode;
import crafty.dto.GoodsDesciptionImg;
import crafty.mapper.GoodsDescriptionImgMapper;

@Service
public class GoodsDescriptionImgService {

	@Autowired
	GoodsDescriptionImgMapper goodsDescriptionImgMapper;
	

	@Transactional
	public boolean registerGoodsImg(MultipartFile file, GoodsDesciptionImg img, int generatedGoodsId) throws Exception {
		boolean result = false;


		int res = goodsDescriptionImgMapper.registerGoodsImg(img);
		if(res != 0) {
			result = true;
			System.out.println("1");
			System.out.println(img.getImgPath());
			FileOutputStream outputStream = new FileOutputStream(img.getImgPath()+ img.getImgName());
			System.out.println("2");
			FileCopyUtils.copy(file.getInputStream(), outputStream);
			outputStream.close();
		} else {
//			throw new Exception("파일 저장에 실패했습니다");
			throw new CustomException("Error", ErrorCode.FAILED_TO_CREATE_GOODS);
		}
		
		return result;
		
	}
	
	

}
