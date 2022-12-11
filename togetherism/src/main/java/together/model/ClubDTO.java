package together.model;

import java.util.Date;
import lombok.Data;

public class ClubDTO {
	
	private int club_num;
	   private String club_host_email;
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
	   private String club_del_yn;
	   private Date club_del_date;
	   private int club_viewcount;
	   
	   public int getClub_num() {
		return club_num;
	}
	public void setClub_num(int club_num) {
		this.club_num = club_num;
	}
	public String getClub_host_email() {
		return club_host_email;
	}
	public void setClub_host_email(String club_host_email) {
		this.club_host_email = club_host_email;
	}
	public String getClub_name() {
		return club_name;
	}
	public void setClub_name(String club_name) {
		this.club_name = club_name;
	}
	public String getClub_image() {
		return club_image;
	}
	public void setClub_image(String club_image) {
		this.club_image = club_image;
	}
	public String getClub_region() {
		return club_region;
	}
	public void setClub_region(String club_region) {
		this.club_region = club_region;
	}
	public String getClub_keyword() {
		return club_keyword;
	}
	public void setClub_keyword(String club_keyword) {
		this.club_keyword = club_keyword;
	}
	public String getClub_info() {
		return club_info;
	}
	public void setClub_info(String club_info) {
		this.club_info = club_info;
	}
	public int getClub_member_count() {
		return club_member_count;
	}
	public void setClub_member_count(int club_member_count) {
		this.club_member_count = club_member_count;
	}
	public int getClub_member_limit() {
		return club_member_limit;
	}
	public void setClub_member_limit(int club_member_limit) {
		this.club_member_limit = club_member_limit;
	}
	public String getClub_interest() {
		return club_interest;
	}
	public void setClub_interest(String club_interest) {
		this.club_interest = club_interest;
	}
	public String getClub_chat() {
		return club_chat;
	}
	public void setClub_chat(String club_chat) {
		this.club_chat = club_chat;
	}
	public Date getClub_reg_date() {
		return club_reg_date;
	}
	public void setClub_reg_date(Date club_reg_date) {
		this.club_reg_date = club_reg_date;
	}
	public String getClub_del_yn() {
		return club_del_yn;
	}
	public void setClub_del_yn(String club_del_yn) {
		this.club_del_yn = club_del_yn;
	}
	public Date getClub_del_date() {
		return club_del_date;
	}
	public void setClub_del_date(Date club_del_date) {
		this.club_del_date = club_del_date;
	}
	public int getClub_viewcount() {
		return club_viewcount;
	}
	public void setClub_viewcount(int club_viewcount) {
		this.club_viewcount = club_viewcount;
	}

	   


}
