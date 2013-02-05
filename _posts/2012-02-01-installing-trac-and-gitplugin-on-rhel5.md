---
layout: post
title: 在 RHEL5 上安装 Trac 和 GitPlugin
tags: 
- system admin
---

Trac 0.12 在 RHEL 可以找到 yum 源，但是它使用的是默认的 python2.4，安装 GitPlugin 需要 python2.6，否则会报 Syntax Error 的错误。所以还是使用源文件安装的方式比较好。

首先要安装 python2.6:

    yum install python26 python26-setuptools

下载以下文件：
 - Genshi： http://ftp.edgewall.com/pub/genshi/Genshi-0.6-py2.6.egg
 - Trac 0.12: http://ftp.edgewall.com/pub/trac/Trac-0.12.2.tar.gz
 - GitPlugin: http://github.com/hvr/trac-git-plugin/tarball/master

下载后按上述顺序使用 easy_install 安装即可。

网络环境好的话可以直接用 easy_install 安装：

    sudo easy_install-2.6 http://github.com/hvr/trac-git-plugin/tarball/master

首先使用 trac-admin 初始化目录：

    sudo trac-admin /var/trac initenv

trac.ini 可能要修改的基本设置：

    [header_logo]
    alt = (please configure the [header_logo] section in trac.ini)
    height = -1
    link =
    src = site/your_project_logo.png
    width = -1

    [notification]
    smtp_enabled = false

    [project]
    admin =
    admin_trac_url = .
    descr = My example project
    footer = Visit the Trac open source project at<br /><a href="http://trac.edgewall.org/">http://trac.edgewall.org/</a>
    icon = common/trac.ico
    name = My Project
    url =

默认的代码仓库使用 svn，需要加入以下配置：

    repository_dir = /path/to/git/repos.git
    repository_sync_per_request = (default)
    repository_type = git

    [components]
    tracext.git.* = enabled

    [git]
    # cached_repository = true
    # persistent_cache = true
    shortrev_len = 6
    wiki_shortrev_len = 7
    trac_user_rlookup = true
    use_committer_id = false
    use_committer_time = false

`cached_repository` 和 `persistent_cache` 开启时需要配置 git 库中的 post-receive hook，比较麻烦。

如果 git 仓库在远程服务器，可以在本地作一个仓库镜像，用 crontab 定期同步。创建仓库镜像使用 `git clone --mirror` 命令。

Trac 0.12 支持多代码仓库管理，可以在 trac.ini 里设置，也可以在 web 界面中设置。参考 TracRepositoryAdmin 操作。
