<%@ page language="java" import="java.util.*, java.io.*, java.lang.*,java.text.*" contentType="text/html;charset=euc-kr" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import = "wisew.utils.FtpUtil" %>
<%
	
	String RTN="ERROR";

	System.out.println("ipAuthUser ");
		request.setCharacterEncoding("euc-kr");
		//response.setContentType("text/plain");
		
		try
		{
		
		System.out.println("new DiskFileUpload start ");
			DiskFileUpload fu = new DiskFileUpload();
		  //fu.setHeaderEncoding("euc-kr");
			fu.setSizeMax(1024*10240*50); // 弥措 20皋啊
			fu.setSizeThreshold(1024*100);
			//fu.setRepositoryPath(directory);

	System.out.println("new DiskFileUpload end ");

			List fileItems = fu.parseRequest(request);
			
			
			for(int i=0;i<fileItems.size();i++)
			{
				FileItem fileItem=(FileItem)fileItems.get(i);
				if(fileItem.getSize()>0)
				{
				System.out.println(fileItem);
				
					if( fileItem.getName()==null)
						break;
					String filename = fileItem.getName();
					
					System.out.println(filename);					
					
					String chkDir =filename.substring(0,filename.lastIndexOf("/")+1); 

	System.out.println("dir create start");

					File dir = new File(chkDir);
					if(!dir.exists()){
						dir.mkdirs();
					}
					
					File fout = new File(filename);

	System.out.println("dir create end");

				//fout.delete(); 
			  fileItem.write(fout);
			  
			  String strFileName = filename.substring(chkDir.length());
			  
			  System.out.println(strFileName);
			  
			  System.out.println("file write end");


	System.out.println("ftp start");
					////////////////////////FTP 贸府//////////////////////////////////
					//String ftpIp = (String) IndiProps.getInstance().get("FtpIp");
					//String ftpId = (String) IndiProps.getInstance().get("FtpId");
					//String ftpPw = (String) IndiProps.getInstance().get("FtpPw");
					//String faxFilePath = (String) IndiProps.getInstance().get("FaxFilePath");
					
					String ftpIp = "192.168.153.184";            
					String ftpId = "fax";            
					String ftpPw = "Cosmos)0";            
					String faxFilePath = "/app/fax/attach_file/";
					
					boolean file_upload_YN = false;

					wisew.utils.FtpUtil ftpUtil = new wisew.utils.FtpUtil();
					file_upload_YN = ftpUtil.ftpFax(ftpId, ftpPw, ftpIp, faxFilePath, strFileName);
					////////////////////////FTP 贸府//////////////////////////////////
	System.out.println("ftp end");

					if (file_upload_YN)
					{
					System.out.println("file_upload_YN TRUE");
						RTN="OK";
					} else {
						System.out.println("file_upload_YN FALSE");
						RTN="FTP ERROR";
					}
					
					File f = new File(filename);
					if (f.delete())
					{
						System.out.println("Delete TRUE");
					}
					else
					{
						System.out.println("Delete FALSE");
					}
					
				}
				else
				{
					RTN="ERROR";
				}
			}
		}
		catch(Exception e)
		{
			System.out.println("Upload Exception>>"+e.toString());
			RTN=e.toString();
		}

%>
<%=RTN%>
<%
%>
