<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
  <head>
	  <meta charset="utf-8">
	  <meta http-equiv="X-UA-Compatible" content="IE=edge">
	  <meta name="viewport" content="width=device-width, initial-scale=1">
	  <title>IMBM</title>
	  <link href="${cp}/css/bootstrap.min.css" rel="stylesheet">
	  <link href="${cp}/css/style.css" rel="stylesheet">

	  <script src="${cp}/js/jquery.min.js" type="text/javascript"></script>
	  <script src="${cp}/js/bootstrap.min.js" type="text/javascript"></script>
	  <script src="${cp}/js/layer.js" type="text/javascript"></script>
    <!--[if lt IE 9]>

      <script src="${cp}/js/html5shiv.min.js"></script>
      <script src="${cp}/js/js/respond.min.js"></script>
    <![endif]-->
  </head>
  <style>

  </style>

  <body  style="background-color: #5C6BC0">
    <!--导航栏部分-->
	<jsp:include page="include/header.jsp"/>


	<div class="col-sm-2 col-md-2 sidebar" style="background-color: #C5CAE9;">
		<ul class="nav nav-sidebar">
			<li  class="list-group-item-diy" id="1"><a href="#" onclick="pageFirst(1)">冬季新款 <span class="sr-only">(current)</span></a></li>
			<li class="list-group-item-diy" id="2"><a href="#" onclick="pageFirst(2)">数码产品</a></li>
			<li class="list-group-item-diy" id="3"><a href="#" onclick="pageFirst(3)">书籍文学</a></li>
			<li class="list-group-item-diy" id="4"><a href="#" onclick="pageFirst(4)">游戏手办</a></li>
			<li class="list-group-item-diy" id="5"><a href="#" onclick="pageFirst(5)">生活百货</a></li>
			<li class="list-group-item-diy" id="6"><a href="#" onclick="pageFirst(6)">化妆用品</a></li>
			<li class="list-group-item-diy" id="7"><a href="#" onclick="pageFirst(7)">运动潮流</a></li>
		</ul>
	</div>
	<!-- 中间内容 -->
	<div class="container-fluid" name="right" >
			<!-- 控制栏 -->
			<!----------------------------------------------------------------------------------------------->

				<div class="col-sm-10 col-sm-offset-2 col-md-10 col-md-offset-2 main" id="show">
			<div id="myCarousel" class="carousel slide" style="width: auto;height: 600px; ">
				<!-- 轮播（Carousel）指标 -->
				<ol class="carousel-indicators">
					<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
					<li data-target="#myCarousel" data-slide-to="1"></li>
					<li data-target="#myCarousel" data-slide-to="2"></li>
					<li data-target="#myCarousel" data-slide-to="3"></li>
					<li data-target="#myCarousel" data-slide-to="4"></li>
					<li data-target="#myCarousel" data-slide-to="5"></li>
				</ol>
				<!-- 轮播（Carousel）项目 -->
				<div class="carousel-inner" >
					<div class="item active">
						<img src="${cp}/img/banner1.jpg" class= "img-responsive center-block" alt="First slide"   >
					</div>
					<div class="item">
						<img src="${cp}/img/banner2.jpg" class= "img-responsive center-block" alt="Second slide">
					</div>
					<div class="item">
						<img src="${cp}/img/banner3.jpg" class= "img-responsive center-block" alt="Third slide">
					</div>
					<div class="item ">
						<img src="${cp}/img/banner4.jpg" class= "img-responsive center-block" alt="forth slide">
					</div>
					<div class="item">
						<img src="${cp}/img/banner5.jpg" class= "img-responsive center-block" alt="fifth slide">
					</div>
					<div class="item">
						<img src="${cp}/img/banner6.jpg" class= "img-responsive center-block" alt="sixth slide">
					</div>
				</div>
				<!-- 轮播（Carousel）导航 -->
				<a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
					<span  aria-hidden="true"></span>
					<span class="sr-only">Previous</span>
				</a>
				<a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
					<span  aria-hidden="true"></span>
					<span class="sr-only">Next</span>
				</a>
			</div>




					</div>
		</div>
			<!----------------------------------------------------------------------------------------------->
	<div >
		<input type="button" id="prev_text" value="上一页" onclick="pagePrevQuery()">
		<input type="button" id="currentpage" value="1">
		<input type="button" id="next_text" value="下一页" onclick="pageNextQuery()">
	</div>
			<!-- 控制内容 -->



			<div class="col-sm-11 col-sm-offset-1 col-md-11 col-md-offset-1">
				<jsp:include page="include/foot.jsp"/>

			</div>


  <script type="text/javascript">

	  //var loading = layer.load(0);

      var productType = new Array;
      productType[1] = "冬季新款";
      productType[2] = "数码产品";
      productType[3] = "书籍文学";
      productType[4] = "游戏手办";
      productType[5] = "生活百货";
      productType[6] = "化妆用品";
      productType[7] = "运动潮流";


	  //listProducts();
	  function listProducts() {
		  var allProduct = getAllProducts();
          var mark = new Array;
          mark[1] = 0;
          mark[2] = 0;
          mark[3] = 0;
          mark[4] = 0;
          mark[5] = 0;
          mark[6] = 0;
          mark[7] = 0;
          for(var i=0;i<allProduct.length;i++){
              var owner=getOwnerByProductId(allProduct[i].id);
              var html = "";
			  var imgURL = "${cp}/img/"+allProduct[i].id+".jpg";
			  html += '<div class="col-sm-4 col-md-4" >'+
					  '<div class="boxes pointer" onclick="productDetail('+allProduct[i].id+')">'+
					  '<div class="big bigimg">'+
					  '<img src="'+imgURL+'"  class= "img-responsive center-block" >'+
					  '</div>'+
					  '<p class="product-name" style="color:black">'+allProduct[i].name+'</p>'+
					  '<p class="product-price" style="text-align: left">'+  '<span style="font-size: smaller;margin-left: 12px;color:#FF80AB">'+ owner.name  + ' </span><span style="margin-left: 24px;">￥'   +allProduct[i].price+'</span></p>'+
					  '</div>'+
					  '</div>';
              var id = "productArea"+allProduct[i].type;
              var productArea = document.getElementById(id);
              if(mark[allProduct[i].type] === 0){
                  html ='<hr/><h1>'+productType[allProduct[i].type]+'</h1><hr/>'+html;
                  mark[allProduct[i].type] = 1;
              }
              productArea.innerHTML += html;
		  }
		  layer.close(loading);
	  }


	  function getOwnerByProductId(id) {
          var userResult = "";
          var productId = {};
          productId.id = id;
          $.ajax({
              async : false, //设置同步
              type : 'POST',
              url : '${cp}/getOwnerByProductId',
              data : productId,
              dataType : 'json',
              success : function(result) {
                  userResult = result.result;
              },
              error : function(result) {
                  layer.alert('查询错误');
              }
          });
          userResult = eval("("+userResult +")");
          return userResult;


      }
	  function getAllProducts() {
		  var allProducts = null;
		  var nothing = {};
		  $.ajax({
			  async : false, //设置同步
			  type : 'POST',
			  url : '${cp}/getAllProducts',
			  data : nothing,
			  dataType : 'json',
			  success : function(result) {
				  if (result!==null) {
					  allProducts = result.allProducts;
				  }
				  else{
					  layer.alert('查询错误');
				  }
			  },
			  error : function(resoult) {
				  layer.alert('查询错误');
			  }
		  });
		  allProducts = eval("("+allProducts+")");
		  return allProducts;
	  }

	  function getProductByType(type) {
          var partProducts = null;
          var mytype = {};
          mytype.type = type;
          $.ajax({
              async : false, //设置同步
              type : 'POST',
              url : '${cp}/getProductByType',
              data : mytype,
              dataType : 'json',
              success : function(result) {
                  if (result!==null) {
                      partProducts = result.result;
                  }
                  else{
                      layer.alert('查询错误');
                  }
              },
              error : function(result) {
                  layer.alert('查询错误');
              }
          });
          partProducts = eval("("+partProducts+")");
          return partProducts;
      }

		  function listProductByType(type) {
              //layer.close(loading);
              var partProduct = getProductByType(type);
              //alert(partProduct[1].userId);
              var productArea = document.getElementById("show");
              productArea.innerHTML = '<div class="col-sm-10 col-sm-offset-2 col-md-10 col-md-offset-2 main" style="color:#C5CAE9" id="showProduct">\n' +
                  '\t\t\t\t<div align="center">\n' +
                  '\t\t\t\t<h1>'+productType[type]+'</h1>\n' +
                  '\t\t\t\t</div>';
              for(var i=0;i<partProduct.length;i++){
                  var owner=getOwnerByProductId(partProduct[i].id);
                  var html = "";
                  var imgURL = "${cp}/img/"+partProduct[i].id+".jpg";
                  html += '<div class="col-sm-4 col-md-4" >'+
                      '<div class="boxes pointer" onclick="productDetail('+partProduct[i].id+')">'+
                      '<div class="big bigimg">'+
                      '<img src="'+imgURL+'"  class= "img-responsive center-block" >'+
                      '</div>'+
                      '<p class="product-name" style="color:black">'+partProduct[i].name+'</p>'+
                      '<p class="product-price" style="text-align: left">'+  '<span style="font-size: smaller;margin-left: 12px;color:#FF80AB">'+ owner.name  + ' </span><span style="margin-left: 24px;">￥'   +partProduct[i].price+'</span></p>'+
                      '</div>'+
                      '</div>';

                  productArea.innerHTML += html;
              }


          }

	  function productDetail(id) {
		  var product = {};
		  var jumpResult = '';
		  product.id = id;
		  $.ajax({
			  async : false, //设置同步
			  type : 'POST',
			  url : '${cp}/productDetail',
			  data : product,
			  dataType : 'json',
			  success : function(result) {
				  jumpResult = result.result;
			  },
			  error : function(resoult) {
				  layer.alert('查询错误');
			  }
		  });

		  if(jumpResult === "success"){
			  window.location.href = "${cp}/product_detail";
		  }
	  }
      $('.carousel').carousel({
          interval: 2000
      })

      function pagePrevQuery(myType) {
          var pageNum=parseInt(document.getElementById("currentpage").value);
          if(pageNum>=2)
          {
              $.ajax({
                  type: "POST",
                  //返回结果转换成json,方便用data属性的方式取值
                  dataType: "json",
                  url: "${cp}/findAllJson" ,
                  data:{"type":myType,"pageNum":pageNum-1,"pageSize":6},
                  success: function(result) {
                      var totalPage=result.totalPage;

                      var productArea = document.getElementById("show");
                      if(productArea.innerHTML!=null)
                      {
                          productArea.innerHTML="";
                      }
                      productArea.innerHTML = '<div class="col-sm-10 col-sm-offset-2 col-md-10 col-md-offset-2 main" style="color:#C5CAE9" id="showProduct">\n' +
                          '\t\t\t\t<div align="center">\n' +
                          '\t\t\t\t<h1>'+productType[myType]+'</h1>\n' +
                          '\t\t\t\t</div>';
                      for(var i=0;i<result.dataList.length;i++){
                          var owner=getOwnerByProductId(result.dataList[i].id);
                          var html = "";
                          var imgURL = "${cp}/img/"+result.dataList[i].id+".jpg";
                          var desc=result.dataList[i] .name;

                          if(desc.length>13){

                              desc=desc.substring(0,13);

                          }
                          html += '<div class="col-sm-4 col-md-4" >'+
                              '<div class="boxes pointer" onclick="productDetail('+result.dataList[i].id+')">'+
                              '<div class="big bigimg">'+
                              '<img src="'+imgURL+'"  class= "img-responsive center-block" >'+
                              '</div>'+
                              '<p class="product-name" style="color:black">'+desc+'</p>'+
                              '<p class="product-price" style="text-align: left">'+  '<span style="font-size: smaller;margin-left: 12px;color:#FF80AB">'+ owner.name  + ' </span><span style="margin-left: 24px;">￥'   +result.dataList[i].price+'</span></p>'+
                              '</div>'+
                              '</div>';

                          productArea.innerHTML += html;
                      }
                      productArea.innerHTML +=
                          '<div  style="width:200px" ><font style="color:transparent">页码</font>'+
                          '</div>'+
                          '<div align="center">'+
                          '<input type="button" id="prev_text" value="上一页" onclick="pagePrevQuery('+myType+')">'+
                          '<input type="button" id="currentpage" value="1">'+
                          ' <input type="button" id="next_text" value="下一页" onclick="pageNextQuery('+myType+')">'+
                          '</div>'
                      document.getElementById("currentpage").value=pageNum-1;
                  }
              })
          }
          else {
              return false;
          }
      }
      function pageNextQuery(myType) {
          var pageNum=parseInt(document.getElementById("currentpage").value);

          $.ajax({
              type: "POST",
              //返回结果转换成json,方便用data属性的方式取值
              dataType: "json",
              url: "${cp}/findAllJson" ,
              data:{"type":myType,"pageNum":pageNum+1,"pageSize":6},
              success: function(result) {
                  var totalPage=result.totalPage;
                  var productArea = document.getElementById("show");
                  if(pageNum>=totalPage){
                      return false;
                  }
                  if(productArea.innerHTML!=null)
                  {
                      productArea.innerHTML="";
                  }
                  productArea.innerHTML = '<div class="col-sm-10 col-sm-offset-2 col-md-10 col-md-offset-2 main" style="color:#C5CAE9" id="showProduct">\n' +
                      '\t\t\t\t<div align="center">\n' +
                      '\t\t\t\t<h1>'+productType[myType]+'</h1>\n' +
                      '\t\t\t\t</div>';
                  for(var i=0;i<result.dataList.length;i++){
                      var owner=getOwnerByProductId(result.dataList[i].id);
                      var html = "";
                      var imgURL = "${cp}/img/"+result.dataList[i].id+".jpg";
                      var desc=result.dataList[i] .name;

                      if(desc.length>13){

                          desc=desc.substring(0,13);

                      }
                      html += '<div class="col-sm-4 col-md-4" >'+
                          '<div class="boxes pointer" onclick="productDetail('+result.dataList[i].id+')">'+
                          '<div class="big bigimg">'+
                          '<img src="'+imgURL+'"  class= "img-responsive center-block" >'+
                          '</div>'+
                          '<p class="product-name" style="color:black">'+desc+'</p>'+
                          '<p class="product-price" style="text-align: left">'+  '<span style="font-size: smaller;margin-left: 12px;color:#FF80AB">'+ owner.name  + ' </span><span style="margin-left: 24px;">￥'   +result.dataList[i].price+'</span></p>'+
                          '</div>'+
                          '</div>';

                      productArea.innerHTML += html;
                  }
                  productArea.innerHTML +=
                      '<div  style="width:200px" ><font style="color:transparent">页码</font>'+
                      '</div>'+
                      '<div  align="center">'+
                      '<input type="button" id="prev_text" value="上一页" onclick="pagePrevQuery('+myType+')">'+
                      '<input type="button" id="currentpage" value="1">'+
                      ' <input type="button" id="next_text" value="下一页" onclick="pageNextQuery('+myType+')">'+
                      '</div>'
                  document.getElementById("currentpage").value=pageNum+1;
              }
          })
      }
      function pageFirst(myType) {
          $.ajax({
              type: "POST",
              //返回结果转换成json,方便用data属性的方式取值
              dataType: "json",
              url: "${cp}/findAllJson" ,
              data:{"type":myType,"pageNum":1,"pageSize":6},
              success: function(result) {
                  //加载结果的JSON字符串
                  var totalPage=result.totalPage;

                  var productArea = document.getElementById("show");
                  if(productArea.innerHTML!=null)
                  {
                      productArea.innerHTML="";
                  }
                  productArea.innerHTML = '<div class="col-sm-10 col-sm-offset-2 col-md-10 col-md-offset-2 main" style="color:#C5CAE9" id="showProduct">\n' +
                      '\t\t\t\t<div align="center">\n' +
                      '\t\t\t\t<h1>'+productType[myType]+'</h1>\n' +
                      '\t\t\t\t</div>';
                  for(var i=0;i<result.dataList.length;i++){
                      var owner=getOwnerByProductId(result.dataList[i].id);
                      var html = "";
                      var imgURL = "${cp}/img/"+result.dataList[i].id+".jpg";
                      var desc=result.dataList[i] .name;

                      if(desc.length>13){

                          desc=desc.substring(0,13);

                      }

                      html += '<div class="col-sm-4 col-md-4" >'+
                          '<div class="boxes pointer" onclick="productDetail('+result.dataList[i].id+')">'+
                          '<div class="big bigimg">'+
                          '<img src="'+imgURL+'"  class= "img-responsive center-block" >'+
                          '</div>'+
                          '<p class="product-name" style="color:black">'+desc+'</p>'+
                          '<p class="product-price" style="text-align: left">'+  '<span style="font-size: smaller;margin-left: 12px;color:#FF80AB">'+ owner.name  + ' </span><span style="margin-left: 24px;">￥'   +result.dataList[i].price+'</span></p>'+
                          '</div>'+
                          '</div>';

                      productArea.innerHTML += html;
                  }
                  productArea.innerHTML +=
					  // '<div class="col-sm-3 col-md-3">'+'<div>'+
                      '<div  style="width:200px" ><font style="color:transparent">页码</font>'+
                      '</div>'+
					     '<div align="center" style="margin-top=25">'+
						   '<input type="button" id="prev_text" value="上一页" onclick="pagePrevQuery('+myType+')">'+
							  '<input type="button" id="currentpage" value="1">'+
							 ' <input type="button" id="next_text" value="下一页" onclick="pageNextQuery('+myType+')">'+
							  '</div>'

              }
          })
      }

  </script>

  </body>
</html>