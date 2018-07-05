package product.store.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.ListIterator;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.context.annotation.ApplicationScope;

import product.store.service.UserService;
import product.store.model.Product;

@Controller
public class StoreController implements ServletContextAware {

	@Autowired
	private UserService userService; 
	
    @Autowired
	private ServletContext servletContext;
	
	@RequestMapping("/")
	public String welcome() {
		return "welcome";
	}
	
	@RequestMapping("/dologin")
	public String dologin() {
		return "dologin";
	}
	
	@RequestMapping("/loginAdmin")
	public String verifyLogin(@RequestParam("username") String username,@RequestParam("password") String password,
			HttpSession session, ModelMap model) {
		
		session.setAttribute("username", username);
		
		if(userService.findByUsernameAndPassword(username, password)) {
			return "adminHomePage";
		}
		else
			session.setAttribute("error", "Invalid credentials");
			return "dologin";
	}
	
	@RequestMapping("/addProduct")
	public String addProduct() {
			return "addProduct";
	}
	
	@RequestMapping("/backHome")
	public String backHome() {
			return "adminHomePage";
	}
	
	@PostMapping("/AddProduct")
	public @ResponseBody List<Product> addProduct(@RequestParam("quantity") String quantity,@RequestParam("productId") String productId,@RequestParam("productName") String productName,HttpSession session,HttpServletRequest request) {
		List<Product> productList = (List<Product>) session.getAttribute("productList");
		if (productList!= null) {
			Product product = userService.saveMyProduct(quantity, productId, productName);
			productList.add(product);
			session.setAttribute("productList", productList);
			servletContext.setAttribute("productList", productList);
			return productList;	
	
		}
		else
		{
		Product product = userService.saveMyProduct(quantity, productId, productName);
		List<Product> productListnew = userService.listMyProduct(product);
		session.setAttribute("productList", productListnew);
		servletContext.setAttribute("productList", productListnew);
		return productListnew;
		
		
		}
		
	}
	
	@PostMapping("/showAllProduct")
	public @ResponseBody List<Product> getAllProduct() {
		List<Product> productList = (List<Product>) servletContext.getAttribute("productList");
		if (productList!= null) 
			return productList;
		else 
			return new ArrayList<Product>();
		
	}

	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		
	}
	
	@PostMapping("/updateProductPage")
	public @ResponseBody String updateProduct(@RequestParam("productId") String productId,HttpSession session) {
		servletContext.setAttribute("EditId", productId);
		return "updateProductPage";

		
	}
	
	@RequestMapping("/update")
	public @ResponseBody String update(HttpSession session) {
		//servletContext.setAttribute("EditId", productId);
		return "update";

		
	}
	
	@RequestMapping("/save")
	public String save() {
			return "saveChanges";
	}
	
	@PostMapping("/deleteProduct")
	public @ResponseBody List<Product> deleteProduct(@RequestParam("productId") String productid,HttpSession session) {
		
		List<Product> productList = (List<Product>) servletContext.getAttribute("productList");
		ListIterator<Product> iterator = productList.listIterator();
		while(iterator.hasNext()) {
			if(iterator.next().getProductId().equals(productid)) {
				iterator.remove();
				break;
			}
		}

		session.setAttribute("productList", productList);
		servletContext.setAttribute("productList", productList);
		return productList;
		}
	

}
