package kr.co.khw.portfolio.notice;

import java.io.File;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

import util.ApiCall;

@Controller
public class NoticeController {

	// 공지사항 메인페이지
	@GetMapping("portfolio/notice/index.do")
	public String portfolionoticemain(ResponseVO vo, Model model, @RequestParam Map map) throws Exception {
		
		ApiCall apicall = new ApiCall();
		String url = "http://43.200.76.254:8081/board/index.do";
		if (map.get("pageNum") != null) map.put("pageNum",map.get("pageNum"));
		if (map.get("sword") != null) map.put("sword",map.get("sword"));
		if (map.get("stype") != null) map.put("stype",map.get("stype"));
		
		String result = apicall.ApiCall(url, map, "GET");
		
		ObjectMapper om = new ObjectMapper();
		om.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
			
		//vo = om.readValue(jsonString, new TypeReference<ResponseVO>(){});
		vo = om.readValue(result, ResponseVO.class);
		
		model.addAttribute("list",vo.getList());
		model.addAttribute("totalcount",vo.getTotalCount());
		model.addAttribute("pageNum",vo.getPageNum());
		model.addAttribute("pageRow",vo.getPageRow());
		model.addAttribute("prev",vo.getPrev());
		model.addAttribute("next",vo.getNext());
		model.addAttribute("startPage",vo.getStartPage());
		model.addAttribute("endPage",vo.getEndPage());
		return"/portfolio/notice/index";
	}

	// 공지사항 글작성 페이지
	@GetMapping("portfolio/notice/write.do")
	public String portfolionoticewrite() {
		return "/portfolio/notice/write";
	}

	// 공지사항 글작성 처리 페이지
	@PostMapping("portfolio/notice/writeproc.do")
	public String writeproc(@RequestParam Map map, @RequestParam MultipartFile filename, Model model, HttpServletRequest req) throws Exception {
		//파일이 비어있지않다면
		if(!filename.isEmpty()) {
			//multipartFile 객체 -> file 객체
			File file = new File(filename.getOriginalFilename());
			filename.transferTo(file);
			map.put("filename", file);
		}
		ApiCall apicall = new ApiCall();
		String url = "http://43.200.76.254:8081/board/write.do";
		
		String resultapi = apicall.ApiCall(url, map, "Multipart");
		return "redirect:/portfolio/notice/index.do";
	}
	
	// 공지사항 상세내역
	@GetMapping("portfolio/notice/view.do")
	public String view(@RequestParam Map map, Model model) throws Exception{
		ApiCall apicall = new ApiCall();
		String url = "http://43.200.76.254:8081/board/view.do";
		
		String resultapi = apicall.ApiCall(url, map, "GET");
		System.out.println(resultapi);
		
		ObjectMapper om = new ObjectMapper();
		om.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		NoticeVO vo = new NoticeVO();
		vo = om.readValue(resultapi, NoticeVO.class);
		model.addAttribute("data", vo);
		
		return "portfolio/notice/view";
	}
		
	//공지사항 삭제
	@GetMapping("portfolio/notice/delete.do")
	@ResponseBody
	public int delete(@RequestParam Map map, Model model) throws Exception{
		ApiCall apicall = new ApiCall();
		String url = "http://43.200.76.254:8081/board/delete.do";
		String resultapi = apicall.ApiCall(url, map, "GET");
		ObjectMapper om = new ObjectMapper();
		map = om.readValue(resultapi, Map.class);
		System.out.println("==============="+map.get("result"));
		int result = (int)map.get("result");
		System.out.println("=====result===="+result);
		return result;
	}
	
//공지사항 수정
	@GetMapping("portfolio/notice/edit.do")
		public String edit(@RequestParam Map map, Model model) throws Exception{
		ApiCall apicall = new ApiCall();
		String url = "http://43.200.76.254:8081/board/view.do";
		
		String resultapi = apicall.ApiCall(url, map, "GET");
		System.out.println(resultapi);
		
		ObjectMapper om = new ObjectMapper();
		om.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		NoticeVO vo = new NoticeVO();
		vo = om.readValue(resultapi, NoticeVO.class);
		model.addAttribute("data", vo);
		return "portfolio/notice/edit";
	}
	
//공지사항 수정 처리
	@PostMapping("portfolio/notice/editproc.do")
	public String editproc (@RequestParam Map map, Model model, @RequestParam MultipartFile filename) throws Exception{
		ApiCall apicall = new ApiCall();
		System.out.println(map.keySet());
		System.out.println(map.get("check"));
		String url ="http://43.200.76.254:8081/board/edit.do";
		
		if(!filename.isEmpty()) {
			//multipartFile 객체 -> file 객체
			File file = new File(filename.getOriginalFilename());
			filename.transferTo(file);
			map.put("filename", file);
		}
		
		apicall.ApiCall(url, map, "Multipart");
		return "redirect:/portfolio/notice/index.do";
	}
}

