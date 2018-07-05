<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="http://ajax.microsoft.com/ajax/jQuery.Validate/1.6/jQuery.Validate.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Product Page</title>
</head>
<script type="text/javascript">
function validateForm(operation){
	console.log("Document is Loaded :: validateForm");
	var returnValue=true;
	var errorStr="";
	var quantity = $('#quantity').val();
	var productId = $('#productId').val();
	var productName = $('#productName').val();

	var error =$('#error');
	console.log('Quantity = '+quantity+' Product Id='+productId+", Product Name="+productName);
	/*$("#loading").attr("disabled","disabled").css({'cursor':'wait'});
	if(!quantity.length){
		console.log('qty is required');
		errorStr+='Quantity is required <br>';
		//error.text('');
		returnValue=false;
	}
	else{
		if(!$.isNumeric(quantity)){
			errorStr+='Quantity must be Numeric <br>';
			returnValue=false;
		}
	}
	if(!itemId.length){
		errorStr+='ItemId is required <br>';
		console.log('Item Id is required');
		returnValue=false;
	}
	if(!itemName.length){
		errorStr+='Item Name is required <br>';
		console.log('Item Name is required');
		returnValue=false;
	}
	console.log('ReturnVal'+returnValue+"--"+(returnValue==true));*/
	if(returnValue==true)
		//populateTheGrid(operation,quantity,productId,productName);
	
		populateNewGrid(operation,quantity,productId,productName);
	
		/*
	error.html(errorStr);
	$("#loading").attr("disabled",false).css({'cursor':'default'});*/
	
	//if(operation='updateAdd')			
			//window.location="./update-success.jsp?itemId="+itemId;
		
	return returnValue;
}

function populateTheGrid(operation,quantity,productId,productName){
	
	console.log('Populate Grid :: operation ='+operation+","+quantity+","+productId+","+productName);
	var returnValue;
	
	$.ajax({
		url: "AddProduct",
		type: "POST",
		data:
			"operation="+operation+
			"&quantity="+quantity+
			"&productId="+productId+
			"&productName="+productName,


			success: function(data, textStatus, jqXHR) {

				console.log("Data inside of Populategrid ::success"+data);
				var parsed = data;
				//parsed = JSON.parse(parsed);
				var taggedData="<tr> " +
				"<th>Quantity</th>" +
				"<th>ProdId</th>" +
				"<th>Item Name</th>" +
				"<th>Delete </th>" +
				"<th>Update</th>" +
				"</tr>";
				console.log("populateTheGrid :: success"+parsed);
				if(operation=='updateAdd')
				{
					window.close();
					constructDataGrid(parsed);
				}
				else
					
					for (var index in data){
						
						console.log(data[index]);
						taggedData += "<tr>" +
						"<td>"+data[index].quantity+"</td>"+
						"<td>"+data[index].productId+"</td>"
						+"<td>"+data[index].productName+"</td>" ;
						
						taggedData +="<td class='center trashBlack' onclick=performOperation('delete','"
									+data[index].quantity+"','"
									+data[index].productId+"','"
									+data[index].productName+"')></td>" 
									+"<td > <input class='center available' onclick=performOperation('update','"
									+data[index].quantity+"','"
									+data[index].productId+"','"
									+data[index].productName+"')></td>" 
									+ "</tr>";
						
						
					}
					$("#instructionText").html(taggedData);
					//constructDataGrid(parsed);

			},
			error: function(jqXHR, textStatus, errorThrown){
				console.log("Something really bad happened " + textStatus +"\t"+jqXHR.responseText +
						'\t'+errorThrown);

			}

	}).done(function( e ) {
		console.log( "word was saved" + e );
	});
	
}

function populateNewGrid(operation,quantity,productId,productName){
	
	console.log('Populate Grid :: operation ='+operation+","+quantity+","+productId+","+productName);
	var returnValue;

	$.ajax({
		url: "AddProduct",
		type: "POST",
		data: "operation="+operation+
		"&quantity="+quantity+
		"&productId="+productId+
		"&productName="+productName,
		
		success: function(response){		
				
				$('#productRegistration')[0].reset();
				if(operation=="add"){
					for (var i in response){
						if(response[i].productId!= null){
							var type = 'added'
						}
					$('.alert-success').html('Product '+type+' successfully').fadeIn().delay(4000).fadeOut('slow');	
					}
				}

				showAllProduct();
			
		},
		error: function(){
			alert('Could not add data');
		}
	});
	
}

