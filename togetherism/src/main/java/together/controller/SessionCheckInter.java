package together.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class SessionCheckInter implements HandlerInterceptor {
	
	// DispatcherServlet의 화면 처리가 완료된 상태에서 처리
	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
	}

	// 지정된 컨트롤러의 동작 이후에 처리, Spring MVC의 Front Controller인 DispatcherServlet의 화면 처리가 완료된 상태에서 처리
	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
	}

	// 지정된 컨트롤러의 동작 이전에 가로채는 역할 (세션이 없으면, 로그인 폼으로 이동 하도록 해준다 )
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2) throws Exception {
		HttpSession session = request.getSession();
		System.out.println("인터셉터 도착");
		if (session.getAttribute("email") == null) { // 일반회원 세션이 없으면
			
			// 알림창을 띄워 로그인하라고 알리고
			String path = request.getContextPath();
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			// 로그인 폼으로 이동
			String element = "<script>" + "alert('로그인을 해주세요');" 
			+ "location.href='" + path +"/member_login.do';" + "</script>";
			out.print(element);
			out.flush(); // 브라우저 출력버퍼 비우기
			out.close();

			return false;
		}
		return true;
	}
}