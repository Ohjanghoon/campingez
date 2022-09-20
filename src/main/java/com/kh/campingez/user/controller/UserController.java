package com.kh.campingez.user.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.campingez.alarm.model.dto.Alarm;
import com.kh.campingez.alarm.model.service.AlarmService;
import com.kh.campingez.user.model.dto.User;
import com.kh.campingez.user.model.service.UserService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/user")
@Slf4j
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	private AlarmService alarmService;

	@GetMapping("/userEnroll.do")
	public String userEnroll() {
		return "user/userEnroll";
	}

	@PostMapping("/userEnroll.do")
	public String userEnroll(User user, RedirectAttributes redirectAttr) {
		try {
			log.debug("user = {}", user);

			// 비밀번호 암호화
			String rawPassword = user.getPassword();
			log.debug("rawPassword = {}", rawPassword);
			String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
			log.debug("encodedPassword = {}", encodedPassword);
			user.setPassword(encodedPassword);

			int result = userService.insertUser(user);

			// 권한 부여
			int addAuthority = userService.insertAuthority(user.getUserId());

			redirectAttr.addFlashAttribute("msg", "회원가입 완료!");
			return "redirect:/";
		} catch (Exception e) {
			log.error("회원 등룍 오류 : " + e.getMessage(), e);
			throw e;
		}
	}

	@GetMapping("/userLogout.do")
	public String userLogout(SessionStatus sessionStatus) {

		if (!sessionStatus.isComplete()) {
			sessionStatus.setComplete();
		}

		return "redirect:/";
	}

	@GetMapping("/userTest.do")
	public String userTest() {
		return "user/userTest";
	}

	@GetMapping("/userIdCheck.do")
	public ResponseEntity<?> userIdCheck(@RequestParam String userId) {
		// log.debug("userId = {}", userId);

		int result = userService.checkId(userId);
		// log.debug("result = {}", result);

		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(result);

	};

	@GetMapping("/userLogin.do")
	public void userLogin() {

	}

//	@PostMapping("/userLoginSuccess.do")
//	public String userLoginSuccess(HttpSession session) {
//		log.debug("userLoginSuccess 호출!");
//		
//		//로그인 후 처리
//		String location = "/";
//		
//		// security가 관리하는 다음 리다이렉트 url
//		SavedRequest savedRequest = (SavedRequest) session.getAttribute("SPRING_SECURITY_SAVED_REQUEST");
//		if(savedRequest != null) {
//			location = savedRequest.getRedirectUrl();
//		}
//		log.debug("location = {}", location);
//		
//		return "redirect:" + location;
//	}

	@GetMapping("/userFindId.do")
	public ResponseEntity<?> userFindId(@RequestParam String name, @RequestParam String phone) {
		log.debug("email = {}", name);
		log.debug("phone = {}", phone);

		User result = userService.findUserId(name, phone);
		log.debug("result = {}", result);

		if (result == null) {
			int fail = 0;
			log.debug("fail = {}", fail);
			return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(fail);
//			return null;
		}

		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(result);
	};

	@GetMapping("/userFindPassword.do")
	public void userFindPassword() {

	}

	@PostMapping("/userFindPassword.do")
	public ResponseEntity<?> userFindPassword(@RequestParam String userId, @RequestParam String phone,
			@RequestParam String email) {
		log.debug("email = {}", userId);
		log.debug("phone = {}", phone);
		log.debug("phone = {}", email);

		User result = userService.findUserPassword(userId, phone, email);
		log.debug("result = {}", result);

		if (result == null) {
			int fail = 0;
			log.debug("fail = {}", fail);
			return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(fail);
//			return null;
		}

		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(result);
	};

	@GetMapping("/userPasswordUpdate.do")
	public void userPasswordUpdate(@RequestParam String userId, Model model) {
		log.debug("userId@get = {}", userId);
		model.addAttribute("userId", userId);
	}

	@PostMapping("/userPasswordUpdate.do")
	public String userPasswordUpdate(@RequestParam String newPassword, @RequestParam String _userId,
			RedirectAttributes redirectAttr) {
		log.debug("newPassword = {}", newPassword);
		log.debug("userId = {}", _userId.split(","));
//		log.debug("userId = {}", userId); //honggd,honggd 이렇게나오는데 얘 왜이럼
		String userId = _userId.split(",")[0];
		log.debug("userId@array = {}", userId);

		String encodedPassword = bcryptPasswordEncoder.encode(newPassword);
		log.debug("encodedPassword = {}", encodedPassword);

		int result = userService.updatePassword(encodedPassword, userId);

		redirectAttr.addFlashAttribute("msg", "비밀번호가 변경되었습니다..");
		return "redirect:/user/userLogin.do";
	};

	@GetMapping("/userEmailCheck.do")
	public ResponseEntity<?> userEamilCheck(@RequestParam String email) {
		log.debug("email = {}", email);

		// 인증번호 생성(6자리 난수)
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;

//		String setFrom = "kei01105@naver.com";
//        String toMail = email;
//        String title = "회원가입 인증 이메일 입니다.";
//        String content = 
//                "홈페이지를 방문해주셔서 감사합니다." +
//                "<br><br>" + 
//                "인증 번호는 " + checkNum + "입니다." + 
//                "<br>" + 
//                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
//        
//        try {
//            
//            MimeMessage message = mailSender.createMimeMessage();
//            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
//            helper.setFrom(setFrom);
//            helper.setTo(toMail);
//            helper.setSubject(title);
//            helper.setText(content,true);
//            mailSender.send(message);
//            
//        }catch(Exception e) {
//            e.printStackTrace();
//        }

		String num = Integer.toString(checkNum);

		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(num);
	}

	@GetMapping("/alarmList.do")
	public ResponseEntity<?> alarmList(@RequestParam String userId) {
		List<Alarm> alarmList = alarmService.getAlarmListByUser(userId);
		int notReadCount = alarmService.getNotReadCount(userId);
		Map<String, Object> param = new HashMap<>();
		param.put("alarmList", alarmList);
		param.put("notReadCount", notReadCount);

		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(param);
	}

	@PostMapping("/updateAlarm.do")
	public ResponseEntity<?> updateAlarm(@RequestParam int alrId) {
		int result = alarmService.updateAlarm(alrId);
		return ResponseEntity.ok().body(result);
	}

	@GetMapping("/getNotReadAlarm.do")
	public ResponseEntity<?> getNotReadAlarm(@RequestParam String userId) {
		int notReadCount = alarmService.getNotReadCount(userId);
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
				.body(notReadCount);
	}
	
	@PostMapping("/insertReport.do")
	public String insertReport(@RequestParam String reportType, @RequestParam String reportContent, @RequestParam String commNo, @RequestParam String userId, HttpServletRequest request, RedirectAttributes redirectAttr) {
		log.debug("userId = {}", userId);
		
		Map<String, Object> param = new HashMap<>();
		param.put("reportType", reportType);
		param.put("reportContent", reportContent);
		param.put("commNo", commNo);
		param.put("userId", userId);
		
		int result = userService.insertReport(param);
		redirectAttr.addFlashAttribute("msg", "신고가 접수되었습니다.");
		
		return "redirect:" + request.getHeader("Referer");
	}
}
