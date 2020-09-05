package board.mapper;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface BoardMapper {
	HashMap<String, Object> getTest(HashMap<String, Object> param);
	
	public int checkLogin(String userId);
	
	public int insertUser(HashMap<String, Object> param);
	
	public HashMap<String, Object> loginUser(HashMap<String, Object> param);
	
	public int getCntBoardList();
	
	public List<HashMap<String, Object>> getBoardList();
	
	public HashMap<String, Object> getBoard(int no);
	
	public int insertBoard(HashMap<String, Object> boardInfo);
	
	public int updateBoard(HashMap<String, Object> boardInfo);
	
	public int deleteBoard(int no);
	
	
}
