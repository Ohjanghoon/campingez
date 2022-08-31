package com.kh.campingez.mypage.model.dao;


import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.kh.campingez.user.model.dto.User;

@Mapper
public interface MypageDao {

	@Select("select * from ez_user where user_id = #{userId}")
	User selectUserInfo(String userId);
	
	@Update(" update ez_user "
			  + " set user_name = #{userName}, password = #{password}, email = #{email}, phone = #{phone}, gender = #{gender} "
			  + " where user_id = #{userId}")
	int profileUpdate(User user);
}
