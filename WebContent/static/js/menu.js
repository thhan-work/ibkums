var menus = [
	{
	     "name": "message_link",
	     "urls": ["/message.ibk"],
	     "topID": "main01",
	     "parentID": "group-1"
	},
	{
	     "name": "filesend_link",
	     "urls": ["/filesend.ibk"],
	     "topID": "main01",
	     "parentID": "group-1"
	},
	{
	     "name": "eventmessage_link",
	     "urls": ["/eventsend.ibk"],
	     "topID": "main01",
	     "parentID": "group-1"
	},
	{
	     "name": "emplsend_link",
	     "urls": ["/emplsms/emplsend.ibk"],
	     "topID": "main01",
	     "parentID": "group-1"
	},
	{
	     "name": "all_address_link",
	     "urls": ["/all-address.ibk","/contact-list.ibk","/contact-detail.ibk"],
	     "topID": "main01",
	     "parentID": "group-4"
	},
	{
	     "name": "personal_address_link",
	     "urls": ["/personal-address.ibk"],
	     "topID": "main01",
	     "parentID": "group-4"
	},
	{
         "name": "share_address_link",
         "urls": ["/share-address.ibk"],
         "topID": "main01",
         "parentID": "group-4"
	},
	{
        "name": "fileupload_address_link",
        "urls": ["/upload-address.ibk"],
        "topID": "main01",
        "parentID": "group-4"
	},
   {
        "name": "mymessage_link",
        "urls": ["/mymessage.ibk"],
        "topID": "main01",
        "parentID": "group-2"
   },
   {
        "name": "reservedmessage_link",
        "urls": ["/reservedmessage.ibk"],
        "topID": "main01",
        "parentID": "group-2"
   },
   {
        "name": "happy_link",
        "urls": ["/form/happy.ibk"],
        "topID": "main01",
        "parentID": "group-3"
   },
   {
        "name": "head_link",
        "urls": ["/form/head.ibk"],
        "topID": "main01",
        "parentID": "group-3"
   },
   {
        "name": "personal_link",
        "urls": ["/form/personal.ibk"],
        "topID": "main01",
        "parentID": "group-3"
   },
   {
        "name": "dept_link",
        "urls": ["/form/dept.ibk"],
        "topID": "main01",
        "parentID": "group-3"
   },
   {
       "name": "envset_link",
       "urls": ["/envset.ibk"],
       "topID": "main01",
       "parentID": "group-5"
   },
   {
       "name": "smsUnsubscribe_link",
       "urls": ["/smsUnsubscribe.ibk"],
       "topID": "main01",
       "parentID": "group-5"
   },
   {
       "name": "changePassword_link",
       "urls": ["/changepassword.ibk"],
       "topID": "main01",
       "parentID": "group-5"
   },
   {
       "name": "nevigation_link",
       "urls": ["/nevigation.ibk"],
       "topID": "main02",
       "parentID": "group-6"
   },
   {
       "name": "reservationStatus_link",
       "urls": ["/reservationStatus.ibk"],
       "topID": "main02",
       "parentID": "group-6"
   },
   {
	   "name": "smsreq_link",
	   "urls": ["/smsreq.ibk"],
	   "topID": "main02",
	   "parentID": "group-6"
   },
   {
	   "name": "smssendlist_link",
	   "urls": ["/smssendlist.ibk","/smssendlist-detail.ibk"],
	   "topID": "main02",
	   "parentID": "group-6"
   },
   {
	   "name": "confirmlist_link",
	   "urls": ["/confirmlist.ibk","/confirmlist-detail.ibk"],
	   "topID": "main02",
	   "parentID": "group-7"
   },
   {
     "name": "employee_link",
     "urls": ["/admin/employee.ibk"],
     "topID": "main03",
     "parentID": "group-8"
   },
   {
     "name": "authorizer_link",
     "urls": ["/admin/authorizer.ibk"],
     "topID": "main03",
     "parentID": "group-8"
   },
   {
     "name": "admin_link",
     "urls": ["/admin/admin.ibk"],
     "topID": "main03",
     "parentID": "group-8"
   },
   {
     "name": "directlogin_link",
     "urls": ["/admin/directlogin.ibk"],
     "topID": "main03",
     "parentID": "group-8"
   },
   {
     "name": "motplogin_link",
     "urls": ["/admin/motplogin.ibk"],
     "topID": "main03",
     "parentID": "group-8"
   },
   {
     "name": "notice_link",
     "urls": ["/admin/notice.ibk","/admin/notice-detail.ibk"],
     "topID": "main03",
     "parentID": "group-8"
   },
   {
     "name": "login_history_link",
     "urls": ["/admin/login-history.ibk"],
     "topID": "main03",
     "parentID": "group-8"
   },
   {
     "name": "menu06",
     "urls": ["/menu06.ibk","/notice-menu06-detail.ibk"],
     "topID": "main02",
     "parentID": "group-8"
   },
   {
     "name": "loglist_link",
     "urls": ["/admin/loglist.ibk"],
     "topID": "main03",
     "parentID": "group-8"
   },
   {
     "name": "user_link",
     "urls": ["/admin/user.ibk"],
     "topID": "main03",
     "parentID": "group-8"
   },
   {
	     "name": "template_link",
	     "urls": ["/template-list.ibk"],
	     "topID": "main03",
	     "parentID": "group-8"
   }
 ];

var link = document.location.href;
for (var i = 0; i < menus.length; i++){
    for(var k = 0 ; k < menus[i].urls.length ; k++){
        if(link.indexOf(menus[i].urls[k]) > 0){
            document.getElementById(menus[i].name).className = " sublabel on";
            document.getElementById(menus[i].topID).style.display="";
            document.getElementById(menus[i].parentID).checked = true;
        }
    }
}

