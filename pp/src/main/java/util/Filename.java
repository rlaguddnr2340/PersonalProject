package util;

import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Filename {

	public Map filename(MultipartFile filename,HttpServletRequest req) {
		Map map = new HashMap();
		  if (!filename.isEmpty()) { 
			 String org = filename.getOriginalFilename();
			 String ext = org.substring(org.lastIndexOf(".")); 
			 String real = new Date().getTime() + ext;
		 
		  // 첨부파일 저장처리 
			 String path = req.getRealPath("/upload/"); 
			 try {
				 filename.transferTo(new File(path + real)); 
				 } 
			 catch (Exception e) { }
			 map.put("filename_org",org ); 
			 map.put("filename_real",real ); 
			 }
		return map;
	}
}
