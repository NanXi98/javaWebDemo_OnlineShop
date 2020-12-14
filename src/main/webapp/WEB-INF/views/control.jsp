<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>管理员控制台</title>
      <link href="${cp}/css/bootstrap.min.css" rel="stylesheet">
      <link href="${cp}/css/style.css" rel="stylesheet">

      <script src="${cp}/js/jquery.min.js" type="text/javascript"></script>

      <script src="${cp}/js/bootstrap.min.js" type="text/javascript"></script>
      <script src="${cp}/js/layer.js" type="text/javascript"></script>

    <!--[if lt IE 9]>
      <script src="${cp}/js/html5shiv.min.js"></script>
      <script src="${cp}/js/respond.min.js"></script>
    <![endif]-->
      <script src="${cp}/js/echarts.js" type="text/javascript"></script>

  </head>
  <body>
    <!--导航栏部分-->
    <jsp:include page="include/header.jsp"/>

    <!-- 中间内容 -->
    <div class="container-fluid">
        <div class="row">
            <!-- 控制栏 -->
            <div class="col-sm-3 col-md-2 sidebar sidebar-1" style="color:#C5CAE9">
                <ul class="nav nav-sidebar">
                    <li class="list-group-item-diy"><a href="#section1">查看所有用户<span class="sr-only">(current)</span></a></li>
                    <li class="list-group-item-diy"><a href="#section2">查看所有商家</a></li>
                    <li class="list-group-item-diy"><a href="#section3">查看所有帖子</a></li>
                    <li class="list-group-item-diy"><a href="#section4">查看所有回复</a></li>
                    <li class="list-group-item-diy"><a href="#chartmain" onclick="getNum(myChart)">各类商品比例</a></li>

                </ul>
            </div>
            <!-- 控制内容 -->
            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                <div class="col-md-12">
                    <h1><a name="section1" style="color: white;">用户信息</a></h1>
                    <hr/>
                    <table class="table table-hover center"  style="color: white;" id="userTable">
                    </table>
                </div>

                <div class="col-md-12">
                    <hr/>
                    <h1><a name="section2"  style="color: white;">商家信息</a></h1>
                    <hr/>
                    <table class="table table-hover center"  style="color: white;" id="shopOwnerArea">
                    </table>
                </div>
                <div class="col-md-12">
                    <hr/>
                    <h1><a name="section3"  style="color: white;">帖子信息</a></h1>
                    <hr/>
                    <table class="table table-hover center"  style="color: white;" id="postArea">
                    </table>
                </div>
                <div class="col-md-12">
                    <hr/>
                    <h1><a name="section4"  style="color: white;">回复信息</a></h1>
                    <hr/>
                    <table class="table table-hover center"  style="color: white;" id="replyArea">
                    </table>
                </div>
                <div class="col-md-12">
                    <hr/>
                    <h1><a name="section2"  style="color: white;">商品比例</a></h1>
                    <hr/>
                    <%--放置echart的容器--%>
                    <div id="chartmain" style="width:600px; height: 400px;"></div>
                    </table>
                </div>

            </div>
            <br/>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <!-- 尾部 -->
    <jsp:include page="include/foot.jsp"/>
  <script type="text/javascript">

    //  var loading = layer.load(0);//加载动画
      listAllUser();
      listAllshopOwner();
      listAllPost();
      listAllReply();
   //   layer.close(loading);
      //列出所有用户
      function listAllUser() {
          var userTable = document.getElementById("userTable");
          var allUser = getAllUsers();
          userTable.innerHTML = '<tr>'+
                                  '<th> 用户ID </th>'+
                                  '<th> 用户名</th>'+
                                  '<th> 昵称</th>'+
                                  '<th> 邮箱</th>'+
                                  '<th> 是否删除</th>'+
                                '</tr>';
          var html = "";
          for(var i=0;i<allUser.length;i++){
              html += '<tr>'+
                      '<td>'+allUser[i].id+'</td>'+
                      '<td>'+allUser[i].name+'</td>'+
                      '<td>'+allUser[i].nickName+'</td>'+
                      '<td>'+allUser[i].email+'</td>'+
                      '<td>'+
                      '<button class="btn btn-primary btn-sm" type="submit" onclick="deleteUser('+allUser[i].id+')">删除</button>'+
                      '</td>'+
                      '</tr>';
          }
          userTable.innerHTML += html;
      }

      function getAllUsers() {
          var allUsers = "";
          var nothing = {};
          $.ajax({
              async : false, //设置同步
              type : 'POST',
              url : '${cp}/getAllUser',
              data : nothing,
              dataType : 'json',
              success : function(result) {
                  if (result!==null) {
                      allUsers = result.allUsers;
                  }
                  else{
                      layer.alert('查询所有用户错误');
                  }
              },
              error : function(resoult) {
                  layer.alert('查询所有用户错误');
              }
          });
          allUsers = eval("("+allUsers+")");//eval（）转换为json对象
          return allUsers;
      }


      function deleteUser(id) {
          var user = {};
          user.id = id;
          var deleteResult = "";
          $.ajax({
              async : false,
              type : 'POST',
              url : '${cp}/deleteUser',
              data : user,
              dataType : 'json',
              success : function(result) {
                  deleteResult = result;
              },
              error : function(result) {
                  layer.alert('查询用户错误');
              }
          });
          layer.alert('删除成功');
          listAllUser();
          listAllshopOwner();
          listAllPost();
          listAllReply();
      }

      function listAllshopOwner() {
          var shopOwnerArea = document.getElementById("shopOwnerArea");
          var allshopOwner = getAllshopOwner();
          shopOwnerArea.innerHTML = '<tr>'+
              '<th> 商家ID </th>'+
              '<th> 用户名</th>'+
              '<th> 昵称</th>'+
              '<th> 邮箱</th>'+
              '<th> 是否删除</th>'+
              '</tr>';
          var html="";
          for(var i=0;i<allshopOwner.length;i++){
              html += '<tr>'+
                  '<td>'+allshopOwner[i].id+'</td>'+
                  '<td>'+allshopOwner[i].name+'</td>'+
                  '<td>'+allshopOwner[i].nickName+'</td>'+
                  '<td>'+allshopOwner[i].email+'</td>'+
                  '<td>'+
                  '<button class="btn btn-primary btn-sm" type="submit" onclick="deleteUser('+allshopOwner[i].id+')">删除</button>'+
                  '</td>'+
                  '</tr>';
          }
          shopOwnerArea.innerHTML+=html;
      }
      //列出所有商品
      function getAllshopOwner() {
          var allShopowners ="";
          var nothing = {};
          $.ajax({
              async : false, //设置同步
              type : 'POST',
              url : '${cp}/getAllShopowners',
              data : nothing,
              dataType : 'json',
              success : function(result) {
                  if (result) {
                      allShopowners = result.allShopowners;
                  }
                  else{
                      layer.alert('查询所有商家错误');
                  }
              },
              error : function(result) {
                  layer.alert('查询所有商家错误');
              }
          });
          allShopowners = eval("("+allShopowners+")");
          return allShopowners;
      }
    function getAllPost() {
        var allPost = null;
        var nothing = {};
        $.ajax({
            async : false, //设置同步
            type : 'POST',
            url : '${cp}/getAllPost',
            data : nothing,
            dataType : 'json',
            success : function(result) {
                if (result!==null) {
                    allPost = result.result;
                }
                else{
                    layer.alert('查询所有用户错误');
                }
            },
            error : function(resoult) {
                layer.alert('查询所有用户错误');
            }
        });
        allPost = eval("("+allPost+")");//eval（）转换为json对象
        return allPost;
    }
    function getAllReply() {
        var allReply = "";
        var nothing = {};
        $.ajax({
            async : false, //设置同步
            type : 'POST',
            url : '${cp}/getAllReply',
            data : nothing,
            dataType : 'json',
            success : function(result) {
                if (result!==null) {
                    allReply = result.result;
                }
                else{
                    layer.alert('查询所有用户错误');
                }
            },
            error : function(resoult) {
                layer.alert('查询所有用户错误');
            }
        });
        allReply = eval("("+allReply+")");//eval（）转换为json对象
        return allReply;
    }

    function listAllPost() {
        var userTable = document.getElementById("postArea");
        var allPost = getAllPost();
        userTable.innerHTML = '<tr>'+
            '<th> 帖子ID </th>'+
            '<th> 帖子的商品名称</th>'+
            '<th> 发帖用户名</th>'+
            '<th> 帖子标题</th>'+
            '<th> 是否删除</th>'+
            '</tr>';
        var html = "";
        for(var i=0;i<allPost.length;i++){
            var user = getUserById(allPost[i].userId);
            var product = getProductById(allPost[i].productId);
            html += '<tr>'+
                '<td>'+allPost[i].id+'</td>'+
                '<td>'+product.name+'</td>'+
                '<td>'+user.nickName+'</td>'+
                '<td>'+allPost[i].title+'</td>'+
                '<td>'+
                '<button class="btn btn-primary btn-sm" type="submit" onclick="deletePost('+allPost[i].id+')">删除</button>'+
                '</td>'+
                '</tr>';
        }
        userTable.innerHTML += html;
    }
    function listAllReply() {
        var userTable = document.getElementById("replyArea");
        var allReply = getAllReply();
        userTable.innerHTML = '<tr>'+
            '<th> 回复ID </th>'+
            '<th> 回复的帖子标题</th>'+
            '<th> 回复用户</th>'+
            '<th> 回复内容</th>'+
            '<th> 是否删除</th>'+
            '</tr>';
        var html = "";
        for(var i=0;i<allReply.length;i++){
            var user = getUserById(allReply[i].userId);
            var post = getPostByPostId(allReply[i].postId);
            html += '<tr>'+
                '<td>'+allReply[i].id+'</td>'+
                '<td>'+post.title+'</td>'+
                '<td>'+user.nickName+'</td>'+
                '<td>'+allReply[i].content+'</td>'+
                '<td>'+
                '<button class="btn btn-primary btn-sm" type="submit" onclick="deleteReply('+allReply[i].id+')">删除</button>'+
                '</td>'+
                '</tr>';
        }
        userTable.innerHTML += html;
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
        listAllUser();
        listAllshopOwner();
        listAllPost();
        listAllReply();
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
        listAllUser();
        listAllshopOwner();
        listAllPost();
        listAllReply();
    }
      <!--
      function deleteshopowner(id) {
          var owner = {};
          owner.id = id;
          alert(owner.id);
          var deleteResult = "";
          $.ajax({
              async : false,
              type : 'POST',
              url : '${cp}/deleteShopownerById',
              data : owner,
              dataType : 'json',
              success : function(result) {
                  deleteResult = result;
              },
              error : function(result) {
                  layer.alert('查询商家错误');

              }
          });
          layer.msg(deleteResult.message);
          listAllshopOwner();
      }
      -->

  </script>
    <script type="text/javascript">
        var myChart = echarts.init(document.getElementById('chartmain'));
        getNum(myChart);
        //指定图标的配置和数据
        function getNum(myChart){
            $.ajax({
                contentType : "application/json",
                type : "GET",
                url : "${cp}/getProductNum",
                dataType : "json",
                success : function(data) {
                    var option = {
                        tooltip: {
                            trigger: 'item',
                            formatter: "{a} <br/>{b}: {c} ({d}%)"
                        },
                        legend: {
                            orient: 'vertical',
                            x: 'left',
                            data:['衣服配饰','数码产品','书籍办公','游戏周边','生活用品','化妆用品','运动用品']
                        },
                        series: [
                            {
                                name:'市场分析',
                                type:'pie',
                                radius: ['40%', '70%'],
                                avoidLabelOverlap: false,
                                label: {
                                    normal: {
                                        show: false,
                                        position: 'center'
                                    },
                                    emphasis: {
                                        show: true,
                                        textStyle: {
                                            fontSize: '30',
                                            fontWeight: 'bold'
                                        }
                                    }
                                },
                                labelLine: {
                                    normal: {
                                        show: false
                                    }
                                },
                                data:[
                                    {value: data[0], name: '衣服配饰'},
                                    {value: data[1], name: "数码产品"},
                                    {value: data[2], name: "书籍办公"},
                                    {value: data[3], name: "游戏周边"},
                                    {value: data[4], name: "生活用品"},
                                    {value: data[5], name: "化妆用品"},
                                    {value: data[6], name: "运动用品"}
                                ]
                            }
                        ]
                    };
                    myChart.setOption(option);
                }
            });
        }


    </script>

  </body>
</html>