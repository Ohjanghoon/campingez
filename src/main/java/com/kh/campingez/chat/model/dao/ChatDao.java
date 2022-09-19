package com.kh.campingez.chat.model.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.kh.campingez.chat.model.dto.ChatLog;
import com.kh.campingez.chat.model.dto.ChatUser;

@Mapper
public interface ChatDao {
	
	@Select("select * from chat_user where user_id = #{userId}")
	ChatUser findChatUserByUserId(String userId);
	
	@Insert("insert into chat_user values(#{chatroomId}, #{userId}, #{tradeNo} , 0, default, default)")
	int insertChatUser(ChatUser chatUser);
	
	@Insert("insert into chat_log values(seq_chat_log_no.nextmal, #{chatroomId}, #{userId}, #{msg}, #[time}")
	int insertChatLog(ChatLog chatLog);
	
	@Select("select * from chat_user c join trade t on c.trade_no = t.trade_no where t.user_id = #{userId}")
	ChatUser findSellerByUserId(String userId);

}