function showAllProduct(){
	$.ajax({
		type: "POST",
		url: "/showAllProduct",
		success: function(data){
			
			var html = '';
			var i;
			for(i=0; i<data.length; i++){
				sessionStorage.setItem("id", data[i].productId);
			   var id = data[i].productId;
				html +='<tr>'+
							'<td>'+data[i].quantity+'</td>'+
							'<td>'+data[i].productId+'</td>'+
							'<td>'+data[i].productName+'</td>'+
							'<td>'+
								'<a href="javascript:;" class="btn btn-info item-edit" data="'+data[i].productId+'">Edit</a>'+
								'    '+
								'<a href="javascript:;" class="btn btn-danger item-delete" data="'+data[i].productId+'">Delete</a>'+
								"<td > <input class='center available' value="+ "Update Product"+" onclick=performUpdate('update','"+data[i].productId+"')></td>"+
							'</tr>';
			}
			$('#showdata').html(html);
		},
		error: function(){
			alert('Could not get Data from Database');
		}
	});
	
	$('#showdata').on('click', '.item-edit', function(){
		var id = $(this).attr('data');

		$.ajax({
			type: "POST",
			url: "/updateProductPage",
			data: "&productId="+productId,

			success: function(data){
				
				alert('Opening jsp page');
				window.open('/update?productid='+productId);
			},
			error: function(){
				alert('Could not Edit Data');
			}
		});
	});
	
	$('#showdata').on('click', '.item-delete', function(){
		//var id = $(this).attr('data');
		//$('#deleteModal').modal('show');
		//prevent previous handler - unbind()
		var id = sessionStorage.getItem("id");
		
			$.ajax({
				type: 'ajax',
				method: 'post',
				async: false,
				url: 'deleteProduct',
				data:{productId:id},
				
				success: function(response){
					if(response.success){
						$('#deleteModal').modal('hide');
						$('.alert-success').html('Product Deleted successfully').fadeIn().delay(4000).fadeOut('slow');
						showAllProd();
					}else{
						alert('Error');
					}
				},
				error: function(){
					alert('Error deleting');
				}
			});
		
	});
}

function showAllProd(){
	$.ajax({
		type: "POST",
		url: "/showAllProduct",
		success: function(data){

			var html = '';
			var i;
			for(i=0; i<data.length; i++){
			   var id = data[i].productId;
				html +='<tr>'+
							'<td>'+data[i].quantity+'</td>'+
							'<td>'+data[i].productId+'</td>'+
							'<td>'+data[i].productName+'</td>'+
							'<td>'+
								'<a href="javascript:;" class="btn btn-info item-edit" data="'+data[i].productId+'">Edit</a>'+
								'    '+
								'<a href="javascript:;" class="btn btn-danger item-delete" data="'+data[i].productId+'">Delete</a>'+
								"<td > <input class='center available' value="+ "Update Product"+" onclick=performUpdate('update','"+data[i].productId+"')></td>"+
							'</tr>';
			}
			$('#showdata').html(html);
		},
		error: function(){
			alert('Could not get Data from Database');
		}
	});
}


function performUpdate(operation,productId){
	console.log('performOperation='+operation+',Product Id='+productId);
	var productid = $(productId); 
	
		$.ajax({
			url: "update",
			type: "POST",
			data:"productId="+productid,
				

				success: function(data, textStatus, jqXHR) {
					console.log(data);
					window.open('/update');
					//var parsed = data;
					//parsed = JSON.parse(parsed);
					//console.log("Parsed="+parsed.productJSON[0].quantity);

					//constructDataGrid(parsed);


				},
				error: function(jqXHR, textStatus, errorThrown){
					console.log("Something really bad happened " + textStatus +"\n"+jqXHR.responseText);

				}

		}).done(function( e ) {
			console.log( "word was saved" + e );
		});
	
	

}
</script>
<body>


<div class="container">
    	<div class="orangeText boldText padding10">Home Page: Product Management</div>                
        <div class="headerBarblock">
        	<div class="floatLeft boldText">&minus;</div>
            <div class="floatLeft paddingLeft10">Product Inventory</div>
            <div class="clear"></div>
        </div>

 <form action="" method="post"  accept-charset="utf-8"
         name="productRegistration" id="productRegistration" >
 
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
		                        <input type="button" id="loading" value=" Quick Add " class="greenButton"  onclick="validateForm('add')">
		                    </div> 
		         			<div class="clear"></div>
                            <div class="spacer2"></div>
                            <div class="redText" id="error">
                            
                            <div id= results>Results here </div>
                  </div>
                  <div class="clear"></div>  
                  <div class="sharpblueBar">Added Products 
		             <button value="Refresh Grid" onclick="refreshGrid('none');return false;" class="blueButton">Refresh Grid</button>
		             
		             <button value="Get JSON Data" onclick="refreshGrid('json');return false;" class="blueButton">Get JSON Data</button>
		             <button id="statusId" disabled></button>
		          </div>
		           
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
     </div>
     
    
<h2><a href="/backHome">Back to Admin Home Page</a></h2>
</body>
</html>