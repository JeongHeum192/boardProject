package com.boardProject.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.boardProject.domain.BoardReplyVO;
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
		
		int boardNo = sql.selectOne(namespace + ".selectBoardNo");
		board.setbNo(boardNo);
		board.setType(0);

		sql.insert(namespace + ".writeHist", board);
		
		String[] tmp = board.getPhoto().split("\\.");
		board.setPhoto(tmp[0]);
		board.setExtension(tmp[1]);
	
		sql.insert(namespace + ".writeFile", board);
	}
	
	//게시물 조회
	@Override
	public BoardVO content(int bNo) throws Exception {
		return sql.selectOne(namespace + ".content", bNo);
	}

	//게시물 수정
	@Override
	public void modify(BoardVO board) throws Exception {
		sql.update(namespace + ".modify", board);
		
		BoardVO boardInfo = sql.selectOne(namespace + ".content", board.getbNo());
		boardInfo.setType(1);
		sql.insert(namespace + ".modifyHist", boardInfo);
	}

	//게시물 삭제
	@Override
	public void delete(BoardVO board) throws Exception {
		BoardVO boardInfo = sql.selectOne(namespace + ".content", board.getbNo());
		boardInfo.setType(2);
		
		sql.delete(namespace + ".delete", board);
		sql.insert(namespace + ".modifyHist", boardInfo);
		
		BoardReplyVO replyInfo = new BoardReplyVO();
		String bNo = Integer.toString(board.getbNo());
		replyInfo.setbNo(bNo);
		replyInfo.setType(2);
		
		sql.insert(namespace + ".modifyBoardReplyHistALL", replyInfo);
	}

	//게시물 총 갯수
	@Override
	public int count() throws Exception {
		return sql.selectOne(namespace + ".count");
	}
	
	//게시물 목록 + 페이징
	@Override
	public List<BoardVO> listPage(int displayPost, int postNum) throws Exception {
	 HashMap data = new HashMap();
	  
	 data.put("displayPost", displayPost);
	 data.put("postNum", postNum);
	  
	 return sql.selectList(namespace + ".listPage", data);
	}
	
	//게시물 댓글 목록
	@Override
	public List<BoardReplyVO> selectBoardReplyList(int bNo) throws Exception{
		return sql.selectList(namespace + ".selectBoardReplyList", bNo);
	}

	//게시물 댓글 작성
	@Override
	public void insertBoardReply(BoardReplyVO boardReply) throws Exception {
		if (boardReply.getReNo() == null || "".equals(boardReply.getReNo())) {
			if (boardReply.getReParent() != null) {
				BoardReplyVO replyInfo = sql.selectOne(namespace +  ".selectBoardReplyParent", boardReply.getReParent());
				boardReply.setReDepth(replyInfo.getReDepth());
				boardReply.setReOrder(replyInfo.getReOrder() + 1);
				sql.selectOne(namespace + ".updateBoardReplyOrder", boardReply);
			}
			else {
				int reorder = sql.selectOne(namespace + ".selectBoardReplyMaxOrder", boardReply.getbNo());
				boardReply.setReOrder(reorder);
			}
			
			boardReply.setType(0);
			sql.insert(namespace + ".insertBoardReply", boardReply);
			sql.insert(namespace + ".insertBoardReplyHist", boardReply);
		}
	}
	
	//게시물 댓글 삭제
	@Override
	public boolean deleteBoardReply(BoardReplyVO boardReply) throws Exception {	
		int count = sql.selectOne(namespace + ".selectBoardReplyChild", boardReply);

        if (count > 0) {
            return false;
        }
                
        boardReply.setType(2);
		sql.delete(namespace + ".deleteBoardReply", boardReply);
		sql.insert(namespace + ".modifyBoardReplyHist", boardReply);
		return true;
	}
}
