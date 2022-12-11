package together.model;

import java.util.Date;


import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Club_Member_JoinDTO {



   private int join_num;
   private String member_email;
   private int club_num;
   private String member_nickname;
   private String member_image;
   private String join_hello;
   private String club_host_yn;
   private Date join_date;

}



