package board.mapper;

import java.util.HashMap;

import org.springframework.stereotype.Repository;

@Repository
public interface BoardMapper {
	HashMap<String, Object> getTest(HashMap<String, Object> map);
}
