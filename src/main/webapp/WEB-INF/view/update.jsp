<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.List"%>
<%@ page import="product.store.model.Product"%>
<% 
List<Product> eList = (List<Product>)application.getAttribute("productList");
String productId = application.getAttribute("EditId").toString();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
I am here

<form action="" method="post"  accept-charset="utf-8"
         name="productUpdate" id="productUpdate" >
 
          <div class="headercontentblock1">                      
            <div class="container1"> 
            	 <div class="floatLeft scanner"></div>
		         <div class="boldText">Scan an product or enter information below</div>
		         
		                    <div class="floatLeft selectWidth15">
		                        <input name="quantity" id="quantity" type="text" class="inputboxBg selectWidth45" size="15" maxlength="15" placeholder="">
		                        <div class="padding10" >*Qty</div>
		                      
		                    </div>
		                    <div class="floatLeft selectWidth25">
		                        <input name="productId"  id="productId" type="text" class="inputboxBg selectWidth80" size="15" maxlength="15" placeholder="">
		                        <div class="padding10">*Product ID, UPC, SIM, or IMEI</div>
		                    </div>
		                    
		                    <div class="floatLeft selectWidth25">
		                        
		                         <label class="custom-select selectWidth90">
		                            
		                            <select  name="productName" id="productName">
		                                <option selected value=""> Please select Product</option>
		                                <option value="Shoe">Shoe</option>
		                                <option value="Phones">Phones </option>
		                                <option value="Clothes">Clothes</option>
		                            </select>
		                        </label>
		                         <div class="padding10">*Product Name</div>
		                    </div>

                    </div>
		                    <div class="floatLeft selectWidth15">
		                        <input type="button" id="loading" value="Save Changes " class="greenButton"  onclick="saveChanges('save')">
		                    </div> 
		         			<div class="clear"></div>
                            <div class="spacer2"></div>
                            <div class="redText" id="error">
                            
                            <div id= results>Results here </div>
                  </div>
                  <div class="clear"></div>  

		           
		            <table id="showdata" border=1>
		            <tr>
		            <th>Quantity</th>
		            <th>Product Id</th>
		            <th>Product Name</th>		            
		            <th>Delete </th>
		            <th>Update</th>
		            </tr>
		            </table>
		              <div class="showdata" >
		            	</div>
		                <div class="spacer2"></div>
		            </div>                                       	                

         </form>
</body>
</html>