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
	
	ChatUser findChatUserByUserId(
			@Param("userId")String userId, 
			@Param("chatTargetId") String chatTargetId,
			@Param("chatTradeNo") String chatTradeNo);
	
	@Insert("insert into chat_user values(#{chatroomId}, #{userId}, 0, default, default, #{chatTradeNo})")
	void insertChatUser(ChatUser chatUser);
	
	@Insert("insert into chat_log values(seq_chat_log_no.nextval, #{chatroomId}, #{userId}, #{chatMsg}, #{chatTime})")
	int insertChatLog(ChatLog chatLog);
	
	
	@Select("select * from chat_log where chatroom_id = #{chatroomId} order by chat_no")
	List<ChatLog> findChatLogByChatroomId(String chatroomId);
	
	List<ChatUser> findMyChat(String userId);

	@Delete("update chat_user set deleted_at = current_date where chatroom_id = #{chatroomId} and user_id = #{userId}")
	int deleteChatroom(ChatUser chatUser);

	@Select("select chat_trade_no from chat_user where chatroom_id = #{chatroomId} group by chat_trade_no")
	String findChatTradeNo(String chatroomId);

}
