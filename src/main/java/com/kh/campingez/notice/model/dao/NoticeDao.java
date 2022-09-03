package com.kh.campingez.notice.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import com.kh.campingez.notice.model.dto.Notice;
import com.kh.campingez.notice.model.dto.NoticePhoto;

@Mapper
public interface NoticeDao {

	@Select("select * from notice")
	List<Notice> noticeList(RowBounds rowBounds);

	@Select("select count(*) from notice")
	int getTotalContent();

	Notice selectByNoticeNo(String noticeNo);

	@Delete("delete from notice where notice_no = #{noticeNo}")
	int deleteNotice(String noticeNo);

	@Select("select * from notice_photo where notice_photo_no = #{noticePhotoNo}")
	NoticePhoto selectByPhotoNo(int noticePhotoNo);

	@Delete("delete from notice_photo where notice_photo_no = #{noticePhotoNo}")
	int deletePhoto(int noticePhotoNo);

	@Update("update notice set category_id = #{categoryId}, notice_title = #{noticeTitle}, notice_content = #{noticeContent}, notice_type = #{noticeType} where notice_no = #{noticeNo}")
	int updateNotice(Notice notice);

	@Insert("insert into notice_photo values(seq_notice_photo_notice_photo_no.nextval, #{noticeNo}, #{noticeOriginalFilename}, #{noticeRenamedFilename})")
	int insertPhoto(NoticePhoto photo);
	
	

	
}
