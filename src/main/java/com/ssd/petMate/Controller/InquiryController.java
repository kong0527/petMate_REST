package com.ssd.petMate.Controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ssd.petMate.domain.Inquiry;
import com.ssd.petMate.domain.InquiryLike;
import com.ssd.petMate.page.BoardSearch;
import com.ssd.petMate.service.InquiryFacade;
import com.ssd.petMate.service.InquiryLikeFacade;

@RestController
public class InquiryController {
	
	@Autowired
	private InquiryFacade inquiryFacade;
	
	@Autowired
	private InquiryLikeFacade inquiryLikeFacade;
	
	@GetMapping(value = "/inquiry/{boardNum}")
	public ModelAndView inquiryDetail(ModelAndView mv, 
			@PathVariable("boardNum") int boardNum) {
		inquiryFacade.updateViews(boardNum);
		Inquiry inquiry = inquiryFacade.boardDetail(boardNum);
		
		if (inquiry == null) {
			mv.setViewName("mypage/notFound");
		}
		else {
			mv.addObject("inquiry", inquiry);
			mv.setViewName("inquiry/inquiryDetail");
		}
		return mv;
	}
	
	@DeleteMapping(value = "/inquiry/{boardNum}")
	@ResponseBody
	public String inquiryDelete(@PathVariable("boardNum") int boardNum) {
		inquiryFacade.deleteBoard(boardNum);
		return "success";
	}
	
	@GetMapping(value = "/inquiry")
	public ModelAndView inquiryBoard(ModelAndView mv, 
			@RequestParam(required = false, defaultValue = "1") int pageNum,
			@RequestParam(required = false, defaultValue = "10") int contentNum,
			@RequestParam(required = false) String searchType,
			@RequestParam(required = false) String keyword) {
		
		BoardSearch boardSearch = new BoardSearch();
		boardSearch.setSearchType(searchType);
		boardSearch.setKeyword(keyword);
		
//		검색한 결과값을 가져오기 위해 map에 키워드와 검색 타입 저장 후 sql 쿼리에 삽입
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("searchType", searchType);

		int totalCount = inquiryFacade.boardPageCount(map);

//		페이징과 검색 기능이 적용된 후의 리스트를 가지고 옴
		boardSearch.pageInfo(pageNum, contentNum, totalCount);
		List<Inquiry> inquiryList = inquiryFacade.getAllBoard(boardSearch);

		mv.addObject("inquiryList", inquiryList);
		mv.addObject("boardSearch", boardSearch);
		mv.setViewName("inquiry/inquiryList");
		return mv;
	}

//	게시글 추천 기능
	@PostMapping(value="/inquiry-like/{boardNum}")
	@ResponseBody
	public HashMap<String, Integer> inquiryLike(ModelAndView mv, HttpServletRequest request,
			@PathVariable(required = false) int boardNum) {

		String userID = (String) request.getSession().getAttribute("userID");
		Inquiry inquiry = inquiryFacade.boardDetail(boardNum);
		InquiryLike inquiryLike = new InquiryLike(userID, boardNum);

//		이미 사용자가 게시글에 좋아요를 눌렀는지 누르지 않았는지 판별하기 위해 호출
		int count = inquiryLikeFacade.isLike(inquiryLike);
		
//		만약 이전에 좋아요를 누르지 않았을 때
//		게시글의 좋아요 개수가 증가하고, like 테이블에 좋아요를 누른 userID와 게시글의 ID가 삽입됨
		if (count == 0) {
			inquiryLikeFacade.insertLike(inquiryLike);
		}
		else {
			inquiryLikeFacade.deleteLike(inquiryLike);
		}
		
//		좋아요 개수 가지고 오기
		int boardLike = inquiryLikeFacade.countLike(boardNum);
		
//		좋아요 개수 update
		inquiry.setBoardLike(boardLike);
		inquiryFacade.updateLike(inquiry);
		
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("count", count);
		map.put("boardLike", boardLike);
		
		return map;
	}
}
