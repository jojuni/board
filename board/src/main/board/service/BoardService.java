package board.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import board.mapper.BoardMapper;

@Service
public class BoardService {

	@Autowired
	private BoardMapper mapper;

	public ModelAndView signupPage() throws Exception {

		ModelAndView view = new ModelAndView("/signup");

		return view;
	}

	public HashMap<String, Object> checkLogin(String userId) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int count = 0;

		count = mapper.checkLogin(userId);

		map.put("count", count);
		return map;
	}

	public ModelAndView insertUser(HashMap<String, Object> formData) throws Exception {
		ModelAndView view = new ModelAndView("index");
		int result = 0;

		result = mapper.insertUser(formData);

		if (result > 0) {
			view.setViewName("redirect:/");
		} else {
			view.addObject("result_cd", "err");
		}

		return view;
	}

	public HashMap<String, Object> loginUser(HttpSession session, HashMap<String, Object> loginForm) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();

		HashMap<String, Object> userInfo = mapper.loginUser(loginForm);

		if (userInfo != null) {
			session.setAttribute("userInfo", userInfo);
			map.put("msg", "OK");
		} else {
			map.put("msg", "ERROR");
		}
		return map;
	}

	public ModelAndView mainPage(HttpSession session) throws Exception {

		ModelAndView view = new ModelAndView("/main");
		view.addObject("userInfo", 	session.getAttribute("userInfo"));

		return view;
	}
	
	public List<HashMap<String, Object>> getBoardList() throws Exception {
		List<HashMap<String, Object>> boardList = mapper.getBoardList();
		
		return boardList;
	}
	
	public HashMap<String, Object> getBoard(int no) throws Exception {
		
		HashMap<String, Object> board = mapper.getBoard(no);
		
		return board;
	}
	
	public HashMap<String, Object> insertBoard(HashMap<String, Object> boardInfo) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int result = mapper.insertBoard(boardInfo);
		
		if (result > 0) {
			map.put("msg", "OK" );
		} else {
			map.put("msg", "Error" );
		}
		return map;
	}

	public HashMap<String, Object> updateBoard(HashMap<String, Object> boardInfo) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int result = mapper.updateBoard(boardInfo);
		if (result > 0) {
			map.put("msg", "OK" );
		} else {
			map.put("msg", "Error" );
		}
		return map;
	}
	
	public HashMap<String, Object> deleteBoard(int no) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int result = mapper.deleteBoard(no);
		if (result > 0) {
			map.put("msg", "OK" );
		} else {
			map.put("msg", "Error" );
		}
		return map;
	}

	public ModelAndView writeFormPage(HttpSession session) throws Exception {

		ModelAndView view = new ModelAndView("/writeForm");
		view.addObject("userInfo", 	session.getAttribute("userInfo"));

		return view;
	}
}
