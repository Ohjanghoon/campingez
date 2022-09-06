package com.kh.campingez.user.model.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.kh.campingez.user.model.dto.User;

@Mapper
public interface UserDao {

	int insertUser(User user);

	int insertAuthority(String userId);

	@Select("select count(*) from ez_user where user_id = #{userId}")
	int checkId(String userId);

}
