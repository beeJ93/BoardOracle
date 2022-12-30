package com.vam.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.vam.model.BoardVO;
import com.vam.model.Criteria;
import com.vam.model.PageMakerDTO;
import com.vam.service.BoardService;

//해당 클래스를 스프링의 빈으로 인식
@Controller
///board'로 시작하는 모든 처리를 BoardController.java 가 하도록 지정
@RequestMapping("/board/*")
public class BoardController {
	private static final Logger log = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	private BoardService bservice;
	
	@GetMapping("/list")
	public void boardListGET(Model model, Criteria cri) {
		log.info("게시판 목록 페이지 진입");
		model.addAttribute("list", bservice.getListPaging(cri));
		int total = bservice.getTotal();
		PageMakerDTO pageMake = new PageMakerDTO(cri, total);
		System.out.println("cri : " + cri);
		System.out.println("total : " + total);
		model.addAttribute("pageMaker", pageMake);
	}
	
	@GetMapping("/enroll")
	public void boardEnrollGET() {
		log.info("게시판 등록 페이지 진입");
	}
	
	/* 게시판 등록 */
	@PostMapping("/enroll")
	public String boardEnrollPOST(BoardVO board, RedirectAttributes rttr) {
		log.info("BoardVO : " + board);
		bservice.enroll(board);
		rttr.addFlashAttribute("result", "enroll success");
		return "redirect:/board/list";
	}
	
	/* 게시판 조회 */
	@GetMapping("/get")
	public void boardGetPageGET(int bno, Model model, Criteria cri) {
		model.addAttribute("pageInfo", bservice.getPage(bno));
		model.addAttribute("cri", cri);
	}
	
	/* 수정 페이지 이동 */
	@GetMapping("/modify")
	public void boardModifyGET(int bno, Model model) {
		model.addAttribute("pageInfo", bservice.getPage(bno));
	}
	
	@PostMapping("/modify")
	public String boardModifyPOST(BoardVO board, RedirectAttributes rttr) {
		bservice.modify(board);
		rttr.addFlashAttribute("result", "modify success");
		return "redirect:/board/list";
	}
	
	/* 페이지 삭제 */
	@PostMapping("/delete")
	public String boardDeletePOST(int bno, RedirectAttributes rttr) {
		bservice.delete(bno);
		rttr.addFlashAttribute("result", "delete success");
		return "redirect:/board/list";
	}
}
