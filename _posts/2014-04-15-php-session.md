---
layout: post
title: PHP 会话功能示例
tags:
- php
---

一个简单的例子说明如何使用会话（Phalcon 框架）：

    <?php
    ini_set('session.cookie_lifetime', 30);  // 设置 cookie 过期时间
    ini_set('session.name', 'mysid');        // 设置 cookie 名
    define("ID_KEY", "__ID");                // session 中保存用户登录信息的 key
    $session = new Phalcon\Session\Adapter\Files();
    $session->start();
    
    if ( $_SERVER['REQUEST_METHOD'] == 'POST' ) {
        // 对用户名，密码进行检查，检查通过才能设置用户的登录信息
        $session->set(ID_KEY, (object)array(
            'name' => 'ywb'
        ));
        show_user();
    } elseif ( !$session->has(ID_KEY) ) {
        login_form();
    } elseif ( isset($_GET['action']) && $_GET['action'] == 'logout' ) {
        // 退出即删除所有会话信息
        $session->destroy();
        header("location: ". str_replace('action=logout', '', $_SERVER['REQUEST_URI']));
    } else {
        show_user();
    }
    
    function login_form ()
    {
        show_header();
        ?>
    <form method="post">
    <button type="submit">登录</button>
    </form>
            <?php
         show_footer();
    }
    
    function show_user() 
    {
        global $session;
        show_header();
        ?>
    <?php echo $session->get(ID_KEY)->name ?> <a href="?action=logout">退出</a>
        <?php
        show_footer();
    }
    
    function show_header()
    {
        ?>
    <html>
        <head>
        <meta charset="utf-8">
        </head>
        <body>
        <?php
    }
    
    function show_footer()
    {
        ?>
        </body>
    </html>
        <?php
    }
