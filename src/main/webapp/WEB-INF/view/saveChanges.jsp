<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.List"%>
<%@ page import="product.store.model.Product"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 
List<Product> eList = (List<Product>)application.getAttribute("productList");
eList.get(0).getProductId();
%>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="http://ajax.microsoft.com/ajax/jQuery.Validate/1.6/jQuery.Validate.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<script type="text/javascript">
$(document).ready(function(){
function showAllProduct(productId){
	var html = '';
	$.ajax({
		type: "POST",
		url: "showAllProduct",
		success: function(data){					
				html +='<option value="">Select '+productId+'</option>';	
				for(i=0; i<data.length; i++){
					html +='<option value=" '+data[i].productId+' ">+'</option>';	
				}
		},
		error: function(){
			alert('Could not get Data from Database');
		}
	});
}
});

</script>

<body>
 <form action="" method="post"  accept-charset="utf-8"
         name="productListtable" id="productListtable" >
<table id="productListtable" border=1 bordercolor="orange" bgcolor="Bisque">
<tr>
	<td>Product Id :</td><td><%= eList.get(0).getProductId() %></td>
			            

<td><div class="floatLeft selectWidth25">
		                        
		                         <label class="custom-select selectWidth90">
		                            
		                            <select  name="productId" id="productId">
		                                <option selected value=""> Please select Product</option>
		                               
		                            </select>
		                        </label>
		                         
		                    </div></td></tr>
		                    
		                    <c:forEach items="${eList}"  var="product">
        <tr>
            <td>Product ID:  <c:out value="${product.productId}" /></td>
            <td>Product Name:  <c:out value="${product.productName}" /> </td>  
        </tr>
  </c:forEach>
</table>
<div class="productListTable" >
		            	</div>
		            	
<th>Product Name</th>
<th>Quantity</th>
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