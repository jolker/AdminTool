package com.bliss.nplay.adminv3.dev;

//import java.io.File;
//import java.io.FileInputStream;
//import java.io.FileNotFoundException;
//import java.io.IOException;
//
//import com.bliss.framework.common.Config;
//import com.bliss.nplay.adminv3.utils.SftpUtils;
//import com.jcraft.jsch.Channel;
//import com.jcraft.jsch.ChannelSftp;
//import com.jcraft.jsch.JSch;
//import com.jcraft.jsch.Session;

public class UploadFileDev {
	public static void main(String[] args) {
//		try {
//        	FileInputStream file = new FileInputStream("/home/tiennv/1/nhoctrum.jpg");
//            SftpUtils sftpUtils = new SftpUtils();
//            String result = "";
//            result = sftpUtils.uploadFileToFTP("nhoctrum.jpg", file, true);
//            sftpUtils.deleteFile("cho-con.jpg");
//            System.out.println("Image upload: " + result);
//        }
//       catch (IOException e) {
//            System.out.println("Error when  read file");
//        }
 
    }
	
//	public static void main(String[] args) {
//        String SFTPHOST = "workstation.aws.blisscorp.cc";
//        int SFTPPORT = 22;
//        String SFTPUSER = "sftp";
//        String SFTPPASS = "NjEqnrzSqd";
//        String SFTPWORKINGDIR = "uploads/bliss_admin";
//
//        Session session = null;
//        Channel channel = null;
//        ChannelSftp channelSftp = null;
//
//        try {
//            JSch jsch = new JSch();
//            session = jsch.getSession(SFTPUSER, SFTPHOST, SFTPPORT);
//            session.setPassword(SFTPPASS);
//            java.util.Properties config = new java.util.Properties();
//            config.put("StrictHostKeyChecking", "no");
//            session.setConfig(config);
//            session.connect();
//            channel = session.openChannel("sftp");
//            channel.connect();
//            channelSftp = (ChannelSftp) channel;
//            channelSftp.cd(SFTPWORKINGDIR);
//            File f = new File("/home/tiennv/1/export.json");
//            channelSftp.put(new FileInputStream(f), f.getName());
//        } catch (Exception ex) {
//            ex.printStackTrace();
//        }
//    }
}
