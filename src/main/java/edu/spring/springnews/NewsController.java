package edu.spring.springnews;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dao.NewsDAO;
import vo.NewsVO;

@Controller
public class NewsController {
	@Autowired
	NewsDAO dao;
	
	@RequestMapping(value = "/news", method=RequestMethod.GET)
	public ModelAndView doGet(String action, String newsid,String writer,String key, String searchType) {
		ModelAndView mav = new ModelAndView();
		
		if(action!= null) {
			if(action.equals("read")) {
				mav.addObject("listone", dao.listOne(Integer.valueOf(newsid)));
			}
			else if(action.equals("delete")) {
				boolean result=dao.delete(Integer.valueOf(newsid));
				if(result) {
					mav.addObject("msg", "성공적으로 삭제되었습니다.");
				}else {
					mav.addObject("msg", "삭제 실패 했습니다.");					
				}
			}
			else if(action.equals("search")) {
				mav.addObject("list", dao.search(key, searchType));
				mav.setViewName("news");
				return mav;
			}
			else if(action.equals("listwriter")) {
				mav.addObject("list", dao.listWriter(writer));
				mav.setViewName("news");
				return mav;
			}
		}
		mav.addObject("list", dao.listAll());
		mav.setViewName("news");
		return mav;
	}
	
	@RequestMapping(value="/news", method= RequestMethod.POST)
	public ModelAndView doPost(NewsVO vo,String action,String id) {
		ModelAndView mav = new ModelAndView();
		
		if(action.equals("insert")) {
			boolean result=dao.insert(vo);
			if(result) {
				mav.addObject("msg", "등록되었습니다.");
			}
			else {
				mav.addObject("mag", "등록에 실패하였습니다.");
			}
		}
		else if(action.equals("update")) {
			boolean result = dao.update(vo);
			if(result) {
				mav.addObject("msg", "업데이트 되었습니다.");
			}
			else {
				mav.addObject("msg", "업데이트 실패하였습니다.");
			}
		}
		mav.addObject("list", dao.listAll());
		mav.setViewName("news");
		return mav;
	}
}
