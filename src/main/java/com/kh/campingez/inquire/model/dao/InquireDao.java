package com.kh.campingez.inquire.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import com.kh.campingez.inquire.model.dto.Inquire;
import com.kh.campingez.inquire.model.dto.InquireEntity;

@Mapper
public interface InquireDao {

	List<Inquire> selectInquireList(RowBounds rowBounds);

	Inquire selectInquire(String inqNo);

	@Insert("insert into inquire values('I' || seq_inq_no.nextval, #{categoryId}, #{inqWriter}, #{inqTitle}, #{inqContent}, default, null)")
	int insertInquire(InquireEntity inquire);

	@Update("update inquire set category_id = #{categoryId}, inq_title = #{inqTitle}, inq_content = #{inqContent}, inq_updated_date = current_date where inq_no = #{inqNo}")
	int updateInquire(Inquire inquire);

	@Delete("delete from inquire_answer where inq_no = #{inqNo}")
	int deleteAnswer(String inqNo);

	@Delete("delete from inquire where inq_no = #{inqNo}")
	int deleteInquire(String inqNo);

	@Select("select count(*) from inquire")
	int getTotalContent();
	

	
}
