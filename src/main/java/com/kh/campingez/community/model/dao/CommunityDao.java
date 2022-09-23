package com.kh.campingez.community.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import com.kh.campingez.community.model.dto.Community;
import com.kh.campingez.community.model.dto.CommunityComment;
import com.kh.campingez.community.model.dto.CommunityLike;
import com.kh.campingez.community.model.dto.CommunityPhoto;

@Mapper
public interface CommunityDao {
   
//   @Select("select * from community")
   List<Community> selectCommList(RowBounds rowBounds);
   
   @Select("select count(*) from community")
   int getTotalContext();
   
//   @Select("select * from community where comm_no = #{commNo}")
   Community selectCommByNo(String no);
   
   @Select("select * from comm_photo where comm_no = #{cmNo}")
   List<CommunityPhoto> selectPhotoListByCommNo(String no);
   
   @Select("select count(like_check) from comm_like where comm_no = #{likeCommNo} and user_id = #{likeUserId}")
   int getCommLike(CommunityLike cl);
   
   @Update("update community set comm_read_count = #{readCount} + 1 where comm_no = #{commNo}") 
   int updateReadCount(Community community);
   
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
   
   @Insert("insert into comm_photo values(seq_community_photo_no.nextval, #{cmNo}, #{originalFilename}, #{renamedFilename})")
   int insertPhoto(CommunityPhoto photo);
   
   @Select("select * from comm_photo where comm_photo_no = #{commPhotoNo}")
   CommunityPhoto selectOnePhoto(int photoNo);
   
   @Delete("delete from comm_photo where comm_photo_no = #{commPhotoNo}")
   int deletePhoto(int photoNo);
   
   @Update("update community set comm_title = #{commTitle}, comm_content = #{commContent} where comm_no = #{commNo}")
   int updateComm(Community community);
   
   @Delete("delete from community where comm_no = #{commNo}")
   int deleteComm(String no);
   
   @Insert("insert into comm_comment values('CC' || seq_comment_no.nextval, #{commentCommNo}, #{userId}, #{commentContent}, default, #{commentLevel}, #{commentRef})")
   void insertComment(CommunityComment cc);
   
//   @Select("select  m.comment_no, c.comm_no as comment_comm_no, m.user_id, m.comment_content, m.comment_date, m.comment_level, m.comment_ref from comm_comment m join community c on c.comm_no = m.comm_no where c.comm_no = #{commNo} start with comment_level = 1 connect by prior c.comm_no = comment_ref order siblings by c.comm_no asc")
   List<CommunityComment> selectCommentList(String commNo);
   
   @Delete("delete from comm_comment where comment_no = #{commentNo}")
   int deleteComment(CommunityComment cc);
   
   @Select("select (select user_id from report where comm_no = c.comm_no and user_id = #{userId}) report_user_id from community c where comm_no = #{no}")
   String getUserReportComm(Map<String, Object> param);
   

}
