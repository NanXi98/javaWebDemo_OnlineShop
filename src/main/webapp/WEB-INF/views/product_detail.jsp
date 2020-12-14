<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>商品详情</title>

    <link href="${cp}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${cp}/css/style.css" rel="stylesheet">
    <link href="${cp}/css/facestyle.css" rel="stylesheet">

    <script src="${cp}/js/jquery.min.js" type="text/javascript"></script>
    <script src="${cp}/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${cp}/js/layer.js" type="text/javascript"></script>
    <script src="${cp}/js/face.js" type="text/javascript"></script>
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
        <div class="col-sm-1 col-md-1"></div>
        <div class="col-sm-10 col-md-10">
            <h1>${productDetail.name}</h1>
            <button class="btn btn-primary btn-lg CommentButton col-sm-1 col-md-1 col-lg-1" style="background-color: #FF9800; float:right; text-align:center" onclick="toTheShop()">进入店铺</button>
            <div>
                <hr/>
            </div>

        </div>
    </div>
    <div class="row">
        <div class="col-sm-1 col-md-1"></div>
        <div class="col-sm-5 col-md-5">
            <img class="detail-img" src="${cp}/img/${productDetail.id}.jpg">
        </div>
        <div class="col-sm-5 col-md-5 detail-x">
            <table class="table table-striped">
                <tr>
                    <th>商品名称</th>
                    <td>${productDetail.name}</td>
                </tr>
                <tr>
                    <th>商品价格</th>
                    <td>${productDetail.price}</td>
                </tr>
                <tr>
                    <th>商品描述</th>
                    <td>${productDetail.description}</td>
                </tr>
                <tr>
                    <th>商品类别</th>
                    <td>${productDetail.type}</td>
                </tr>
                <tr>
                    <th>商品库存</th>
                    <td>${productDetail.counts}</td>
                </tr>
                <tr>
                    <th>购买数量</th>
                    <td>
                        <div class="btn-group" role="group">
                            <button type="button" class="btn btn-default" onclick="subCounts()">-</button>
                            <button id="productCounts" type="button" class="btn btn-default">1</button>
                            <button type="button" class="btn btn-default" onclick="addCounts(1)">+</button>
                        </div>
                    </td>
                </tr>
            </table>
            <div class="row">
                <div class="col-sm-1 col-md-1 col-lg-1"></div>
                <button class="btn btn-danger btn-lg col-sm-4 col-md-4 col-lg-4"
                        onclick="addToShoppingCar(${productDetail.id})">添加购物车
                </button>
                <div class="col-sm-2 col-md-2 col-lg-2"></div>
                <button class="btn btn-danger btn-lg col-sm-4 col-md-4 col-lg-4"
                        onclick="buyConfirm(${productDetail.id})">购买
                </button>

            </div>

        </div>
    </div>
    <div class="row">
        <div class="col-sm-1 col-md-1 col-lg-1"></div>
        <div class="col-sm-10 col-md-10 col-lg-10">

            <hr class="division"/>
            <a href="#" onclick="listPosts()" style="color:white" >查看帖子</a>
            <a href="#" onclick="listComments()" style="color:white" >查看评论</a>
            <table class="table CommentTable" border="0" id="Comment" style="color: white;">
            </table>
            <hr/>
            <div id="inputArea"></div>
        </div>
    </div>
</div>

