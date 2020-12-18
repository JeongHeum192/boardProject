package com.boardProject.service;

import java.util.List;

import com.boardProject.domain.BoardReplyVO;
import com.boardProject.domain.BoardVO;

public interface BoardService {
	public List<BoardVO> list() throws Exception;
	public void write(BoardVO board) throws Exception;
	public BoardVO content(int bNo) throws Exception; 
	public void modify(BoardVO board) throws Exception;
	public void delete(BoardVO board) throws Exception;
	
	public int count() throws Exception;
	public List<BoardVO> listPage(int displayPost, int postNum) throws Exception;
	public List<BoardReplyVO> selectBoardReplyList(int bNo) throws Exception;
	public void insertBoardReply(BoardReplyVO boardReply) throws Exception;
	public boolean deleteBoardReply(BoardReplyVO boardReply) throws Exception;
}
