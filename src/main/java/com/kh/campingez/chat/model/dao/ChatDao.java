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
	@Select("select * from chat_user c join chat_user t using(chatroom_id) where c.user_id = #{userId} and t.user_id = #{chatTargetId} and c.deleted_at is null and t.deleted_at is null")
	ChatUser findChatUserByUserId(@Param("userId")String userId, @Param("chatTargetId") String chatTargetId);
	
	@Insert("insert into chat_user values(#{chatroomId}, #{userId}, 0, default, default)")
	void insertChatUser(ChatUser chatUser);
	
	@Insert("insert into chat_log values(seq_chat_log_no.nextval, #{chatroomId}, #{userId}, #{chatMsg}, #{chatTime})")
	int insertChatLog(ChatLog chatLog);
	
	
	@Select("select * from chat_log where chatroom_id = #{chatroomId} order by chat_no")
	List<ChatLog> findChatLogByChatroomId(String chatroomId);
	
	List<ChatUser> findMyChat(String userId);

	@Delete("update chat_user set deleted_at = current_date where chatroom_id = #{chatroomId} and user_id = #{userId}")
	int deleteChatroom(ChatUser chatUser);

}
