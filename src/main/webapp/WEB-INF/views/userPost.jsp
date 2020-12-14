<%--
  Created by IntelliJ IDEA.
  User: haidai
  Date: 2018/12/22
  Time: 21:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="${cp}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${cp}/css/style.css" rel="stylesheet">

    <script src="${cp}/js/jquery.min.js" type="text/javascript"></script>
    <script src="${cp}/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${cp}/js/layer.js" type="text/javascript"></script>

    <!--[if lt IE 9]>
    <script src="${cp}/js/html5shiv.min.js"></script>
    <script src="${cp}/js/respond.min.js"></script>
    <![endif]-->
    <title>我的帖子/评论</title>
</head>
<body bgcolor="#303F9F">
<jsp:include page="include/header.jsp"/>
<div class="row" style="background-color: #303F9F">
    <div class="col-sm-1 col-md-1 col-lg-1"></div>
    <div class="col-sm-10 col-md-10 col-lg-10">
        <a href="#" onclick="listPosts()" style="color: white">显示帖子</a>
        <a href="#" onclick="listReply()" style="color: white">显示评论</a>
        <table class="table CommentTable" border="0" id="Post" style="color: white;">
        </table>
        <hr/>
    </div>
</div>
<div class="col-sm-11 col-sm-offset-1 col-md-11 col-md-offset-1">
    <jsp:include page="include/foot.jsp"/>
</div>
    <script>
        listPosts();
        function getPosts() {
            var Post = "";
            var user = {};
            user.userId = ${currentUser.id};
            $.ajax({
                async: false, //设置同步
                type: 'POST',
                url: '${cp}/getPostByUserId',
                data: user,
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
        function listPosts() {
            var Posts = getPosts();
            var PostsTable = document.getElementById("Post");
            var html = "";
            PostsTable.innerHTML="";
            html += '<tr>' +
                '<th>' + "所发帖商品"+ '</th>' +
                '<td>' + "帖子标题"+ '</td>' +
                '<td>' + "发帖时间"+ '</td>'+
                '<td>' +  "操作" +'</td>'+
            '</tr>';
            for (var i = 0; i < Posts.length; i++) {
                var product = getProductById(Posts[i].productId);
                html += '<tr>' +
                    '<th>' + product.name + '</th>' +
                    '<td>' +'<a href="#" onclick="PostDetail('+Posts[i].id+')" style="color:white">'+Posts[i].title +'</a>' + '</td>' +
                    '<td>' + Posts[i].time + '</td>' +
                    '<td>' + '<button class="btn btn-primary btn-sm" type="submit" onclick="deletePost('+Posts[i].id+')">删除</button>' + '</td>' +
                    '</tr>';
            }
            PostsTable.innerHTML += html;


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
        function deletePost(postId) {
            var post = {};
            post.id = postId;
            var deleteResult = "";
            $.ajax({
                async : false,
                type : 'POST',
                url : '${cp}/deletePostByPostId',
                data : post,
                dataType : 'json',
                success : function(result) {
                    deleteResult = result;
                },
                error : function(result) {
                    layer.alert('查询用户错误');
                }
            });
            layer.alert('删除成功');
            listPosts();
        }
        function deleteReply(replyId) {
            var reply = {};
            reply.id = replyId;
            var deleteResult = "";
            $.ajax({
                async : false,
                type : 'POST',
                url : '${cp}/deleteReplyByReplyId',
                data : reply,
                dataType : 'json',
                success : function(result) {
                    deleteResult = result;
                },
                error : function(result) {
                    layer.alert('查询用户错误');
                }
            });
            layer.alert('删除成功');
            listReply();
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
        function getReply() {
            var Reples = "";
            var user = {};
            user.userId = ${currentUser.id};
            $.ajax({
                async: false, //设置同步
                type: 'POST',
                url: '${cp}/getReplyByUserId',
                data: user,
                dataType: 'json',
                success: function (result) {
                    Reples = result.result;
                },
                error : function(XmlHttpRequest) {
                    alert(XmlHttpRequest.responseText)
                }
            });
            Reples = eval("(" + Reples + ")");
            return Reples;

        }
        function listReply() {
            var Replies = getReply();
            var ReplyTable = document.getElementById("Post");
            var html = "";
            ReplyTable.innerHTML="";
            html += '<tr>' +
                '<th>' + "回帖标题"+ '</th>' +
                '<td>' + "回复内容"+ '</td>' +
                '<td>' + "回复时间"+ '</td>' +
                '<td>' + "操作"+ '</td>' +
                '</tr>';
            for (var i = 0; i < Replies.length; i++) {
                var post = getPostByPostId(Replies[i].postId);
                html += '<tr>' +
                    '<th>' + '<a href="#" onclick="PostDetail('+post.id+')" style="color:white">'+post.title +'</a>'+ '</th>' +
                    '<td>' + Replies[i].content+ '</td>' +
                    '<td>' + Replies[i].time + '</td>' +
                    '<td>' + '<button class="btn btn-primary btn-sm" type="submit" onclick="deleteReply('+Replies[i].id+')">删除</button>' + '</td>' +
                    '</tr>';
            }
            ReplyTable.innerHTML += html;
        }

        function getPostByPostId(id) {
            var postResult = "";
            var post = {};
            post.id = id;
            $.ajax({
                async: false, //设置同步
                type: 'POST',
                url: '${cp}/getPostByPostId',
                data: post,
                dataType: 'json',
                success: function (result) {
                    postResult = result.result;
                },
                error: function (result) {
                    layer.alert('查询错误');
                }
            });
            postResult = JSON.parse(postResult);
            return postResult;
        }
    </script>

</body>
</html>
