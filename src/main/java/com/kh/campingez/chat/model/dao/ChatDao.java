package com.kh.campingez.chat.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.kh.campingez.chat.model.dto.ChatLog;
import com.kh.campingez.chat.model.dto.ChatUser;

@Mapper
public interface ChatDao {
	
	// 여기 쿼리를 sql에서 진행해보는데 아무것도 나올수가 없는 구조같은데, where절 and이후를 지워봐도 진행이 안되서.. 아이디어 공유 부탁드립니다.
	@Select("select \r\n"
			+ "    *\r\n"
			+ "from\r\n"
			+ "    chat_user c join chat_user t \r\n"
			+ "    using(chatroom_id, chat_trade_no)\r\n"
			+ "where\r\n"
			+ "    c.user_id = 'honggd' and t.user_id = 'sinsa'\r\n"
			+ "    and\r\n"
			+ "    c.deleted_at is null and t.deleted_at is null\r\n"
			+ "    and\r\n"
			+ "    chat_trade_no is null")
	ChatUser findChatUserByUserId(
			@Param("userId")String userId, 
			@Param("chatTargetId") String chatTargetId,
			@Param("chatTradeNo") String chatTradeNo);
	
	@Insert("insert into chat_user values(#{chatroomId}, #{userId}, 0, default, default, #{chatTradeNo})")
	void insertChatUser(ChatUser chatUser);
	
	@Insert("insert into chat_log values(seq_chat_log_no.nextval, #{chatroomId}, #{userId}, #{chatMsg}, #{chatTime})")
	int insertChatLog(ChatLog chatLog);
	
	
	@Select("select \r\n"
			+ "    cl.*,\r\n"
			+ "    (select chat_trade_no from chat_user where chatroom_id = #{chatroomId} group by chat_trade_no) chat_trade_no\r\n"
			+ "from\r\n"
			+ "    chat_log cl\r\n"
			+ "where\r\n"
			+ "    chatroom_id = #{chatroomId}\r\n"
			+ "order by\r\n"
			+ "    chat_no")
	List<ChatLog> findChatLogByChatroomId(String chatroomId);
	
	List<ChatUser> findMyChat(String userId);

	@Delete("update chat_user set deleted_at = current_date where chatroom_id = #{chatroomId} and user_id = #{userId}")
	int deleteChatroom(ChatUser chatUser);

}
