package wisew.utils;

import java.io.*;

import com.oroinc.net.ftp.*;

/**
 * Title        : FTP 전송 유틸
 * Description  : WAS에 파일을 다른서버로 전송
 * Copyright    : Copyright (c) 2008
 * Company      : 엠앤와이즈
 * 
 * @author 장홍준
 * @version 1.0
 */

public class FtpUtil {

	String server = "";
	int port ;
	String id = "";
	String password = "";
	FTPClient ftpClient = null;

	public FtpUtil(){
	}

	public FtpUtil(String server, int port) {
		this.server = server;
		this.port = port;
		ftpClient = new FTPClient();
	}

	// 계정과 패스워드로 로그인
	public boolean login(String id, String password) {
		ftpClient = new FTPClient();

		try {
			this.connect();
			System.out.println("FTP ID : " + id + " PW : "+password);
			ftpClient.login(id, password);
		} catch (IOException ioe) {
			ioe.printStackTrace();
		}
		return false;
	}

	// 서버로 연결
	public void connect() {
		try {
			ftpClient.connect(server, port);
			int reply;
			// 연결 시도후, 성공했는지 응답 코드 확인
			reply = ftpClient.getReplyCode();
			System.out.println(!FTPReply.isPositiveCompletion(reply));

			if(!FTPReply.isPositiveCompletion(reply)) {
				ftpClient.disconnect();
				System.err.println("서버로부터 연결을 거부당했습니다");
				System.exit(1);
			}
		} catch (IOException ioe) {
			if (ftpClient.isConnected()) {
				try {
					ftpClient.disconnect();
				} catch(IOException f) {
					//
				}
			}
			System.err.println("서버에 연결할 수 없습니다");
			System.exit(1);
		}
	}

	// FTP의 ls 명령, 모든 파일 리스트를 가져온다
	public FTPFile[] list() {
		FTPFile[] files = null;

		try {
			files = this.ftpClient.listFiles();
			return files;
		} catch (IOException ioe) {
			ioe.printStackTrace();
		}
		return null;
	}

	// 파일리스트 전송 받는다.
	public File getFileList(String source) {

		OutputStream output = null;
		try {
			File local = new File(source);
			output = new FileOutputStream(local);
		}
		catch (FileNotFoundException fnfe) {
			fnfe.printStackTrace();
		}
		File file = new File(source);
		/**
		 *
		 * retriveFile(String remoteName, OutputStream local)
		 * |
		 * storeFile(String remoteName, InputStream local)
		 */

		try {
			if (ftpClient.retrieveFile(source, output)) {
				return file;
			}
		}
		catch (IOException ioe) {
			ioe.printStackTrace();
		}

		return null;
	}
	// 서버 디렉토리 이동
	public boolean cd(String path) {
		boolean flag = false;
		try {
			System.out.println("Directory Change - > " + path);
			flag = ftpClient.changeWorkingDirectory(path);

			if(flag){
				System.out.println("dir change success!!");
			}
			else{
				System.out.println("dir change failed!!");
			}
		}
		catch (IOException ioe) {
			ioe.printStackTrace();
		}
		return flag;
	}

	// 파일삭제
	public File delFile(String fileName) throws IOException{

		ftpClient.deleteFile(fileName);

		return null;
	}

	//  디렉토리 생성
	public File createDirectory(String fileName) throws IOException{


		ftpClient.makeDirectory(fileName);

		return null;
	}

	//  디렉토리 삭제
	public File deleteDirectory(String fileName) throws IOException{

		ftpClient.removeDirectory(fileName);

		return null;
	}

	//  이름 변경
	public File fileReName(String oldName, String newName) throws IOException{

		ftpClient.rename(oldName, newName);

		return null;
	}

