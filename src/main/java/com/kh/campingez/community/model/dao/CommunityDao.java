package com.kh.campingez.community.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import com.kh.campingez.community.model.dto.Community;
import com.kh.campingez.community.model.dto.CommunityLike;
import com.kh.campingez.community.model.dto.CommunityPhoto;

@Mapper
public interface CommunityDao {
	
	@Select("select * from community")
	List<Community> selectCommList(RowBounds rowBounds);
	
	@Select("select count(*) from community")
	int getTotalContext();
	
	@Select("select * from community where comm_no = #{commNo}")
	Community selectCommByNo(String no);
	
	@Select("select * from comm_photo where comm_no = #{commNo}")
	List<CommunityPhoto> selectPhotoListByCommNo(String no);
	
	@Select("select count(like_check) from comm_like where comm_no = #{likeCommNo} and user_id = #{likeUserId}")
	int getCommLike(CommunityLike cl);
	
	@Update("update community set comm_read_count = ${readCount} + 1 where comm_no = #{commNo}")
	int updateReadCount(String no);
	
	@Delete("delete from comm_like where comm_no = #{likeCommNo} and user_id = #{likeUserId}")
	void deleteCommLike(CommunityLike cl);
	
	@Update("update community set comm_like_count = (select count(*) from comm_like where comm_no = #{likeCommNo}) where comm_no = #{commNo} ")
	void updateCommLike(String likeCommNo);
	
	@Insert("insert into comm_like (comm_no, user_id) values (#{likeCommNo}, #{likeUserId})")
	void insertCommLike(CommunityLike cl);
	
	@Insert("insert into community values('C' || seq_community_comm_no.nextval, #{userId}, #{categoryId}, #{commTitle}, " 
			+ "#{commContent}, default, default, 0, default, default)")
	@SelectKey(statement = "select 'C' || seq_community_comm_no.currval from dual" , before = false, keyProperty = "commNo", resultType = String.class)
	int insertComm(Community community);
	
	@Insert("insert into comm_photo values(seq_community_photo_no.nextval, #{commNo}, #{originalFilename}, #{renamedFilename})")
	int insertPhoto(CommunityPhoto photo);
	
	@Select("select * from comm_photo where comm_photo_no = #{commPhotoNo}")
	CommunityPhoto selectOnePhoto(int photoNo);
	
	@Delete("delete from comm_photo where comm_photo_no = #{commPhotoNo}")
	int deletePhoto(int photoNo);
	
	@Update("update community set comm_title = #{commTitle}, comm_content = #{commContent} where comm_no = #{commNo}")
	int updateComm(Community community);
	
	@Delete("delete from community where comm_no = #{commNo}")
	int deleteComm(String no);


}
