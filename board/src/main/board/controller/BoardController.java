package board.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import board.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	private BoardService service;

	@RequestMapping(value = "/signup.do")
	public ModelAndView signupPage(HttpServletRequest req, HttpServletResponse res) throws Exception {
		return service.signupPage();
	}

	@RequestMapping(value = "/checkLogin")
	public HashMap<String, Object> checkLogin(HttpServletRequest req, HttpServletResponse res,
			@RequestBody String userId) throws Exception {

		return service.checkLogin(userId);
	}

	@RequestMapping(value = "/signup.do", method = RequestMethod.POST)
	public ModelAndView signup(HttpServletRequest req, HttpServletResponse res,
			@RequestParam HashMap<String, Object> formData) throws Exception {

		return service.insertUser(formData);
	}

	@RequestMapping(value = "/loginUser")
	public HashMap<String, Object> loginUser(HttpSession session, HttpServletRequest req, HttpServletResponse res,
			@RequestBody HashMap<String, Object> loginForm) throws Exception {

		return service.loginUser(session, loginForm);
	}
	
	@RequestMapping(value = "/main.do")
	public ModelAndView mainPage(HttpServletRequest req, HttpServletResponse res) throws Exception {
		return service.mainPage(req.getSession());
	}
	
	@RequestMapping(value = "/getBoardList", method = RequestMethod.POST)
	public HashMap<String, Object> getBoardList(HttpSession session, HttpServletRequest req, HttpServletResponse res) throws Exception {
		HashMap<String, Object> msg = new HashMap<String, Object>();
		if (session.getAttribute("userInfo") != null) {
			msg.put("msg", "OK");
			msg.put("list", service.getBoardList());
		} else {
			msg.put("msg", "not login");
			msg.put("list", null);
		}
		return msg; 
	}
	
	@RequestMapping(value = "/getBoard", method = RequestMethod.POST)
	public HashMap<String, Object> getBoard(HttpSession session, HttpServletRequest req, HttpServletResponse res, @RequestBody int no) throws Exception {
		HashMap<String, Object> msg = new HashMap<String, Object>();
		if (session.getAttribute("userInfo") != null) {
			msg.put("msg", "OK");
			msg.put("info", service.getBoard(no));
		} else {
			msg.put("msg", "not login");
			msg.put("info", null);
		}
		return msg; 
	}
	
	@RequestMapping(value = "/insertBoard")
	public HashMap<String, Object> insertBoard(HttpSession session, HttpServletRequest req, HttpServletResponse res, @RequestBody HashMap<String, Object> boardInfo) throws Exception{
		HashMap<String, Object> msg = new HashMap<String, Object>();
		if (session.getAttribute("userInfo") != null) {
			msg.put("info", service.insertBoard(boardInfo));
			msg.put("msg", "OK");
		} else {
			msg.put("msg", "not login");
			msg.put("info", null);
		}
		return msg; 
	}
	
	@RequestMapping(value = "/updateBoard")
	public HashMap<String, Object> updateBoard(HttpSession session, HttpServletRequest req, HttpServletResponse res, @RequestBody HashMap<String, Object> boardInfo) {
		HashMap<String, Object> msg = new HashMap<String, Object>();
		if (session.getAttribute("userInfo") != null) {
			msg.put("msg", "OK");
			try {
				msg.put("list", service.updateBoard(boardInfo));
			} catch(Exception e) {
				e.printStackTrace();
			}
			
		} else {
			msg.put("msg", "not login");
			msg.put("list", null);
		}
		return msg; 
	}
	
	@RequestMapping(value = "/deleteBoard")
	public HashMap<String, Object> deleteBoard(HttpSession session, HttpServletRequest req, HttpServletResponse res, @RequestBody  int no) throws Exception {
		HashMap<String, Object> msg = new HashMap<String, Object>();
		if (session.getAttribute("userInfo") != null) {
			msg.put("msg", "OK");
			msg.put("list", service.deleteBoard(no));
		} else {
			msg.put("msg", "not login");
			msg.put("list", null);
		}
		return msg; 
	}
 
	@RequestMapping(value = "/writeForm.do")
	public ModelAndView writeForm(HttpServletRequest req, HttpServletResponse res) throws Exception {
		return service.writeFormPage(req.getSession());
	}
	

	@RequestMapping(value = "/logout")
	public  HashMap<String, Object> logout(HttpServletRequest req, HttpServletResponse res) throws Exception {
		HashMap<String, Object> msg = new HashMap<String, Object>();
		HttpSession session = req.getSession();
		if (session.getAttribute("userInfo") != null) {
			session.removeAttribute("userInfo");
			msg.put("msg","OK");
		} else {
			msg.put("msg","error");
		}
		return msg;
	}
	
}
