package product.store.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import product.store.model.Product;
import product.store.model.User;
import product.store.util.UserPropertyValues;

@Service
public class UserService {

	
	public boolean findByUsernameAndPassword(String username, String password) {
		System.out.println("Username:"+username);
		System.out.println("password:"+password);
		
		return new UserPropertyValues().validateUser(new User(username,password));

		
	}

	public Product saveMyProduct(String quantity, String productId, String productName) {
			
			Product product = new Product();
			product.setProductId(productId);
			product.setProductName(productName);
			product.setQuantity(quantity);
					
			return product;
			
		}

   public List<Product> listMyProduct(Product product) {
     List<Product> list = new ArrayList<Product>();
     list.add(product);
	return list;		
		
	}
	}

