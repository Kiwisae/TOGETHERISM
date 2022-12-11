package together.model;


import java.util.Date;

import org.springframework.stereotype.Controller;

import lombok.Getter;
import lombok.Setter;
/*
 * 의미없는 테스트용 페이지
 */
@Getter
@Setter
public class SampleDTO {
	private String member_email;
	private String member_nickname;
	private String member_pw;
	private String member_image;
	private String member_mobile1;
	private String member_mobile2;
	private String member_mobile3;
	private String member_region;
	private Date member_reg_date;
	private String member_del_yn;
	private Date member_del_date;
	private String member_del_reason;

}
