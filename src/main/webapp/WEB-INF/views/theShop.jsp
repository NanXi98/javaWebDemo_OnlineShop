<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>进入店铺</title>

    <link href="${cp}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${cp}/css/style.css" rel="stylesheet">

    <script src="${cp}/js/jquery.min.js" type="text/javascript"></script>
    <script src="${cp}/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${cp}/js/layer.js" type="text/javascript"></script>

    <!--[if lt IE 9]>
    <script src="${cp}/js/html5shiv.min.js"></script>
    <script src="${cp}/js/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<!--导航栏部分-->
<jsp:include page="include/header.jsp"/>

<!-- 中间内容 -->
<div class="container-fluid">
    <div class="row">
        <!-- 控制栏 -->
        <div class="col-sm-3 col-md-2 sidebar sidebar-1" >
            <ul class="nav nav-sidebar">
                <li class="list-group-item-diy"><a href="#section1" id="owner"><span class="sr-only">(current)</span></a></li>
            </ul>
        </div>
        <!-- 控制内容 -->
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="col-md-12">
                <hr/>
                <h1><a name="section1" style="color: black;" id="ownerName">此店铺内商品</a></h1>
                <hr/>
                <div class="col-lg-12 col-md-12 col-sm-12" id="productArea"></div>
                <br/>
            </div>
        </div>
    </div>
</div>
<!-- 尾部 -->
<jsp:include page="include/foot.jsp"/>
<script type="text/javascript">
    var loading = layer.load(0);//加载动画
    layer.close(loading);

    listAllProductById();

    //列出所有产品
    function listAllProductById() {
        var productArea = document.getElementById("productArea");
        var allProduct = getAllProductsById();
        var owner=getOwnerByProductId(allProduct[0].id);
        $('#owner').html(owner.name);
        var html="";
        productArea.innerHTML = '';
        for(var i=0;i<allProduct.length;i++){
            var imgURL = "${cp}/img/"+allProduct[i].id+".jpg";
            var desc=allProduct[i] .name;

            if(desc.length>13){

                desc=desc.substring(0,13);

            }
            html += '<div class="col-sm-4 col-md-4" >'+
                '<div class="boxes pointer" onclick="productDetail('+allProduct[i].id+')">'+
                '<div class="big bigimg">'+
                '<img src="'+imgURL+'"  class= "img-responsive center-block" >'+
                '</div>'+
                '<p class="product-name" style="color:black">'+desc+'</p>'+
                '<p class="product-price" style="text-align: left">'+ '<span style="margin-left: 24px;">￥'   +allProduct[i].price+'</span></p>'+
                '</div>'+
                '</div>';
        }
        productArea.innerHTML+=html;
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
    //列出所有商品
    function getAllProductsById() {
        var allProductsById = null;
        var product = {};
        product.id = ${shop};
        $.ajax({
            async : false, //设置同步
            type : 'POST',
            url : '${cp}/getAllProductsById',
            data : product ,
            dataType : 'json',
            success : function(result) {
                if (result) {
                    allProductsById = result.allProductsById;
                }
                else{
                    layer.alert('查询所有商品错误1');
                }
            },
            error : function(resoult) {
                layer.alert('查询所有商品错误2');
            }
        });
        allProductsById = eval("("+allProductsById+")");
        return allProductsById;
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
</script>
</body>
</html>
