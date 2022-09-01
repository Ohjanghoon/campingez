package com.kh.campingez.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import com.kh.campingez.inquire.model.dto.Inquire;
import com.kh.campingez.user.model.dto.User;

@Mapper
public interface AdminDao {
	
	//@Select("select * from ez_user order by enroll_date desc")
	List<User> findAllUserList(RowBounds rowBounds);
	
	@Select("select count(*) from ez_user")
	int getTotalContent();
	
	@Update("update ez_user set yellowcard = yellowcard + 1 where user_id = #{userId}")
	int updateWarningToUser(String userId);
	
	@Select("select * from ez_user where ${selectType} like '%' || #{selectKeyword} || '%' order by enroll_date desc")
	List<User> selectUserByKeyword(RowBounds rowBounds, Map<String, Object> param);
	
	@Select("select count(*) from ez_user where ${selectType} like '%' || #{selectKeyword} || '%'")
	int getTotalContentByKeyword(Map<String, Object> param);
	
	@Select("select * from ez_user where user_id = #{userId}")
	User findUserByUserId(String userId);
	
	@Select("select i.*, (select category_name from category_list where category_id = i.category_id) category_name, nvl2((select answer_no from inquire_answer a where inq_no = i.inq_no), 1, 0) answer_status from inquire i order by answer_status, inq_date")
	List<Inquire> findAllInquireList();

}