	//  파일 업로드
	public boolean putFileUpLoad(String fUpDir, String fileName) {

		boolean flag = false;
		BufferedInputStream bi = null;
		try {
			File uploadFile = new File(fUpDir,fileName);
			bi = new BufferedInputStream(new FileInputStream(uploadFile.getPath()));
			ftpClient.setFileType(FTP.BINARY_FILE_TYPE);

			if (bi != null) {
				flag = ftpClient.storeFile(fileName, bi);
			}
			else {
				System.out.println("FileStream 생성 오류!!!");
			}

			if (flag) {
				System.out.println("FTP Upload Success : " + fileName.toString());
			}
			else {
				System.out.println("FTP FAILED : " + fileName.toString());
			}

			bi.close();

		}
		catch(IOException ex) {
			System.out.println(ex.getMessage());
			return flag;
		} finally {
			if (bi != null) try { bi.close(); } catch(IOException ex) {}

		}

		return flag;
	}
	//  파일 다운로드
	public File getFileDownLoad(String downPath, String downFile) {

		/**
		 *
		 * retriveFile(String remoteName, OutputStream local)
		 * |
		 * storeFile(String remoteName, InputStream local)
		 */

		File downloadFile = new File(downPath,downFile);
		FileOutputStream fos = null;
		try {

			fos = new FileOutputStream(downloadFile);
			boolean isSuccess = ftpClient.retrieveFile(downloadFile.getName(), fos);
			if (isSuccess) {
				System.out.println("다운로드 성공");
			}else {
				System.out.println("다운로드 실패");
			}
		}
		catch(IOException ex) {
			System.out.println(ex.getMessage());
		} finally {
			if (fos != null) try { fos.close(); } catch(IOException ex) {}
		}

		return null;
	}
	// 서버로부터 연결을 닫는다
	public boolean closeConnect() {
		try {
			ftpClient.disconnect();
		}
		catch (IOException ioe) {
			ioe.printStackTrace();
		}
		return false;
	}
	// 서버로부터 로그아웃한다.
	public boolean loginOut() {
		try {
			ftpClient.logout();
		}
		catch (IOException ioe) {
			ioe.printStackTrace();
		}
		return false;
	}

	// 서버로 파일 업로드
	public boolean ftpOpen(String FtpId, String FtpPw, String ftpIp, String ftpPath, String filePath, String fileName) throws Exception{

		boolean flag = false;

		System.out.println("==================================================");
		System.out.println("ftpIp : " + ftpIp);
		System.out.println("ftpId : " + FtpId);
		System.out.println("ftpPw : " + FtpPw);
		System.out.println("ftpPath : " + ftpPath);
		System.out.println("filePath : " + filePath);
		System.out.println("fileName : " + fileName);
		System.out.println("==================================================");

		FtpUtil ftp = new FtpUtil(ftpIp, 21);
		System.out.println("connect..");

		try{
			if (!ftpIp.trim().equalsIgnoreCase("null") && !ftpIp.equals("") && ftpIp != null) {

				ftp.connect();
				ftp.login(FtpId, FtpPw);
				System.out.println("dirPath Move : " + filePath);

				if(ftp.cd(ftpPath)){
					flag = ftp.putFileUpLoad(filePath, fileName);
				}
				//              ftp.closeConnect();
				System.out.println("Upload Success!! Close Connection..");
			}
		}catch(Exception e){
			return flag;
		}finally{
			ftp.closeConnect();
		}

		return flag;
	}

	// FAX 전송 서버로 파일 업로드
	public boolean ftpFax(String FtpId, String FtpPw, String ftpIp, String dirPath, String fileName) throws Exception{

		boolean flag = false;

		System.out.println("==================================================");
		System.out.println("ftpIp : " + ftpIp);
		System.out.println("ftpPath : " + dirPath);
		System.out.println("ftpId : " + FtpId);
		System.out.println("ftpPw : " + FtpPw);
		System.out.println("fileName : " + fileName);
		System.out.println("==================================================");
		FtpUtil ftp = new FtpUtil(ftpIp, 21);
		System.out.println("connect..");

		try{
			if (!ftpIp.trim().equalsIgnoreCase("null") && !ftpIp.equals("") && ftpIp != null) {

				ftp.connect();
				ftp.login(FtpId, FtpPw);
				System.out.println("dirPath Move : " + dirPath);

				if(ftp.cd(dirPath)){
					flag = ftp.putFileUpLoad(dirPath, fileName);
				}
				//              ftp.closeConnect();
				System.out.println("Upload Success!! Close Connection..");
			}
		}catch(Exception e){
			return flag;
		}finally{
			ftp.closeConnect();
		}

		return flag;
	}


	/*
   public static void main(String args[]){
       String ip1 = "40.1.1.89/home/ems/IMAS/novitas/upload";
          String ip2 = null;
          String ip3 = null;
          String ftpIp = null;
          String ftpPath = null;

       ftpIp = ip1.substring(0,ip1.indexOf("/"));
              System.out.println("ftpIp : " + ftpIp);
              FtpUtil ftp = new FtpUtil(ftpIp,21);
              ftp.connect();
              ftp.login("ems","imsi00");
              ftpPath = ip1.substring(ip1.indexOf("/"));
              ftp.cd(ftpPath);
              System.out.println("ftpPath : " + ftpPath);
              ftp.putFileUpLoad("D:/novitas/www/sscard/bill/200711","20071201_01NY.jpg");
              System.out.println("Path & File : " + "D:/novitas/www/sscard/bill/200711"+"/"+"20071201_01NY.jpg");
              ftp.closeConnect();

   }
	 */
}