<!-- 尾部 -->
<jsp:include page="include/foot.jsp"/>
<script type="text/javascript">
      //listComments();//显示评论
        listPosts();

    function addToShoppingCar(productId) {
        judgeIsLogin();
        var productCounts = document.getElementById("productCounts");
        var counts = parseInt(productCounts.innerHTML);
        var shoppingCar = {};
        shoppingCar.userId = ${currentUser.id};
        shoppingCar.productId = productId;
        shoppingCar.counts = counts;
        var addResult = "";
        $.ajax({
            async: false,
            type: 'POST',
            url: '${cp}/addShoppingCar',
            data: shoppingCar,
            dataType: 'json',
            success: function (result) {
                addResult = result.result;
            },
            error: function (result) {
                layer.alert('查询用户错误');
            }
        });
        if (addResult === "success") {
            layer.confirm('前往购物车？', {icon: 1, title: '添加成功', btn: ['前往购物车', '继续浏览']},
                function () {
                    window.location.href = "${cp}/shopping_car";
                },
                function (index) {
                    layer.close(index);
                }
            );
        }
    }

    function judgeIsLogin() {
        if ("${currentUser.id}" === null || "${currentUser.id}" === undefined || "${currentUser.id}" === "") {
            window.location.href = "${cp}/login";
        }
    }

    function subCounts() {
        var productCounts = document.getElementById("productCounts");
        var counts = parseInt(productCounts.innerHTML);
        if (counts >= 2)
            counts--;
        productCounts.innerHTML = counts;
    }

    function addCounts() {
        var productCounts = document.getElementById("productCounts");
        var counts = parseInt(productCounts.innerHTML);
        if (counts <${productDetail.counts})
            counts++;
        else
            layer.msg("库存不足！", {icon: 0})
        productCounts.innerHTML = counts;
    }

    function buyConfirm(productId) {
        var address = getUserAddress(${currentUser.id});
        var phoneNumber = getUserPhoneNumber(${currentUser.id});
        var productCounts = document.getElementById("productCounts");
        var counts = parseInt(productCounts.innerHTML);
        var product = getProductById(productId);
        var html = '<div class="col-sm-1 col-md-1 col-lg-1"></div>' +
            '<div class="col-sm-10 col-md-10 col-lg-10">' +
            '<table class="table confirm-margin">' +
            '<tr>' +
            '<th>商品名称：</th>' +
            '<td>' + product.name + '</td>' +
            '</tr>' +
            '<tr>' +
            '<th>商品单价：</th>' +
            '<td>' + product.price + '</td>' +
            '</tr>' +
            '<tr>' +
            '<th>购买数量：</th>' +
            '<td>' + counts + '</td>' +
            '</tr>' +
            '<tr>' +
            '<th>总金额：</th>' +
            '<td>' + (counts * product.price).toFixed(2) + '</td>' +
            '</tr>' +
            '<tr>' +
            '<th>收货地址：</th>' +
            '<td>' + address + '</td>' +
            '</tr>' +
            '<tr>' +
            '<th>联系电话：</th>' +
            '<td>' + phoneNumber + '</td>' +
            '</tr>' +
            '</table>' +
            '<div class="row">' +
            '<div class="col-sm-4 col-md-4 col-lg-4"></div>' +
            '<button class="btn btn-danger col-sm-4 col-md-4 col-lg-4" onclick="addToShoppingRecords(' + productId + ')">确认购买</button>' +
            '</div>' +
            '</div>';
        layer.open({
            type: 1,
            title: '请确认订单信息：',
            content: html,
            area: ['650px', '350px'],
        });
    }

    function getProductById(id) {
        var productResult = "";
        var product = {};
        product.id = id;
        $.ajax({
            async: false, //设置同步
            type: 'POST',
            url: '${cp}/getProductById',
            data: product,
            dataType: 'json',
            success: function (result) {
                productResult = result.result;
            },
            error: function (result) {
                layer.alert('查询错误');
            }
        });
        productResult = JSON.parse(productResult);
        return productResult;
    }

    function getUserAddress(id) {
        var address = "";
        var user = {};
        user.id = id;
        $.ajax({
            async: false, //设置同步
            type: 'POST',
            url: '${cp}/getUserAddressAndPhoneNumber',
            data: user,
            dataType: 'json',
            success: function (result) {
                address = result.address;
            },
            error: function (result) {
                layer.alert('查询错误');
            }
        });
        return address;
    }

    function getUserPhoneNumber(id) {
        var phoneNumber = "";
        var user = {};
        user.id = id;
        $.ajax({
            async: false, //设置同步
            type: 'POST',
            url: '${cp}/getUserAddressAndPhoneNumber',
            data: user,
            dataType: 'json',
            success: function (result) {
                phoneNumber = result.phoneNumber;
            },
            error: function (result) {
                layer.alert('查询错误');
            }
        });
        return phoneNumber;
    }

    function addToShoppingRecords(productId) {
        judgeIsLogin();
        var productCounts = document.getElementById("productCounts");
        var counts = parseInt(productCounts.innerHTML);
        var shoppingRecord = {};
        shoppingRecord.userId = ${currentUser.id};
        shoppingRecord.productId = productId;
        shoppingRecord.counts = counts;
        var buyResult = "";
        $.ajax({
            async: false,
            type: 'POST',
            url: '${cp}/addShoppingRecord',
            data: shoppingRecord,
            dataType: 'json',
            success: function (result) {
                buyResult = result.result;
            },
            error: function (result) {
                layer.alert('购买错误');
            }
        });
        if (buyResult === "success") {
            layer.confirm('前往订单状态？', {icon: 1, title: '购买成功', btn: ['前往订单', '继续购买']},
                function () {
                    window.location.href = "${cp}/shopping_record";
                },
                function (index) {
                    layer.close(index);
                }
            );
        }
        else if (buyResult === "unEnough") {
            layer.alert("库存不足，购买失败")
        }
    }

      function listComments() {

          var Comments = getComments();

          var CommentTable = document.getElementById("Comment");

          var html = "";

          var inputArea = document.getElementById("inputArea");

          CommentTable.innerHTML = '<tr>'+ '<td colspan="3">' + "评论"+'</td>' +'</tr>'+'<tr>' +

          '<th>' + "用户姓名" + '</th>' +

          '<td>'+ "评论时间" + '</td>'+

          '<td>' + "评论内容" + '</td>' ;

          inputArea.innerHTML =  "";

          var role = ${currentUser.role};

          var id = ${currentUser.id};

          //如果是当前普通用户的评论，则显示删除按钮，可以删除

          //如果当前用户是管理员，则有权限删除所有评论

          if(role===0 || role===2){

              for (var i = 0; i < Comments.length; i++) {

                  var user = getUserById(Comments[i].userId);

                  html += '<tr>' +

                      '<th>' + user.nickName + '</th>' +

                      '<td>'+ Comments[i].time + '</td>'+

                      '<td>' + Comments[i].content + '</td>' ;

                  if(id===Comments[i].userId){

                      html += '<td> <button class="btn btn-primary btn-sm"'+

                          ' onclick="deleteComment('+Comments[i].userId+','+Comments[i].productId+',\''+Comments[i].time+'\')">删除</button>'+

                          '</td>';

                  }

                  else{

                      html += '<td></td>';

                  }

                  html += '</tr>';

              }

              CommentTable.innerHTML += html;

          }

          else{

              for (var i = 0; i < Comments.length; i++) {

                  var user = getUserById(Comments[i].userId);

                  html += '<tr>' +

                      '<th>' + user.nickName + '</th>' +

                      '<td>'+ Comments[i].time + '</td>'+

                      '<td>' + Comments[i].content + '</td>'+

                      '<td> <button class="btn btn-primary btn-sm"'+

                      ' onclick="deleteComment('+Comments[i].userId+','+Comments[i].productId+',\''+Comments[i].time+'\')">删除</button>'+

                      '</td>'+

                      '</tr>';

              }

              CommentTable.innerHTML += html;

          }

          if (getUserProductRecord() === "true") {



              var html2 = "";

              inputArea.innerHTML = html2;

              html2 = '<div class="col-sm-12 col-md-12 col-lg-12">' +

                  '<textarea class="form-control" rows="4" id="CommentText"></textarea>' +

                  '</div>' +

                  '<div class="col-sm-12 col-md-12 col-lg-12">' +

                  '<div class="col-sm-4 col-md-4 col-lg-4"></div>' +

                  '<button class="btn btn-primary btn-lg CommentButton col-sm-4 col-md-4 col-lg-4" style="background-color: #FF9800;" onclick="addToComment()">评价</button>' +

                  '</div>';

              inputArea.innerHTML += html2;

          }



      }

      //删除评论

      function deleteComment(userId, productId, time){

          var comment={};

          comment.userId=userId;

          comment.productId=productId;

          comment.time=time;

          var deleteResult="";

          $.ajax({

              async : false,

              type : 'POST',

              url : '${cp}/deleteShoppingComment',

              data : comment,

              dataType : 'json',

              success : function(result) {

                  deleteResult = result.result;

                  layer.alert('删除成功');

                  listComments();

              },

              error : function(result) {

                  layer.alert('查询错误');

              }

          });

      }


      function listPosts() {
        var Posts = getPosts();
        var PostsTable = document.getElementById("Comment");
        var html = "";
        PostsTable.innerHTML="";
        html += '<tr>' +'<td colspan=3>'+"帖子"+'</td>'+'</tr>'+
            '<tr>' + '<th>' + "发帖人"+ '</th>' +
            '<td>' + "帖子标题"+ '</td>' +
            '<td>' + "发帖时间"+ '</td>'
            '</tr>';
        for (var i = 0; i < Posts.length; i++) {
            var user = getUserById(Posts[i].userId);
            html += '<tr>' +
                '<th>' + user.nickName + '</th>' +
                '<td>' + '<a href="#" onclick="PostDetail('+Posts[i].id+')" style="color:white">'+Posts[i].title +'</a>'+ '</td>' +
                '<td>' + Posts[i].time + '</td>' +
                '</tr>';
        }
        PostsTable.innerHTML += html;

            var inputArea = document.getElementById("inputArea");
            inputArea.innerText = "";
            html = '<div class="col-sm-12 col-md-12 col-lg-12">' +
                '标题<input type="text" class="form-control" id="postTitle"/>' +
                '</div>' +
                '<div class="col-sm-12 col-md-12 col-lg-12">' +
                '<div class="face-box">'+
            '<div class="face-logo">'+
            '<span style="background-color: #FFF">sina表情</span>'+
            '</div>'+
            '<textarea name="face" id="postContent" cols="30" rows="10" placeholder="说点什么呢``" ></textarea>'+
            '<div class="face-sina">'+
            '<div class="face-sina-body">'+
            '<ul class="face-sina-items face-sina-items-show">'+
           ' </ul>'+
            '</div>'+
            '</div>'+
                '<button class="btn btn-primary btn-lg CommentButton col-sm-4 col-md-4 col-lg-4" style="background-color: #FF9800; float: right" onclick="addPost()">发帖</button>' +
                '</div>';
            inputArea.innerHTML += html;


    }

    function getUserProductRecord() {
        var results = "";
        var product = {};
        product.userId = ${currentUser.id};
        product.productId = ${productDetail.id};
        $.ajax({
            async: false, //设置同步
            type: 'POST',
            url: '${cp}/getUserProductRecord',
            data: product,
            dataType: 'json',
            success: function (result) {
                results = result.result;
            },
            error: function (result) {
                layer.alert('查询错误');
            }
        });
        return results;
    }

    function getComments() {
        var Comments = "";
        var product = {};
        product.productId = ${productDetail.id};
        $.ajax({
            async: false, //设置同步
            type: 'POST',
            url: '${cp}/getShoppingComments',
            data: product,
            dataType: 'json',
            success: function (result) {
                Comments = result.result;
            },
            error: function (result) {
                layer.alert('查询错误');
            }
        });
        Comments = eval("(" + Comments + ")");
        return Comments;
    }

    function getPosts() {
        var Post = "";
        var product = {};
        product.productId = ${productDetail.id};
        $.ajax({
            async: false, //设置同步
            type: 'POST',
            url: '${cp}/getPostByProductId',
            data: product,
            dataType: 'json',
            success: function (result) {
                Post = result.result;
            },
            error: function (result) {
                layer.alert('查询错误');
            }
        });
        Post = eval("(" + Post + ")");
        return Post;
    }
    function getUserById(id) {
        var userResult = "";
        var user = {};
        user.id = id;
        $.ajax({
            async: false, //设置同步
            type: 'POST',
            url: '${cp}/getUserById',
            data: user,
            dataType: 'json',
            success: function (result) {
                userResult = result.result;
            },
            error: function (result) {
                layer.alert('查询错误');
            }
        });
        userResult = JSON.parse(userResult);
        return userResult;
    }

    function addToComment() {
        var inputText = document.getElementById("CommentText").value;
        var Comment = {};
        Comment.userId = ${currentUser.id};
        Comment.productId = ${productDetail.id};
        Comment.content = inputText;
        if(Comment.content==="")
        {
            layer.msg('请输入评论内容, {icon: 2, time: 1000}');
            return;
        }
        var addResult = "";
        $.ajax({
            async: false,
            type: 'POST',
            url: '${cp}/addShoppingComment',
            data: Comment,
            dataType: 'json',
            success: function (result) {
                addResult = result.result;
            },
            error: function (result) {
                layer.alert('查询用户错误');
            }
        });
        if (addResult = "success") {
            layer.msg("评价成功", {icon: 1});
            window.location.href = "${cp}/product_detail";
        }
    }
      function addPost() {
          var inputContent = document.getElementById("postContent").value;
          var inputTiltle =document.getElementById("postTitle").value;
          var Post ={};
          Post.userId = ${currentUser.id};
          Post.productId = ${productDetail.id};
          Post.title = inputTiltle;
          Post.content = inputContent;
          if(Post.title==="")
          {
              layer.msg('请填写帖子标题', {icon: 2, time: 1000});
              return;
          }
          if(Post.title.length>=250)
          {
              layer.msg('标题过长', {icon: 2, time: 1000});
              return;
          }
          if(Post.content==="")
          {
              layer.msg('请填写帖子内容', {icon: 2, time: 1000});
              return;
          }
          var addResult = "";
          $.ajax({
              async: false,
              type: 'POST',
              url: '${cp}/addPost',
              data: Post,
              dataType: 'json',
              success: function (result) {
                  addResult = result.result;
              },
              error: function (result) {
                  layer.alert('查询用户错误');
                  alert(arguments[1]);
              }
          });
          if (addResult = "success") {
              layer.msg("发帖成功", {icon: 1});
              window.location.href = "${cp}/product_detail";
          }
      }
      function PostDetail(id) {
          var Post = {};
          var jumpResult = '';
          Post.id = id;
          $.ajax({
              async : false, //设置同步
              type : 'POST',
              url : '${cp}/postDetail',
              data : Post,
              dataType : 'json',
              success : function(result) {
                  jumpResult = result.result;
              },
              error : function(XmlHttpRequest) {
                alert(XmlHttpRequest.responseText)
              }
          });

          if(jumpResult === "success"){
              window.location.href = "${cp}/post_detail";
          }
      }

      //进入此店铺

      function toTheShop(){

          var owner = getOwnerByProductId();

          var ownerId = owner.id;

          var shop = {};

          var jumpResult = '';

          shop.ownerId = ownerId;

          $.ajax({

              async : false, //设置同步

              type : 'POST',

              url : '${cp}/shopDetail',

              data : shop,

              dataType : 'json',

              success : function(result) {

                  jumpResult = result.result;

              },

              error : function(resoult) {

                  layer.alert('查询错误');

              }

          });

          if(jumpResult === "success"){

              window.location.href = "${cp}/theShop";

          }

      }





      function getOwnerByProductId() {

          var userResult = "";

          var productId = {};

          productId.id = ${productDetail.id};

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


</script>
</body>
</html>