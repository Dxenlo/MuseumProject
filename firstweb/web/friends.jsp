<%@ page import="dao.impl.UserDaoImpl" %>
<%@ page import="entity.User" %>
<%@ page import="service.FriendService" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: dell
  Date: 2019/7/18
  Time: 19:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>好友管理</title>
    <link rel="stylesheet" href="framework/layui/css/layui.css">
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">我的信息</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="">首页</a></li>
            <li class="layui-nav-item"><a href="">商品管理</a></li>
            <li class="layui-nav-item"><a href="">用户</a></li>
            <li class="layui-nav-item">
                <a href="javascript:;">其它系统</a>
                <dl class="layui-nav-child">
                    <dd><a href="">邮件管理</a></dd>
                    <dd><a href="">消息管理</a></dd>
                    <dd><a href="">授权管理</a></dd>
                </dl>
            </li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <%=session.getAttribute("name")%>
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="">基本资料</a></dd>
                    <dd><a href="">安全设置</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="logout">退了</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">

            <ul class="layui-nav layui-nav-tree site-demo-nav">

                <li class="layui-nav-item layui-nav-itemed">
                    <a class="javascript:;" href="javascript:;">账户管理</a>
                    <dl class="layui-nav-child">
                        <dd class="">
                            <a href="">个人信息</a>
                        </dd>
                        <dd class="layui-this">
                            <a href="">好友管理</a>
                        </dd>
                    </dl>
                </li>

                <li class="layui-nav-item layui-nav-itemed">
                    <a class="javascript:;" href="javascript:;">收藏管理</a>
                    <dl class="layui-nav-child">
                        <dd class="">
                            <a href="">默认收藏</a>
                        </dd>
                        <dd class="">
                            <a href="">清代藏品</a>
                        </dd>
                    </dl>
                </li>


                <li class="layui-nav-item" style="height: 30px; text-align: center"></li>
            </ul>

        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;">


            <div class="layui-tab layui-tab-card">
                <ul class="layui-tab-title">
                    <li class="layui-this">我的好友</li>
                    <li>好友查询</li>
                    <li>收到的邀请</li>
                </ul>

                <div class="layui-tab-content">
                    <div class="layui-tab-item layui-show">
                        <%--我的好友栏目--%>
                        <div class="layui-row layui-col-space15">
                            <%

                                FriendService fs = new FriendService(new UserDaoImpl());
                                User me = (User) session.getAttribute("me");
                                List<User> myFriends = fs.getFriend(me);

                                for (User myFriend : myFriends) {
                            %>
                            <div class="layui-col-md6">
                                <div class="layui-card">
                                    <div class="layui-card-header" data-toggle="popover">名称：<%=myFriend.getName()%>
                                    </div>
                                    <div class="layui-card-body">
                                        个性签名：<%=myFriend.getSignature()%>
                                    </div>
                                    <a href="personalpage.jsp?id=<%=myFriend.getId()%>"
                                       class="btn btn-primary">进入ta的主页</a>
                                </div>
                            </div>
                            <%
                                }
                            %>
                        </div>
                    </div>


                    <div class="layui-tab-item">
                        <%--好友查询栏目--%>
                        <form class="layui-form" action="">
                            <div class="layui-form-item">
                                <a id="bt_search_friend" class="layui-form-label btn btn-primary">搜索ta</a>
                                <div class="layui-input-block">
                                    <input type="text" autocomplete="off" placeholder="请输入"
                                           class="layui-input">
                                </div>
                            </div>
                        </form>
                        <hr>
                        <div id="find_friend_result">
                            <%--展示查询的结果--%>
                        </div>
                    </div>

                    <div class="layui-tab-item">
                        <%--展示所有的好友申请记录--%>
                        <div class="layui-row layui-col-space15">
                            <%
                                List<User> myInvites = fs.getInvite(me);
                                for (User myInvite : myInvites) {
                            %>
                            <div class="layui-col-md6">
                                <div class="layui-card">
                                    <div class="layui-card-header" data-toggle="popover">来源：<%=myInvite.getName()%>
                                    </div>
                                    <div class="layui-card-body">
                                        ta的签名：<%=myInvite.getSignature()%>
                                    </div>

                                    <div class="layui-btn-group">
                                        <form type="post" action="friendHandleServlet">
                                            <button type="button" class="layui-btn" name="agree">同意</button>
                                            <button type="button" class="layui-btn" name="refuse">拒绝</button>
                                        </form>
                                        <button type="button" class="layui-btn"
                                                onclick="location.href='personalpage.jsp?id=<%=myInvite.getId()%>'">
                                            查看ta的主页
                                        </button>
                                    </div>


                                </div>
                            </div>
                            <%
                                }
                            %>
                        </div>

                    </div>
                </div>


            </div>
        </div>

        <div class="layui-footer">
            <!-- 底部固定区域 -->
        </div>
    </div>
</div>

<script src="framework/layui/layui.js"></script>
<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"></script>
<script src="https://cdn.bootcss.com/popper.js/1.12.9/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
<script src="https://cdn.bootcss.com/bootstrap/4.0.0/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
<script>
    //JavaScript代码区域
    layui.use('element', function () {
        var $ = layui.jquery
            , element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块
    });

</script>


</body>
</html>

