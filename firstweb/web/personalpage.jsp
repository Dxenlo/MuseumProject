<%@ page import="dao.impl.FriendDaoImpl" %>
<%@ page import="dao.impl.UserDaoImpl" %>
<%@ page import="service.FriendService" %>
<%@ page import="service.UserService" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.impl.ExhibitDaoImpl" %>
<%@ page import="entity.Exhibit" %>
<%@ page import="entity.User" %>
<%@ page import="service.LoveService" %>
<%@ page import="dao.impl.LoveDaoImpl" %>
<%@ page import="entity.*" %><%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/7/22
  Time: 15:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>个人主页</title>

    <link rel="stylesheet" href="framework/layui/css/layui.css" media="all">

</head>
<body class="layui-layout-body">

<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">博物馆</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="homepage.jsp">首页</a></li>
            <li class="layui-nav-item"><a href="search.jsp">搜索</a></li>
            <%
                User user = null;
                UserService us = new UserService(new UserDaoImpl());
                if (session.getAttribute("me") != null) {
                    user = us.getUser(((User) session.getAttribute("me")).getId());
                    if (user.getPermission() == 0) {
                        session.setAttribute("permission", "true");
                    }

                    if ("true".equals(session.getAttribute("permission"))){
            %>
            <li class="layui-nav-item">
                <a>后台管理（需管理员权限）</a>
                <dl class="layui-nav-child">
                    <dd><a href="userManage.jsp">人员管理</a></dd>
                    <dd><a href="exhibitManager.jsp">作品管理</a></dd>
                </dl>
            </li>
            <%
                    }
                }
            %>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <%
                    if (user != null) {
                %>

                <a>
                    <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
                    <%= user.getName()%>
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="personalpage.jsp?id=<%=user.getId()%>">我的主页</a></dd>
                    <dd><a href="selfManage.jsp">信息管理</a></dd>
                    <dd><a href="friends.jsp">好友列表</a></dd>
                    <dd><a href="backlove.jsp">收藏夹</a></dd>
                    <dd><a href="email.jsp">私信</a></dd>
                    <dd><a href="logout">退出登录</a></dd>
                </dl>

                <%
                } else {
                %>

                <a>
                    未登录
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="log.jsp">登录</a></dd>
                    <dd><a href="sign.jsp">注册</a></dd>
                </dl>
                <%
                    }
                %>
            </li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree" lay-filter="test">
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="">用户相关</a>
                    <dl class="layui-nav-child">
                        <dd class="layui-this"><a href="personalpage.jsp?id=<%=user.getId()%>">我的主页</a></dd>
                        <dd><a href="selfManage.jsp">信息管理</a></dd>
                        <dd><a href="friends.jsp">好友列表</a></dd>
                        <dd><a href="backlove.jsp">收藏夹</a></dd>
                        <dd><a href="email.jsp">私信</a></dd>
                    </dl>
                </li>

                <%
                    if ("true".equals(session.getAttribute("permission"))){
                %>
                <li class="layui-nav-item">
                    <a>管理界面</a>
                    <dl class="layui-nav-child">
                        <dd><a href="userManage.jsp">人员管理</a></dd>
                        <dd><a href="exhibitManager.jsp">展品管理</a></dd>
                    </dl>
                </li>
                <%
                    }
                %>
            </ul>
        </div>
    </div>

    <%
        FriendService fs = new FriendService(new UserDaoImpl(), new FriendDaoImpl());
        User friend = us.getUser(Integer.parseInt(request.getParameter("id")));

    %>

    <div class="layui-body">
        <div style="padding: 20px; background-color: #F2F2F2;">
            <div class="layui-row layui-col-space15">
                <div class="layui-col-md6">
                    <div class="layui-card">
                        <div class="layui-card-header"><%=friend.getName()%></div>
                        <div class="layui-card-body">
                            <p>邮箱：<%=friend.getEmail()%></p>
                            <p>个性签名：<%=friend.getSignature()%>
                                    <%
                        if (user != null) {
                            User me = us.getUser(user.getName());

                            if (me.getId() != friend.getId()) {
                                if (fs.isFriend(me.getId(), friend.getId())) {
                    %>
                                <%--删除好友--%>
                                <p><button type="button" class="layui-btn layui-btn-primary layui-btn-sm"
                                        onclick="updateMyFriend(<%=me.getId()%>,<%=friend.getId()%>,'del')">
                                    <i class="layui-icon" >&#xe640;</i>
                                </button></p>

                                    <%
                    } else {
                    %>
                                <%--添加为好友--%>
                                <p><button type="button" class="layui-btn layui-btn-primary layui-btn-sm"
                                        onclick="sendInvitation(<%=me.getId()%>,<%=friend.getId()%>)">
                                    <i class="layui-icon">&#xe67b;</i>
                                </button></p>
                                    <%
                        }
                    } else {
                        //如果这个是该用户的个人页面
                    %>
                                <%--修改个人信息--%>
                                <p><button type="button" class="layui-btn layui-btn-primary layui-btn-sm"
                                        onclick="window.location.href='selfManage.jsp'">
                                    <i class="layui-icon">&#xe716;</i>
                                </button></p>
                                    <%
                            }
                        }
                    %>
                        </div>
                    </div>
                </div>

                <div class="layui-col-md6">
                    <div class="layui-card">
                        <div class="layui-card-header">收藏的文物</div>
                        <div class="layui-card-body">
                            <hr>
                            <%
                                LoveService ls = new LoveService(new LoveDaoImpl(),new ExhibitDaoImpl());
                                List<LoveItem> loves = ls.getShowLoves(friend);
                                if (loves.isEmpty()){
                            %>
                            暂无公开的收藏
                            <hr>
                            <%
                            }else {
                                for (LoveItem love : loves) {
                                    Exhibit ex = ls.getLoveOne(love.getArtid());
                            %>
                            <a href="details.jsp?id=<%=ex.getId()%>" class="layui-btn layui-btn-primary layui-btn-sm"><%=ex.getName()%>
                            </a>
                            <hr>
                            <%
                                    }
                                }

                            %>
                        </div>
                    </div>
                </div>

            </div>
        </div>

    </div>

</div>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="framework/layui/layui.js"></script>
<script src="js/hintShow.js"></script>
<script src="js/sendinvite.js"></script>

<script src="js/cookie.js"></script>
<script src="js/previouspage.js"></script>
<script type="text/javascript">
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;

    });

    var updateMyFriend = function (UID, FID, FUNC) {
        $.post("./updatefriend", {
            uid: UID,
            fid: FID,
            func: FUNC
        }, function (result) {
            var jsonObject = JSON.parse(result);
            if (jsonObject.success === true) {
                show("成功");
                setTimeout(function () {
                    location.reload();
                }, 1000);

            } else {
                show("失败");
                setTimeout(function () {
                    location.reload();
                }, 1000);
            }
        });
    };

</script>
</body>
</html>





