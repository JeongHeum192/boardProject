package com.boardProject.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.boardProject.domain.BoardReplyVO;
import com.boardProject.domain.BoardVO;
import com.boardProject.service.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	@Autowired
	BoardService service;
	
	 @RequestMapping(value = "/list", method = RequestMethod.GET)
	 public void getList(Model model, @RequestParam("num") int num) throws Exception {
		 //게시물 총 갯수
		 int count = service.count();		 
		 //한 페이지에 출력될 게시물 개수
		 int postNum = 10;
		// 하단 페이징 번호 ([ 게시물 총 갯수 ÷ 한 페이지에 출력할 갯수 ]의 올림)
		 int pageNum = (int)Math.ceil((double)count/postNum);
		 // 출력할 게시물
		 int displayPost = (num - 1) * postNum;
		 
		// 한번에 표시할 페이징 번호의 갯수
		 int pageNum_cnt = 10;
		 // 표시되는 페이지 번호 중 마지막 번호
		 int endPageNum = (int)(Math.ceil((double)num / (double)pageNum_cnt) * pageNum_cnt);
		 // 표시되는 페이지 번호 중 첫번째 번호
		 int startPageNum = endPageNum - (pageNum_cnt - 1);
		 
		// 마지막 번호 재계산
		 int endPageNum_tmp = (int)(Math.ceil((double)count / (double)pageNum_cnt));
		  
		 if(endPageNum > endPageNum_tmp) {
		  endPageNum = endPageNum_tmp;
		 }
		 
		 boolean prev = startPageNum == 1 ? false : true;
		 boolean next = endPageNum * pageNum_cnt >= count ? false : true;
		 
		 
		 List<BoardVO> boardList = service.listPage(displayPost, postNum);
		 model.addAttribute("list", boardList);
		 model.addAttribute("pageNum", pageNum);
		// 시작 및 끝 번호
		 model.addAttribute("startPageNum", startPageNum);
		 model.addAttribute("endPageNum", endPageNum);
		 // 이전 및 다음 
		 model.addAttribute("prev", prev);
		 model.addAttribute("next", next);
		 
		// 현재 페이지
		 model.addAttribute("select", num);
	 }
	 
	 @RequestMapping(value = "/write", method = RequestMethod.GET)
	 public void WriteForm() throws Exception {
		 
	 }
	 
	 @RequestMapping(value = "/write", method = RequestMethod.POST)
	 public String writeInsert(@ModelAttribute BoardVO board, HttpServletRequest request) throws Exception {
		 if(!(board.getPhotofile().getOriginalFilename().equals(""))) {
			 //photo: 멀티파트:콘솔에 찍히게 
			 System.out.println("이미지명: "+ board.getPhotofile().getOriginalFilename());
			 
			 //톰캣서버의 경로를 구해야 프로젝트 경로를 구할수있다 
			 //web-inf/save경로 
			 String path=request.getSession().getServletContext().getRealPath("/WEB-INF/save"); 
			 
			 FileOutputStream fos = null;
	
			 try { 
				 fos=new FileOutputStream(path + "\\" + board.getPhotofile().getOriginalFilename()); 
				 byte []uploadData =board.getPhotofile().getBytes(); fos.write(uploadData); 
			 } 
			 catch (FileNotFoundException e) { 
				 e.printStackTrace(); 
			 } 
			 catch (IOException e) { 
				 e.printStackTrace(); 
			 }
			 finally { 
				 try { 
					 fos.close(); 
				 } 
				 catch (IOException e) { 
					 e.printStackTrace(); 
			     } 
			 }
		 
			 board.setPhoto(board.getPhotofile().getOriginalFilename());
		 }
		 service.write(board);
		 
		 return "redirect:/board/list?num=1";
	 }
	 
	 @RequestMapping(value= "/content", method = RequestMethod.GET) 
	 public void content(@RequestParam("bNo") int bNo, Model model) throws Exception{
		 Integer.toString(bNo);
		 BoardVO content  = service.content(bNo);
		 
		 List<BoardReplyVO> replyList = service.selectBoardReplyList(bNo);
		 model.addAttribute("replylist", replyList);
		 model.addAttribute("content", content);
	 }
	 
	 @RequestMapping(value= "/modify", method = RequestMethod.POST) 
	 public String modify(@ModelAttribute BoardVO board) throws Exception{
		 service.modify(board);
		 
		 return "redirect:/board/list?num=1";
	 }
	 
	 @RequestMapping(value= "/delete", method = RequestMethod.POST) 
	 public String delete(@RequestParam("bNo") int bNo, HttpServletRequest request) throws Exception{
		 BoardVO boardInfo  = service.content(bNo);

/*		 //파일 경로에서 사진 삭제
		 String fileName = boardInfo.getPhoto();
		 String path=request.getSession().getServletContext().getRealPath("/WEB-INF/save"); 
		 
		 File file = new File(path + "\\" + fileName); 
		 if(file.exists()) { 
			 file.delete();
		 }*/
		 
		 BoardVO board = new BoardVO();
		 board.setbNo(bNo);
		 
		 service.delete(board);
		 
		 return "redirect:/board/list?num=1";
	 }
	
	 @RequestMapping(value= "/insertReply", method = RequestMethod.POST) 
	 public String insertReply(Model model, @ModelAttribute BoardReplyVO boardReply) throws Exception{
		 int bNo = Integer.parseInt((boardReply.getbNo()));
	
		 service.insertBoardReply(boardReply);
	 
		 BoardVO content  = service.content(bNo);
		 model.addAttribute("content", content);
		 
		 return "redirect:/board/content?bNo=" + boardReply.getbNo();
	 }
	 
	 @RequestMapping(value= "/deleteReply", method = RequestMethod.POST) 
	 public String deleteReply(Model model, @ModelAttribute BoardReplyVO boardReply) throws Exception{
		 int bNo = Integer.parseInt((boardReply.getbNo()));
		 
		 if(!service.deleteBoardReply(boardReply)) {
			 return "";
		 }
		 
		 BoardVO content  = service.content(bNo);
		 model.addAttribute("content", content);
		 
		 return "redirect:/board/content?bNo=" + boardReply.getbNo();
	 }
}
