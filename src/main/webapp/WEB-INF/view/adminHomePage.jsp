<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="product.store.model.Product"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="http://ajax.microsoft.com/ajax/jQuery.Validate/1.6/jQuery.Validate.min.js"></script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 
List<Product> eList = (List<Product>)application.getAttribute("productList");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Page</title>
</head>
<script type="text/javascript">
function showAllProduct(){
	$.ajax({
		type: "POST",
		url: "/showAllProduct",
		success: function(data){

			var html = '<tr>'+ 
			'<th>Product Id</th>'+
			'<th>Product Name</th>'+
			'<th>Quantity</th>'+'</tr>';
			var i;
			for(i=0; i<data.length; i++){
			
				html +='<tr>'+
							'<td>'+data[i].quantity+'</td>'+
							'<td>'+data[i].productId+'</td>'+
							'<td>'+data[i].productName+'</td>'+
							'<td>'+
								'<a href="javascript:;" class="btn btn-info item-edit" data="'+data[i].productId+'">Edit</a>'+
								'    '+
								'<a href="javascript:;" class="btn btn-danger item-delete" data="'+data[i].productId+'">Delete</a>'+
							'</td>'+
					    '</tr>';
			}
			$('#productListTable').html(html);
		},
		error: function(){
			alert('Could not get Data from Database');
		}
	});
}

</script>

<body>
<h1>Welcome ${username}</h1>
<h2><a href="/addProduct">Add a product</a></h2>
<h2><a href="/updateProduct">Update a product</a></h2>
<h2><a href="/deleteProduct">Delete a product</a></h2>
<h2><a href="/save">Testing</a></h2>
<h3>Product Details</h3>
<hr size="4" color="gray"/>
 <form action="" method="post"  accept-charset="utf-8"
         name="productList" id="productList" >
<table id="productListTable" border=1 bordercolor="orange" bgcolor="Bisque">
<tr>
	<th>Product Id</th>
	<th>Product Name</th>
	<th>Quantity</th>		            

</tr>
</table>
<div class="productListTable" >
		            	</div>
<% if (eList ==  null || eList.isEmpty()){
	out.println("Product list is currently empty");
}
else{ %>
<div class="floatLeft selectWidth15">
<input type="button" id="loading" value="Show All Products" class="greenButton"  onclick="showAllProduct()">
</div>

<%} %>

</form>
</body>
</html>