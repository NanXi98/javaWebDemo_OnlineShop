<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>IMBM 搜索结果</title>
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
<div class="container">
	<div class="row margin-t">
		<div class="form-horizontal">
			<div class="col-md-2 col-sm-2"></div>
			<div class="form-group form-group-lg col-sm-6 col-md-6">
				<input type="text" class="form-control" id="newSearchKeyWord" placeholder="" />
			</div>
			<button class="btn btn-primary btn-lg col-sm-1 col-md-1 big-button" style="background-color: #FF9800;" onclick="searchPre()">查找商品</button>
			<div class="col-md-2 col-sm-2"></div>
			<select id="sort" onchange="sortMethod();">
				<option value="default" selected>默认排序</option>
				<option value="up">按价格升序</option>
				<option value="down">按价格降序</option>
			</select>
		</div>
	</div>
</div>
<div class="container">
	<div class="row">
		<div id = "searchResultArea">
		</div>
	</div>

</div>


<!-- 尾部 -->
<jsp:include page="include/foot.jsp"/>

<script type="text/javascript">

    searchInit();

    function searchInit() {
        var searchKeyWord = "${searchKeyWord}";
        document.getElementById("newSearchKeyWord").value = searchKeyWord;
        if(searchKeyWord ){
            updateList(searchKeyWord);
        }
    }

    function searchPre() {
        var searchKeyWord = document.getElementById("newSearchKeyWord").value;
        $('#sort').val("default");
        updateList(searchKeyWord);
    }

    function search(searchKeyWord) {
        var search = {};
        search.searchKeyWord = searchKeyWord;
        var searchResult = "";
        $.ajax({
            async : false,
            type : 'POST',
            url : '${cp}/searchProduct',
            data : search,
            dataType : 'json',
            success : function(result) {
                searchResult = result.result;
            },
            error : function() {
                layer.alert('查询错误');
            }
        });
        searchResult = eval("("+searchResult+")");
        return searchResult;
    }

    //排序
    function sortMethod(){
        var sortlist=document.getElementById("sort");
        var search = {};
        search.searchKeyWord = document.getElementById("newSearchKeyWord").value;
        search.selected = sortlist.options[sortlist.selectedIndex].value;
        var searchResult = "";
        //alert(""+selected);
        $.ajax({
            async : false,
            type : 'POST',
            url : '${cp}/sortByPrice',
            data : search,
            dataType : 'json',
            success : function(result) {
                searchResult = result.result;
            },
            error : function() {
                layer.alert('查询错误');
            }
        });
        searchResult = eval("("+searchResult+")");
        var html = "";
        document.getElementById("searchResultArea").innerHTML = "";
        for(var i=0;i<searchResult.length;i++){
            var imgURL = "${cp}/img/"+searchResult[i].id+".jpg";
            html+= '<div class="col-sm-3 col-md-3 search-padding">'+
                '<div class="boxes pointer" onclick="productDetail('+searchResult[i].id+')">'+
                '<div class="big bigimg">'+
                '<img src="'+imgURL+'" class= "img-responsive center-block" />'+
                '</div>'+
                '<p class="product-name">'+searchResult[i].name+'</p>'+
                '<p class="product-price">¥'+searchResult[i].price+'</p>'+
                '</div>'+
                '</div>'+
                '<div class="col-sm-1 col-md-1"></div>';
        }
        document.getElementById("searchResultArea").innerHTML += html;
    }

    function updateList(searchKeyWord) {
        var searchResultArea = document.getElementById("searchResultArea");
        var searchResult = search(searchKeyWord);
        var html = "";
        searchResultArea.innerHTML = "";
        for(var i=0;i<searchResult.length;i++){
            var imgURL = "${cp}/img/"+searchResult[i].id+".jpg";
            var desc=searchResult[i] .name;
            if(desc.length>13){

                desc=desc.substring(0,13);

            }
            html+= '<div class="col-sm-3 col-md-3 search-padding">'+
                '<div class="boxes pointer" onclick="productDetail('+searchResult[i].id+')">'+
                '<div class="big bigimg">'+
                '<img src="'+imgURL+'" class= "img-responsive center-block" />'+
                '</div>'+
                '<p class="product-name">'+desc+'</p>'+
                '<p class="product-price">¥'+searchResult[i].price+'</p>'+
                '</div>'+
                '</div>'+
                '<div class="col-sm-1 col-md-1"></div>';
        }
        searchResultArea.innerHTML += html;
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
            error : function() {
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