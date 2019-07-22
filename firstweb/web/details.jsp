<%@ page import="dao.impl.ExhibitDaoImpl" %>
<%@ page import="entity.Exhibit" %>
<%@ page import="entity.User" %><%--
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
    <title>商品详情</title>

    <link rel="stylesheet" href="framework/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="css/homepage.css">
    <link rel="stylesheet" href="css/details.css">

    <script src="https://kit.fontawesome.com/032ebc398d.js"></script>
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
                if(session.getAttribute("me") != null){
                    user = (User) session.getAttribute("me");
                    if(user.getPermission() == 0){
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
                    if(user != null){
                %>

                <a>
                    <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
                    <%= user.getName()%>
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="personalpage.jsp">个人信息</a></dd>
                    <dd><a href="friends.jsp">好友列表</a></dd>
                    <dd><a href="backlove.jsp">收藏夹</a></dd>
                    <dd><a href="">退出登录</a></dd>
                </dl>

                <%
                }
                else {
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

    <%
        ExhibitDaoImpl exhibitDaoImpl = new ExhibitDaoImpl();
        Exhibit exhibit = exhibitDaoImpl.getExhibit(Integer.parseInt(request.getParameter("id")));
        if(exhibit!=null){
            //热度加一
            exhibitDaoImpl.updateHotDegree(exhibit.getId());
    %>

    <div class="layui-body">
        <img src="image/exhibit/<%=exhibit.getPic()%>.jpg" class="layui-inline">
        <div class="layui-inline layui-bg-cyan">
            <h3><%=exhibit.getName()%></h3>
            <p>年代：<%=exhibit.getAge()%></p>
            <p>馆藏地点：<%=exhibit.getPlace()%></p>
            <p>出土时间：<%=exhibit.getYear()%>年</p>
            <p>简介：<%=exhibit.getDetail()%></p>
            <p>热度：<%=exhibit.getHotDegree() + 1%></p>
            <button class="layui-btn"><i class="fa fa-heart" aria-hidden="true"></i>收藏</button>
            <button class="layui-btn" id="video"><i class="fa fa-play" aria-hidden="true"></i>播放介绍视频</button>

        </div>
    </div>

    <%
        }
    %>
</div>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="framework/layui/layui.js"></script>

<script type="text/javascript">
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;

    });

    layui.use('layer', function(){
        var layer = layui.layer;
        var loadstr = '<video width="100%" height="100%"  controls="controls" autobuffer="autobuffer"  autoplay="autoplay" loop="loop">' +
            '<source src="video/HEXGRID111_x264.mp4" type="video/mp4"></video>';
        $('#video').click(function () {
            layer.open({
                type: 1,
                title: '介绍视频',
                content: loadstr,
                area: ['600px', '600px']
            });
        });
    });

</script>
</body>
</html>
