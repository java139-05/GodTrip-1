package kr.co.godtrip.product;

import java.io.File;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping()
public class TransCont {
	public TransCont() {
		System.out.println("------TransCont()객체 생성됨");
	}//end
	
	@Autowired
	TransDAO transDao;
	
	@RequestMapping("/product/transproList")
	public ModelAndView transproList() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("product/transproList");
		mav.addObject("transproList", transDao.transproList());
		return mav;
	}//transproList() end
	
	
	@RequestMapping("/product/transinfoList")
	public ModelAndView transinfoList() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("product/transinfoList");
		mav.addObject("transinfoList", transDao.transinfoList());
		return mav;
	}//transinfoList() end
	
	
	@RequestMapping("/product/transinfoForm")
	public ModelAndView transinfoForm() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("product/transinfoForm");
		return mav;
	}//transinfoForm() end
	
	
	@RequestMapping("/product/transproForm")
	public ModelAndView transproForm(HttpServletRequest req) {
		String trans_code = req.getParameter("trans_code");
		String FT_code = req.getParameter("FT_code");
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("trans_code", trans_code);
		mav.addObject("FT_code", FT_code);
		mav.setViewName("product/transproForm");
		return mav;
	}//transproForm() end
	
	
	@RequestMapping("/product/transinfoInsert")
	public String transinfoInsert(@RequestParam Map<String, Object> map
								 ,@RequestParam MultipartFile img
								 ,HttpServletRequest req) {
		String filename = "-";
		long filesize = 0;
		if(img != null && !img.isEmpty()) {
			filename = img.getOriginalFilename();
			filesize = img.getSize();
			try {
				ServletContext application = req.getSession().getServletContext();
				String path = application.getRealPath("/storage"); //실제 물리적인 경로
				img.transferTo(new File(path + "\\" + filename));  //파일저장
			} catch (Exception e) {
				e.printStackTrace(); //System.out.println(e);
			}//try end
		}//if end
		
		map.put("filename", filename);
		map.put("filesize", filesize);
		
		transDao.transinfoInsert(map);
		
		return "redirect:/product/transinfoList";
		
	}//transinfoInsert() end
	
	
	@RequestMapping("/product/transproInsert")
	public String transproInsert(@RequestParam Map<String, Object> map
								 ,HttpServletRequest req) {
		
		//transpro_code 생성하기
		//1) 비행기상품인 경우 FP, 기차상품인 경우 TP로 시작
		String transproCodePrefix = ""; //transpro_code 접두사
		String FT_code = req.getParameter("FT_code");
		
		if("F".equals(FT_code)) {
			transproCodePrefix = "FP";
		}else if("T".equals(FT_code)) {
			transproCodePrefix = "TP";
		}//if end
		
		//2) 4자리의 랜덤번호 생성
		int n = (int)(Math.random()*10000+1);
		
		//3) 구분코드 + 랜덤번호 하여 transpro_code 생성		
		/*
		1) 첫번째 방법 : 숫자가 1자리수부터 4자리수까지 랜덤으로 생성, 4자리가 아닌 경우 0이 붙지 않음 
		String transpro_code = transproCodePrefix + n;
		*/
		
		/*
		2) 두번째 방법 : 숫자는 4자리수로 나오나 문자가 맨앞 한글자씩만 나옴
		char transproCodePrefixChar1 = transproCodePrefix.charAt(0);
		String transpro_code = String.format("%c%04d", transproCodePrefixChar, n);
		*/
		
		//3) 세번째 방법
		String transpro_code = transproCodePrefix + String.format("%04d", n); 
		
		System.out.println(transpro_code);
		
		///////////////////////////////////////////////////////////////
		
		map.put("transpro_code", transpro_code);
		
		transDao.transproInsert(map);
		
		return "redirect:/product/transproList";
		
	}//transproInsert() end
	
	
	@RequestMapping("/product/transproDelete")
	public String transproDelete(HttpServletRequest req) {
		String transpro_code = req.getParameter("transpro_code");		
		transDao.transproDelete(transpro_code);
		
		return "redirect:/product/transproList";		
	}//transproDelete() end
	
	
	@RequestMapping("/product/transRsvInsert")
	public ModelAndView transRsvInsert(@ModelAttribute TransRsvDTO dto
								 ,HttpServletRequest req
								 ,HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		
		String transpro_code = req.getParameter("transpro_code");		
		String s_id = "kim0602";
		//String s_id = (String) session.getAttribute("s_id");
		//session.getAttribute() 메소드는 Object타입을 반환하기 때문에 (String) 추가
		
		//랜덤으로 좌석번호 지정하기
		final int LETTER_RANGE = 26; //알파벳 갯수
		final int DIGIT_RANGE = 10;  //숫자의 범위 
		Random random = new Random();
		char letter = (char) (random.nextInt(LETTER_RANGE)+'A');
		int number = random.nextInt(DIGIT_RANGE * DIGIT_RANGE);
		
		String transrs_seatno = String.format("%c%02d", letter, number);
		System.out.println(transrs_seatno);
		
			
		dto.setTranspro_code(transpro_code);
		dto.setId(s_id);
		dto.setTransrs_seatno(transrs_seatno);
		
				
		if(transpro_code != null) {
			transDao.transRsvInsert(dto);
		}//if end
		
		mav.setViewName("/hotel/hotelList");
				
		return mav;		
		
	}//transproChoice() end 

	
	 
}//class end
