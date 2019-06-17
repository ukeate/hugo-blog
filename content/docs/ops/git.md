---
Categories: ["运维"]
title: "Git"
date: 2018-10-11T18:26:40+08:00
---

# 目录结构
    .git
            branches
            config  # 存放版本库git地址
# 规定
    HEAD
            # HEAD的版本号, HEAD^^ 表示HEAD之前两个的版本, HEAD~n 表示之前n个版本
    buffered stage branch head
            # buffered表示当前修改所在的版本，stage是buffered中文件add之后到的版本，branch是stage commit后到的分支(版本)，head是远程仓库的最新版本
# 命令
    git [command] --help
    git help submodule
## 仓库
    clone
    checkout
            # 切换到分支。检出原有文件替换
            -b 
                    # 创建并切换到分支
    branch
            # 创建并切换到分支
            -r
                    # 指定操作远程分支
                    -r origin/dev
            -a
                    # 本地远程所有分支
            dev ef71
                    # 从ef71创建分支dev
            dev
            -d dev 
                    # 删除
            -D dev
                    # 强制删除
    remote
            remove origin
            show
                    # 显示仓库
            prune origin
                    # 删除远程没有而本地缓存的远程分支
            add origin git@bitbucket.org:outrun/www2.git
                    # 设置仓库
            set-url origin git@github.com:outrun/jeky
                    # 设置仓库url
    fetch
            # pull加merge
    pull origin master
            --allow-unrelated-histories
                    # 本地有已存文件时，强行pull并检查冲突
    merge dev
            # 合并dev到当前分支
            --squash dev-bak
                    # dev-bak改动写到stash
    push origin master
            -u origin master
                    # 设定git push 默认参数
            origin :dev
                    # origin +dev:dev
                    # 强制替换掉原来版本
    commit
            # stage 提交到branch
            -a
                    # 提交删改，忽略增加
            -m
                    # 注释
            --amend
                    # 合并到上次commit
    revert  -m 1 ea1
            # 舍弃最近一次commit
            git commit -am 'revert'
            git revert revertid1 取消上次revert
                    # intellji - local history - revert
    rebase master
            # 相当于当前改动代码之前merge master
    reset
            --hard ea1
                    # 回退
    stash
            # 暂存buffered
            list
                    # 显示stash
            drop
                    # 删除暂存 
            pop
                    # 恢复并删除暂存
            apply stash@{0}
                    # 恢复暂存
    tag tag1
            # 添加tag tag1
            -a tag1
                    # 添加tag1 
            -m 'a'
                    # 注释
        -d tag1
                    # 删除tag1    
    show tag1
            # 查看tag1的信息
## 文件
    add
            -A
                    # 递归
    mv a b
            # 重命名
    rm
            # buffered和stage中都删除
            --cached
                    # 只删除stage中
    log
            # HEAD到指定版本号之前的log
            --stat
                    # 文件名差异
            -p
                    # 细节差异
            -2
                    # 文件最近2次差异
    reflog        
            # 包括reset前的版本号
    diff master dev
            # 对比分支差异，可指定到文件
            # 默认对比buffered和stage的差异
            --cached
                    # 对比stage和branch的差异
    ls-files
            -u
                    # 显示冲突文件
            -s
                    # 显示标记为冲突已解决的文件
            --stage
                    # stage中的文件
    submodule
            init
                    # 初始化本地配置文件
            update
                    # --init --recursive
                    # 同步项目中的submodule
# 设置
    .gitignore

    .git/config

    ~/.gitconfig
            [commit]
            template=/t.txt
                    # 每次commit会打开模板
# 方案
    回退commit
            git reset --hard ea1        
                    # 进行回退
            git push -f
                    # 强制提交
            git clean -xdf                                        
                    # 一般配合git reset使用, 清除已有的改动
    补充commit
            git commit --amend
            git push origin +a:a
    远程回退
            git revert id
    删除远程分支
            git branch -r -d origin/test
            git push origin :test
    恢复历史版本文件
            git reset ba5798aff7778c95252b9e01e924dddb5811bcd7 courseModel.js
            git checkout -- courseModel.js
            git push origin +master:master                # 提交回退版本到远程
    查看修改的内容
            git show
                    # 与上个commit 比较
            git whatchanged
            git log --stat --date=relative
    删除历史
            git filter-branch --force --index-filter 'git rm -r --cached --ignore-unmatch .idea' --prune-empty --tag-name-filter cat -- --all
            git push origin master --force
            rm -rf .git/refs/original/
            git reflog expire --expire=now --all
            git gc --prune=now
            git gc --aggressive --prune=now
    合并commit历史
            git branch test-bak
            git reset --hard ea1
            git merge --squash test-bak
            git push origin test -f
            git branch -D test-bak
    打tag
            git tag
                    # git tag -l 'v1.*' 通配查找
            git tag -a v1.0 -m "a"
                    # git tag -a v1.0 ba1 给commit打标签
            git show v1.0
            git checkout v1.0
            git push origin v1.0
                    # git push origin -tags 将本地所有标签提交
            git tag -d v1.0
            git push origin --delete tag v1.0
                    # git push origin :refs/tags/v1.0c 
    统计某人代码
            git log --author="$(git config --get user.name)" --pretty=tformat: --numstat | gawk '{ add += $1 ; subs += $2 ; loc += $1 - $2 } END { printf "added lines: %s removed lines : %s total lines: %s\n",add,subs,loc }' -
    共添加或修改行数
            git log --stat|perl -ne 'END { print $c } $c += $1 if /(\d+) insertions/'
## pr
    介绍
            fork与pull request

    fork后本地
            git clone git@github.com:chenduo/auth.git
            git remote add upstream git@github.com:Meiqia/auth.git
    本地合并更新
            git checkout master                                                     
            git fetch upstream
                    # fetch远程仓库
            git rebase upstream/master 
                    # 合并远程master                                         
            git push 
            git checkout branch1
            git rebase master
    pr追加
            git commit --amend
                    # 更新本地的本次commit,不产生新的commit
            git push origin +branch1:branch1 
                    # 使用本地的commit覆盖远程分支的有问题的commit
    处理pr
            git fetch origin
            git checkout -b pr1 origin/pr1
            git checkout master
            git merge --no-ff pr1
            git reset --hard
            git revert -m 1 ea1
                    # 舍弃pr
            git commit -am 'revert'
            git revert revertid1 取消上次revert
                    # intellji - local history - revert
            git push origin master
## 开发
    提交
            git pull eoecn dev
                    # 等于git fetch加git merge
            git diff
                    # buffer与HEAD的差异(不包括新建文件)
            git add -A .
                    # 添加到stage
            git status
                    # stage与HEAD的差异
            git diff --cached/--stage
                    # stage与HEAD的详细差异
            git diff HEAD
                    # buffer, stage与HEAD的详细差异
            git commit -am 'a'
            git push origin dev
            网站上点pull request
# github
    ssh -T git@github.com
            # 检查github ssh是否设置成功
# 插件
    octotree    # 树形显示