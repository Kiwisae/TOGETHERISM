package together.model;

import java.sql.Date;

import lombok.Data;

@Data
public class ClubJoinInfo {
	
	private int club_num;
	private int join_num;
	private String member_email;
	private String club_host_yn;
	private String club_host_email;
	private String join_hello;
	private Date join_date;
	private int club_num_1;
	private String club_name;
	private String club_image;
	private String club_region;
	private String club_keyword;
	private String club_info;
	private int club_member_count;
	private int club_member_limit;
	private String club_interest;
	private String club_chat;
	private Date club_reg_date;
	private int club_viewcount;

}
