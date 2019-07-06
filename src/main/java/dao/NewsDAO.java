package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.NewsVO;

@Repository
public class NewsDAO {
	@Autowired
	SqlSession session= null;
	
	public boolean insert(NewsVO vo) {
		boolean result =true;
		String statement = "NewsMapper.insertNews";
		if(session.insert(statement,vo)!=1)
			result=false;
		return result;
	}
	
	public boolean update(NewsVO vo) {
		boolean result =true;
		String statement  ="NewsMapper.updateNews";
		if(session.update(statement,vo)!=1)
			result=false;
		return result;
	}
	
	public boolean delete(int id) {
		boolean result =true;
		String statement ="NewsMapper.deleteNews";
		if(session.delete(statement,id)!=1)
			result =false;
		return result;
	}
	
	public List<NewsVO> listAll(){
		List<NewsVO> list=null;
		String statement="NewsMapper.listAllNews";
		list=session.selectList(statement);
		return list;
	}
	
	public NewsVO listOne(int id) {
		NewsVO vo= null;
		String statement="NewsMapper.listOneNews";
		String c_statement="NewsMapper.updateCount";
		session.update(c_statement,id);
		vo=session.selectOne(statement,id);
		return vo;
	}
	
	public List<NewsVO> listWriter(String writer){
		List<NewsVO> list;
		String statement = "NewsMapper.listWriterNews";
		list = session.selectList(statement, writer);
		return list;
	}
	
	public List<NewsVO> search(String key,String searchType){
		List<NewsVO> list=null;
		String statement = null;
		if (searchType.equals("id"))
			statement = "NewsMapper.searchId";
		else if (searchType.equals("title"))
			statement = "NewsMapper.searchTitle";
		else if (searchType.equals("writer"))
			statement = "NewsMapper.selectNewsWriter";
		list = session.selectList(statement, key);
		return list;

	}
	
	
}
