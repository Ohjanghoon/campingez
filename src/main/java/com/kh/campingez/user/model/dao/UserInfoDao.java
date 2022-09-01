package com.kh.campingez.user.model.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import com.kh.campingez.user.model.dto.User;

@Mapper
public interface UserInfoDao {

	@Update(" update ez_user "
			  + " set user_name = #{userName}, password = #{password}, email = #{email}, phone = #{phone}, gender = #{gender} "
			  + " where user_id = #{userId}")
	int profileUpdate(User user);

}
