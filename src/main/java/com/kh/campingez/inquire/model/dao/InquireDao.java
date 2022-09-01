package com.kh.campingez.inquire.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.kh.campingez.inquire.model.dto.Inquire;
import com.kh.campingez.inquire.model.dto.InquireEntity;

@Mapper
public interface InquireDao {

	List<Inquire> selectInquireList();

	Inquire selectInquire(String no);

	@Insert("insert into inquire values('I' || seq_inq_no.nextval, #{categoryId}, #{inqWriter}, #{inqTitle}, #{inqContent}, default)")
	int insertInquire(InquireEntity inquire);
	

	
}
