package com.boardProject.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boardProject.dao.BoardDAO;
import com.boardProject.domain.BoardVO;
	
@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	private BoardDAO dao;
	
	//게시물 목록
	@Override
	public List<BoardVO> list() throws Exception {
		return dao.list();
	}

	//게시물 작성
	@Override
	public void write(BoardVO board) throws Exception {
		dao.write(board);
	}

	//게시물 조회
	@Override
	public BoardVO content(int bNo) throws Exception {
		return dao.content(bNo);
	}

	//게시물 수정	
	@Override
	public void modify(BoardVO board) throws Exception {
		dao.modify(board);
	}

	//게시물 삭제	
	@Override
	public void delete(int bNo) throws Exception {
		dao.delete(bNo);
	}

	//게시물 총 갯수
	@Override
	public int count() throws Exception {
		return dao.count();
	}
	
	// 게시물 목록 + 페이징
	@Override
	public List<BoardVO> listPage(int displayPost, int postNum) throws Exception {
		return dao.listPage(displayPost, postNum);
	}
}
