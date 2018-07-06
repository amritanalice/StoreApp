package com.ibm.mr.inventory.util;

import java.math.BigDecimal;

import com.ibm.mr.inventory.model.Product;


public class ProductUtil {


    public Product addProduct(int productId, String name, String description, BigDecimal price, int quantity,
	    String user) {

	Product product = new Product();
	product.setId(productId);
	product.setName(name);
	product.setDescription(description);
	product.setPrice(price);
	product.setQuantity(quantity);
	product.setUser(user);
	return product;
    }


}
