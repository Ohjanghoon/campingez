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

import com.kh.campingez.admin.model.dto.Stats;
import com.kh.campingez.alarm.model.dto.Alarm;
import com.kh.campingez.assignment.model.dto.Assignment;
import com.kh.campingez.campzone.model.dto.Camp;
import com.kh.campingez.campzone.model.dto.CampPhoto;
import com.kh.campingez.campzone.model.dto.CampZone;
import com.kh.campingez.common.category.mode.dto.Category;
import com.kh.campingez.inquire.model.dto.Answer;
import com.kh.campingez.inquire.model.dto.Inquire;
import com.kh.campingez.report.dto.Report;
import com.kh.campingez.reservation.model.dto.Reservation;
import com.kh.campingez.trade.model.dto.Trade;
import com.kh.campingez.user.model.dto.User;

@Mapper
public interface AdminDao {
	
	List<User> findAllUserList(RowBounds rowBounds);

	List<User> findAllBlackList(RowBounds rowBounds);

	List<User> findAllNotBlackList(RowBounds rowBounds);
	
	@Select("select count(*) from ez_user")
	int getTotalContent();
	
	@Select("select count(*) from ez_user where yellowcard >= 3")
	int getBlackListTotalContent();
	
	@Select("select count(*) from ez_user where yellowcard < 3")
	int getNotBlackListTotalContent();
	
	@Update("update ez_user set yellowcard = yellowcard + 1 where user_id = #{userId}")
	int updateWarningToUser(String userId);
	
	@Select("select * from ez_user where ${selectType} like '%' || #{selectKeyword} || '%' order by enroll_date desc")
	List<User> selectUserByKeyword(RowBounds rowBounds, Map<String, Object> param);
	
	@Select("select * from ez_user where ${selectType} like '%' || #{selectKeyword} || '%' and yellowcard < 3 order by enroll_date desc")
	List<User> selectNotBlackListByKeyworkd(RowBounds rowBounds, Map<String, Object> param);	
	
	@Select("select count(*) from ez_user where ${selectType} like '%' || #{selectKeyword} || '%'")
	int getTotalContentByKeyword(Map<String, Object> param);
	
	@Select("select count(*) from ez_user where ${selectType} like '%' || #{selectKeyword} || '%' and yellowcard < 3")
	int getTotalContentNotBlackListByKeyword(Map<String, Object> param);
	
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

	@Select("select * from camp_zone order by zone_code")
	List<CampZone> findAllCampZoneList();

	//@Select("select * from camp_zone where zone_code = #{zoneCode}")
	CampZone findCampZoneByZoneCode(String zoneCode);
	
	@Update("update camp_zone set zone_name = #{zoneName}, zone_info = #{zoneInfo}, zone_maximum = #{zoneMaximum}, zone_price = #{zonePrice} where zone_code = #{zoneCode}")
	int updateCampZone(CampZone campZone);
	
	@Insert("insert into camp_zone values(#{zoneCode}, #{zoneName}, #{zoneInfo}, #{zoneMaximum}, #{zonePrice})")
	int insertCampZone(CampZone campZone);
	
	@Insert("insert into camp_photo values(seq_camp_photo_no.nextval, #{zoneCode}, #{originalFilename}, #{renamedFilename})")
	int insertCampPhoto(CampPhoto photo);
	
	@Delete("delete from camp_zone where zone_code = #{zoneCode}")
	int deleteCampZone(String zoneCode);
	
	@Select("select * from camp_photo where zone_code = #{zoneCode}")
	List<CampPhoto> selectCampPhotoByZoneCode(CampZone campZone);
	
	@Select("select * from camp_photo where zone_photo_no = #{photoNo}")
	CampPhoto findCampPhotoByPhotoNo(int photoNo);
	
	@Delete("delete from camp_photo where zone_photo_no = #{photoNo}")
	int deleteCampPhotoByPhotoNo(int photoNo);
	
	List<CampZone> findAllCampList();
	
	@Insert("insert into stats_daily_visit values(#{userId}, default)")
	int insertDailyVisit(String userId);

