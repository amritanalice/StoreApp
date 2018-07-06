package com.ibm.mr.inventory.app.controller;

import java.math.BigDecimal;
import java.security.Principal;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.annotation.JsonView;
import com.ibm.mr.inventory.dao.impl.ProductJavaInMemoryStoreDAOImpl;
import com.ibm.mr.inventory.model.Product;
import com.ibm.mr.inventory.util.ProductUtil;
import com.ibm.mr.inventory.views.JsonViews;

@RestController
@RequestMapping("/rest/product")
public class ProductController {

    @Autowired
    ProductJavaInMemoryStoreDAOImpl productJavaStore;

    @JsonView(JsonViews.Public.class)
    @RequestMapping(value = "/getallproductsforuser", method = RequestMethod.GET)
    public List<Product> getAllProductsForUser(Principal principal) {
	String loggedInUser = principal.getName();
	List<Product> productList = productJavaStore.getProductListForUser(loggedInUser);
	System.out.println("Priting all user at" + new Date());
	for (Product product : productList) {
	    System.out.println(product.toString());
	}
	return productList;
    }

    @JsonView(JsonViews.Public.class)
    @RequestMapping(value = "/getallproducts", method = RequestMethod.GET)
    public List<Product> getAllProducts(Principal principal) {
	List<Product> productList = null;
	try {
	    productList = productJavaStore.getAllProducts();
	    System.out.println("Priting all list at" + new Date());
	    for (Product product : productList) {
		System.out.println(product.toString());
	    }
	} catch (Exception ex) {
	    ex.printStackTrace();
	}
	return productList;
    }

    @ResponseBody
    @RequestMapping(value = "/addproduct", method = RequestMethod.POST)
    public String addProduct(Principal principal, @RequestParam("productName") String productName,
	    @RequestParam("productId") int productId, @RequestParam("quantity") int quantity,
	    @RequestParam("productDescription") String productDescription, @RequestParam("price") BigDecimal price) {

	try {
	    String loggedInUser = principal.getName();
	    ProductUtil productUtil = new ProductUtil();
	    Product product = productUtil.addProduct(productId, productName, productDescription, price, quantity,loggedInUser);
	    productJavaStore.addProduct(loggedInUser, product);
	} catch (Exception ex) {
	    ex.printStackTrace();
	    return "Product Add Failed";
	}
	return "Product Added";

    }

    @ResponseBody
    @RequestMapping(value = "/updateproduct", method = RequestMethod.POST)
    public String updateProduct(Principal principal, @RequestParam("productName") String productName,
	    @RequestParam("productId") int productId, @RequestParam("quantity") int quantity,
	    @RequestParam("productDescription") String productDescription, @RequestParam("price") BigDecimal price) {

	try {
	    String loggedInUser = principal.getName();
	    ProductUtil productUtil = new ProductUtil();
	    Product product = productUtil.addProduct(productId, productName, productDescription, price, quantity,loggedInUser);
	    productJavaStore.addProduct(loggedInUser, product);
	} catch (Exception ex) {
	    ex.printStackTrace();
	    return "Product Update  Failed";
	}
	return "Product Updated";

    }

    @ResponseBody
    @RequestMapping(value = "/deleteproduct", method = RequestMethod.POST)
    public String deleteProduct(Principal principal, @RequestParam("productId") int productId) {

	try {
	    String loggedInUser = principal.getName();
	    productJavaStore.deleteProduct(loggedInUser, productId);
	} catch (Exception ex) {
	    ex.printStackTrace();
	    return "Product Delete Failed";
	}
	return "Product Delete";

    }


}
