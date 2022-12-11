package together.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import together.model.SampleDTO;
import together.service.SampleService;

/*
 * 테스트용 샘플 컨트롤러, 이 페이지를 참고하셔서 각자 Controller 클래스를 만드시면 됩니다
 */
@Controller
public class SampleController {
	
	@Autowired
	private SampleService sampleService;
	
	private static final Logger logger = LoggerFactory.getLogger(SampleController.class);
	
	@RequestMapping(value = "/test1.do", method = RequestMethod.GET)
	public String home1(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "togetherview/home";
	}
	@RequestMapping(value = "/test2.do", method = RequestMethod.GET)
	public String home2(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "togetherview/home";
	}
	@RequestMapping(value="/testselect.do", method = RequestMethod.GET)
	public String testselect(Model model) {
		System.out.println("Controller arrived");
		SampleDTO resultDto = sampleService.testselect("1234");
		System.out.println("Controller 로 돌아옴");
		// System.out.println(resultDto.getMember_mobile2()); // NULL 오류
		model.addAttribute("sampledto", resultDto);
		
		return "togetherview/sample";
		
	}
	
}
