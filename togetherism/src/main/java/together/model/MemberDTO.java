package together.model;



import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class MemberDTO {

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
   
   private String search;
   private String keyword;
}

