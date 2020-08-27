package board.service;

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
}
