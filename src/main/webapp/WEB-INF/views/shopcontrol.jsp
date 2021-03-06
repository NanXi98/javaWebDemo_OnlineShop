<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>商家控制页面</title>
    <link href="${cp}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${cp}/css/style.css" rel="stylesheet">

    <script src="${cp}/js/jquery.min.js" type="text/javascript"></script>
    <script src="${cp}/js/ajaxfileupload.js" type="text/javascript"></script><!--图片上传插件-->
    <script src="${cp}/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${cp}/js/layer.js" type="text/javascript"></script>
    <script src="${cp}/js/echarts.js" type="text/javascript"></script>
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
                <li class="list-group-item-diy"><a href="#section1">查看本店商品<span class="sr-only">(current)</span></a></li>
                <li class="list-group-item-diy"><a href="#section2">添加商品<span class="sr-only">(current)</span></a></li>
                <li class="list-group-item-diy"><a href="#section3">销量统计<span class="sr-only">(current)</span></a></li>
            </ul>
        </div>
        <!-- 控制内容 -->
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="col-md-12">
                <hr/>
                <h1><a name="section1" style="color: black;">商品信息</a></h1>
                <hr/>
                <div class="col-lg-12 col-md-12 col-sm-12" id="productArea"></div>
                <br/>
            </div>

            <div class="col-md-12">
                <hr/>
                <h1><a name="section2" style="color: black;">添加商品</a></h1>
                <hr/>
                <div class="col-sm-offset-2 col-md-offest-2">
                    <!-- 表单输入 -->
                    <div  class="form-horizontal">
                        <div class="form-group">
                            <label for="productName" class="col-sm-2 col-md-2 control-label">商品名称</label>
                            <div class="col-sm-6 col-md-6">
                                <input type="text" class="form-control" id="productName" placeholder="请填写商品" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="productDescribe" class="col-sm-2 col-md-2 control-label">商品描述</label>
                            <div class="col-sm-6 col-md-6">
                                <textarea type="text" class="form-control" id="productDescribe" placeholder="请输入商品描述"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="keyWord" class="col-sm-2 col-md-2 control-label">关键词</label>
                            <div class="col-sm-6 col-md-6">
                                <textarea type="text" class="form-control" id="keyWord" placeholder="请输入关键词"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="productPrice" class="col-sm-2 col-md-2 control-label">商品价格</label>
                            <div class="col-sm-6 col-md-6">
                                <input type="text" class="form-control" id="productPrice" placeholder="998" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="productCount" class="col-sm-2 col-md-2 control-label">商品数量</label>
                            <div class="col-sm-6 col-md-6">
                                <input type="text" class="form-control" id="productCount" placeholder="100" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="productType" class="col-sm-2 col-md-2 control-label">商品类别</label>
                            <div class="col-sm-6 col-md-6">
                                <select name="productType" class="form-control" id="productType">
                                    <option value="1">衣服配饰</option>
                                    <option value="2">数码产品</option>
                                    <option value="3">书籍办公</option>
                                    <option value="4">游戏周边</option>
                                    <option value="5">生活用品</option>
                                    <option value="6">化妆用品</option>
                                    <option value="7">运动用品</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="productImgUpload" class="col-sm-2 col-md-2 control-label" accept="image/jpg">商品图片</label>
                            <div class="col-sm-6 col-md-6">
                                <input name="productImgUpload" type="file"  id="productImgUpload"/>
                                <p class="help-block" style="color:white;">上传的图片大小应为280*160大小</p>
                            </div>
                            <%--<button class="btn btn-primary col-sm-2 col-md-2" onclick="fileUpload()">上传图片</button>--%>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-6" id="imgPreSee">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-6">
                                <button class="btn btn-lg btn-primary btn-block" type="submit" style="background-color: #FF9800;" onclick="addProduct()">添加商品</button>
                            </div>
                        </div>
                    </div>
                    <br/>
                </div>
            </div>
            <div class="col-md-12">

                <hr/>

                <h1><a name="section3" style="color: black;">销量统计</a></h1>

                <hr/>

                <div class="col-sm-offset-2 col-md-offest-2" id="chart" style="width: 600px;height:400px;" align="center"></div>

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
    var myChart = echarts.init(document.getElementById('chart'));

    var names = new Array();

    var sells = new Array();

    var prices = new Array();

    init();

    function init(){

        var allProduct = getAllProductsById();

        for (var i=0;i<allProduct.length;i++){

            names[i] = allProduct[i].name;

            prices[i] = allProduct[i].price;

            var sell=sellCount(allProduct[i].id);
            sells[i]=0;
            var count =0;

            for(var j=0; j<sell.length;j++){

                count += sell[j].counts;

            }
            sells[i] = count;
        }

    }



    // 指定图表的配置项和数据

    var option = {

        title : {

            text: '各商品销量和价格统计图',

        },

        tooltip : {

            trigger: 'axis'

        },

        legend: {

            data:['销量', '价格']

        },

        toolbox: {

            show : true,

            feature : {

                mark : {show: true},

                dataView : {show: true, readOnly: false},

                magicType: {show: true, type: ['line', 'bar']},

                restore : {show: true},

                saveAsImage : {show: true}

            }

        },

        calculable : true,

        xAxis : [

            {

                type : 'value',

                boundaryGap : [0,1.0]

            }

        ],

        yAxis : [

            {

                type : 'category',

                data : names

            }

        ],

        series : [

            {

                name:'销量',

                type:'bar',

                data:sells

            },

            {

                name:'价格',

                type:'bar',

                data:prices

            }

        ]

    };



    // 使用刚指定的配置项和数据显示图表。

    myChart.setOption(option);


    //销量统计函数

    function sellCount(id){

        var products = "";

        var product = {};

        product.id = id;

        $.ajax({

            async : false,

            type : 'POST',

            url : '${cp}/getShoppingRecordsByProductId',

            data : product,

            dataType : 'json',

            success : function(result) {

                products = result.result;

            },

            error : function(result) {

                layer.alert('查询错误');

            }

        });

        products = eval("("+products+")");

        return products;

    }


    //销量统计函数

    function sellCount(id){

        var products = "";

        var product = {};

        product.id = id;

        $.ajax({

            async : false,

            type : 'POST',

            url : '${cp}/getShoppingRecordsByProductId',

            data : product,

            dataType : 'json',

            success : function(result) {

                products = result.result;

            },

            error : function(result) {

                layer.alert('查询错误');

            }

        });

        products = eval("("+products+")");

        return products;

    }

    //列出所有产品
    function listAllProductById() {
        var productArea = document.getElementById("productArea");
        var allProduct = getAllProductsById();
        var html="";
        productArea.innerHTML = '';
        for(var i=0;i<allProduct.length;i++){
            var imgURL = "${cp}/img/"+allProduct[i].id+".jpg";
            var desc=allProduct[i] .name;

            if(desc.length>13){

                desc=desc.substring(0,13);

            }
            html+='<div class="col-sm-4 col-md-4 pd-5">'+
                '<div class="boxes pointer" onclick="productDetail('+allProduct[i].id+')">'+
                '<div class="big bigimg">'+
                '<img src="'+imgURL+'"   class= "img-responsive center-block"  >'+
                '</div>'+
                '<p class="font-styles center">'+desc+'</p>'+
                '<p class="pull-right">价格：'+allProduct[i].price+'</p>'+
                '<p class="pull-left">库存：'+allProduct[i].counts+'</p>'+
                '<div class = "row">'+
                '<button class="btn btn-primary delete-button" type="submit" onclick="deleteProduct('+allProduct[i].id+')">删除商品</button>'+
                '</div>'+
                '</div>'+
                '</div>';
        }
        productArea.innerHTML+=html;
    }
    //列出所有商品

    function getAllProductsById() {
        var allProductsById = null;
        var product = {};
        product.id = ${currentUser.id};


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

    function deleteProduct(id) {
        var product = {};
        product.id = id;
        var deleteResult = "";
        $.ajax({
            async : false,
            type : 'POST',
            url : '${cp}/deleteProduct',
            data : product,
            dataType : 'json',
            success : function(result) {
                deleteResult = result;
            },
            error : function(result) {
                layer.alert('删除商品错误');
            }
        });
        layer.msg(deleteResult.message);
        listAllProductById();
    }

    function addProduct() {
        var loadings = layer.load(0,{time:1*1000,icon:2});
        var product = {};
        product.name = document.getElementById("productName").value;
        product.description = document.getElementById("productDescribe").value;
        product.keyWord = document.getElementById("keyWord").value;
        product.price = document.getElementById("productPrice").value;
        product.counts = document.getElementById("productCount").value;
        product.type = document.getElementById("productType").value;
        if(product.type===""||product.counts===""||product.description===""||product.keyWord===""||product.name==="")
        {
            layer.msg('请填写完商品信息', {icon: 2, time: 1000});
            return;
        }
        if (parseFloat(product.price)>99999999) {
            layer.msg('请做良心商家！', {icon: 2, time: 1000});
            return;
        }
        <!--product.userId=-->
        product.userId=${currentUser.id};
        var addResult="";
        $.ajax({
            async : false,
            type : 'POST',
            url : '${cp}/addProduct',
            data : product,
            dataType : 'json',
            success : function(result) {
                addResult = result.result;
            },
            error : function(result) {
                layer.alert('添加商品错误');
            }
        });
        if(addResult ) {
            fileUpload(addResult);
            layer.msg('添加商品成功', {icon: 1, time: 1000});
            layer.close(loadings)
        }
        listAllProductById();
    }

    function fileUpload( id) {
        var results = "";
     //   var name = document.getElementById("productName").value;
        $.ajaxFileUpload({//图片上传插件jQuery
            url:'${cp}/uploadFile?id='+id,
            secureuri:false ,
            fileElementId:'productImgUpload',
            type:'POST',
            dataType : 'text',
            success: function (result){
                result = result.replace(/<pre.*?>/g, '');  //ajaxFileUpload会对服务器响应回来的text内容加上<pre style="....">text</pre>前后缀
                result = result.replace(/<PRE.*?>/g, '');
                result = result.replace("<PRE>", '');
                result = result.replace("</PRE>", '');
                result = result.replace("<pre>", '');
                result = result.replace("</pre>", '');
                result = JSON.parse(result);
                results = result.result;
                if(results === "success") {
                    layer.msg("图片上传成功", {icon: 1});
                    window.location.href = "${cp}/shopcontrol";
                    //var imgPreSee = document.getElementById("imgPreSee");
                    //var imgSrc = '${cp}/img/'+name+'.jpg';
                    //imgPreSee.innerHTML +='<img src="'+imgSrc+')" class="col-sm-12 col-md-12 col-lg-12"/>';
                }
                else {
                    layer.msg("图片上传失败", {icon: 0});
                }
            },
            error: function ()
            {
                layer.alert("上传错误");
            }}
        );
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
            window.location.href = "${cp}/change_product";
        }
    }
</script>
</body>
</html>