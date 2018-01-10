package com.bliss.nplay.adminv3.dev;

import com.bliss.nplay.adminv3.business.UserOpsDA;
import com.bliss.nplay.adminv3.model.UserOps;
import com.bliss.nplay.adminv3.model.UserOps.Role;
import com.bliss.nplay.adminv3.model.UserOps.Status;

public class XAccountDev {

	public static void main(String[] args) {
		try {
			UserOps account = new UserOps();
			account.setUserName("admin");
			account.setPassWord("password");
			account.setRole(Role.ADMIN);
			account.setStatus(Status.ACTIVED);
			UserOpsDA.add(account);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
