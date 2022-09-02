package com.kh.campingez.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import com.kh.campingez.common.category.mode.dto.Category;
import com.kh.campingez.inquire.model.dto.Answer;
import com.kh.campingez.inquire.model.dto.Inquire;
import com.kh.campingez.reservation.model.dto.Reservation;
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
	List<Inquire> findAllInquireList(RowBounds rowBounds);
	
	@Insert("insert into inquire_answer values('IA' || seq_answer_no.nextval, #{inqNo}, #{answerContent}, default)")
	int enrollAnswer(Answer answer);

	@Delete("delete from inquire_answer where inq_no = #{inqNo}")
	int deleteAnswer(Answer answer);
	
	@Update("update inquire_answer set answer_content = #{answerContent} where answer_no = #{answerNo}")
	int updateAnswer(Answer answer);
	
	@Select("select count(*) from inquire")
	int getInquireListTotalContent();

	@Select("select "
				+ "i.*, "
				+ "(select category_name from category_list where category_id = i.category_id) category_name, "
				+ "nvl2((select answer_no from inquire_answer a where inq_no = i.inq_no), 1, 0) answer_status "
			+ "from "
				+ "inquire i "
			+ "where "
				+ "category_id = #{categoryId} "
			+ "order by "
				+ "answer_status, inq_date")
	List<Inquire> findInquireListByCategoryId(RowBounds rowBounds, Map<String, Object> param);

	@Select("select count(*) from inquire where category_id = #{categoryId}")
	int getInquireListTotalContentByCategoryId(String categoryId);
	
	@Select("select * from category_list where category_id like '%' || 'inq' || '%'")
	List<Category> getCategoryList();
	
	@Select("select * from reservation where to_date(${searchType}, 'YY/MM/DD') between to_date(#{startDate}, 'YY/MM/DD') and to_date(#{endDate}, 'YY/MM/DD') order by res_date desc")
	List<Reservation> findReservationList(RowBounds rowBounds, Map<String, Object> param);
	
	@Select("select count(*) from reservation where to_date(${searchType}, 'YY/MM/DD') between to_date(#{startDate}, 'YY/MM/DD') and to_date(#{endDate}, 'YY/MM/DD')")
	int getReservationListTotalContent(Map<String, Object> param);

}
