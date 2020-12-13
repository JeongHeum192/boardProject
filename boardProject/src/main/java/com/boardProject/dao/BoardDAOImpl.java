package com.boardProject.dao;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.boardProject.domain.BoardVO;

@Repository
public class BoardDAOImpl implements BoardDAO {
	@Autowired
	private SqlSession sql;
	
	private static String namespace = "com.boardProject.mappers.board";
	
	//게시물 목록
	@Override
	public List<BoardVO> list() throws Exception {
		return sql.selectList(namespace + ".list");
	}

	//게시물 작성
	@Override
	public void write(BoardVO board) throws Exception {
		sql.insert(namespace + ".write", board);
	}
	
	//게시물 조회
	@Override
	public BoardVO content(int bNo) throws Exception {
		return sql.selectOne(namespace + ".content", bNo);
	}

	//게시물 수정
	@Override
	public void modify(BoardVO board) throws Exception {
		//board.setUpdDate(Timestamp.valueOf(LocalDateTime.now()));
		sql.update(namespace + ".modify", board);
	}

	//게시물 삭제
	@Override
	public void delete(int bNo) throws Exception {
		sql.delete(namespace + ".delete", bNo);
	}

	//게시물 총 갯수
	@Override
	public int count() throws Exception {
		return sql.selectOne(namespace + ".count");
	}
	
	// 게시물 목록 + 페이징
	@Override
	public List<BoardVO> listPage(int displayPost, int postNum) throws Exception {
	 HashMap data = new HashMap();
	  
	 data.put("displayPost", displayPost);
	 data.put("postNum", postNum);
	  
	 return sql.selectList(namespace + ".listPage", data);
	}
}
