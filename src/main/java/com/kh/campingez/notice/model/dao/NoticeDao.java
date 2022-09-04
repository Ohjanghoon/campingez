package com.kh.campingez.notice.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import com.kh.campingez.notice.model.dto.Coupon;
import com.kh.campingez.notice.model.dto.Notice;
import com.kh.campingez.notice.model.dto.NoticePhoto;

@Mapper
public interface NoticeDao {

	@Select("select * from notice order by notice_date desc")
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

	@Insert("insert into notice values('N1'||seq_notice_notice_no.nextval, #{categoryId}, #{noticeTitle}, #{noticeContent}, default, #{noticeType})")
	@SelectKey(statement = "select 'N1'|| seq_notice_notice_no.currval from dual",before = false, resultType = String.class, keyProperty = "noticeNo")
	int insertNotice(Notice notice);

	@Select("select * from coupon where coupon_code = #{coupon_code}")
	boolean findByCoupon(String couponCode);

	@Insert("insert into coupon values(#{couponCode}, #{couponName}, #{couponDiscount}, #{couponStartday}, #{couponEndday}, default)")
	int insertCoupon(Coupon coupon);
	
	

	
}
