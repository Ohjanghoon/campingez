package com.kh.campingez.inquire.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.kh.campingez.inquire.model.dto.Inquire;

@Mapper
public interface InquireDao {

	List<Inquire> selectInquireList();

	@Select("select * from inquire where inq_no = #{no}")
	Inquire selectInquire(String no);
	

	
}
