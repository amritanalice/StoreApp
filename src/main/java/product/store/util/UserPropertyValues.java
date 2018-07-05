package product.store.util;


import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import product.store.model.User;


public class UserPropertyValues {
	

		List<User> users = new ArrayList<User>();
		public List<User> getUsers() throws IOException {
			List<User> users = new ArrayList<User>();
			InputStream inputStream=null;
			String result=null;
			try {
				Properties prop = new Properties();
				String propFileName = "user.properties";

				inputStream = getClass().getClassLoader().getResourceAsStream(propFileName);

				if (inputStream != null) {
					prop.load(inputStream);
				} else {
					throw new FileNotFoundException("property file '" + propFileName + "' not found in the classpath");
				}

				int userCount = Integer.parseInt(prop.getProperty("userCount","2"));
				for(int i=1; i<=userCount;i++) {
					User user = new User(prop.getProperty("user"+i),prop.getProperty("password"+i));
					users.add(user);
				}

				System.out.println("users="+users);
			} catch (Exception e) {
				System.out.println("Exception: " + e);
			} finally {
				inputStream.close();
			}
			return users;
		}

		public boolean validateUser(User user) {
			boolean isUserAuthenticated = false;
			if(users == null || users.isEmpty()) {
				try {
					users = getUsers();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					System.out.println("IOException Occurred"+ e.getMessage());
					return isUserAuthenticated;
				}
			}
			for(User userTmp: users) {
				if(user.getUsername().equalsIgnoreCase(userTmp.getUsername())) {
					if(user.getPassword().equals(userTmp.getPassword())){
						isUserAuthenticated = true;
						break;
					}
				}
			}
			return isUserAuthenticated;
		}
	}