	@Select("select"
			+ " count(*) visit_date_count,"
			+ " to_char(visit_date, 'YYYY-MM-DD') visit_date "
			+ "from"
			+ " stats_daily_visit "
			+ "where"
			+ " extract(year from visit_date) = #{year}"
			+ " and"
			+ " extract(month from visit_date) = #{month} "
			+ "group by"
			+ " to_char(visit_date, 'YYYY-MM-DD') "
			+ "order by"
			+ " visit_date")
	List<Stats> statsVisitedChartByDate(Map<String, Object> param);
	
	@Select("select count(*) visit_date_count from stats_daily_visit where extract(year from visit_date) = #{year} and extract(month from visit_date) = #{month}")
	int statsVisitedTotalCountByDate(Map<String, Object> param);
	
	@Select("select count(*) visite_date_count from stats_daily_visit")
	int statsVisitedTotalCount();
	
	@Select("select user_id, count(*) visit_date_count from stats_daily_visit where to_date(visit_date, 'YY/MM/DD') = to_date(#{searchDate}, 'YYYY-MM-DD') group by user_id order by visit_date_count desc")
	List<Stats> getLoginMemberListByDate(String searchDate);

	@Select("select to_char(res_date, 'Mon') month, sum(res_price) total_price from reservation where extract(year from res_date) = #{year} and res_state = '예약완료' group by to_char(res_date, 'Mon')")
	List<Stats> getMonthlySalesListByYear(int year);
	
	@Select("select sum(res_price) total_price, to_date(res_date, 'YY/MM/DD') res_date from reservation where extract(year from res_date) = #{year} and extract(month from res_date) = #{month} and res_state = '예약완료' group by to_date(res_date, 'YY/MM/DD') order by res_date")
	List<Stats> getSaleListByMonth(Map<String, Object> param);
	
	@Select("select nvl(sum(res_price), 0) total_price from reservation where res_state = '예약완료'")
	int getTotalSalesPrice();
	
	@Select("select nvl(sum(res_price), 0) total_price from reservation where res_state = '예약완료' and extract(year from res_date) = #{year}")
	int getYearTotalSalesPrice(Map<String, Object> param);
	
	@Select("select * from camp where camp_id = #{campId}")
	Camp selectCampByCampId(String campId);
	
	@Insert("insert into camp values (#{campId}, #{zoneCode})")
	int insertCamp(Map<String, Object> param);
	
	@Delete("delete from camp where camp_id = #{campId}")
	int deleteCampByCampId(String campId);

	List<CampZone> findCampByZoneCode(String zoneCode);
	
	List<Assignment> findAllAssignmentList(RowBounds rowBounds);
	
	@Select("select count(*) from  assignment a left join reservation r on a.res_no = r.res_no where res_checkin > current_date")
	int getAssignmentTotalContent();

	List<Assignment> findAssignmentListBySelectType(Map<String, Object> param, RowBounds rowBound);
	
	@Select("select count(*) from  assignment a left join reservation r on a.res_no = r.res_no where res_checkin > current_date and assign_state = #{selectType}")
	int getAssignmentBySelectTypeTotalContent(Map<String, Object> param);

	List<Assignment> findAllExpireAssignmentList(RowBounds rowBounds);
	
	@Select("select count(*) from  assignment a left join reservation r on a.res_no = r.res_no where res_checkin <= current_date")
	int getExpireAssignmentTotalContent();
	
	List<Trade> findAllTradeReportList(RowBounds rowBounds);
	
	@Select("select count(*) from ( select r.*, count(*) over(partition by r.comm_no) as report_count from report r where substr(r.comm_no, 1, 1) = 'T') a where report_count >= 2")
	int getTradeReportTotalContent();
	
	@Update("update report set report_action = 'Y' where comm_no = #{commNo}")
	int updateReportAction(String commNo);

	int updateIsDelete(String type);

	int updateIsDelete(Map<String, Object> param);
	
	Object selectCommByNo(Map<String, Object> param);
	
	@Select("select * from trade where trade_no = #{tradeNo}")
	Trade findTradeByTradeNo(String tradeNo);
	
	@Select("select user_id from report where comm_no = #{commNo}")
	List<String> findReportUserListByCommNo(String commNo);

}
