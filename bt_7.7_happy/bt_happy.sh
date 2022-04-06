#!/bin/bash
LANG=en_US.UTF-8

echo "
+----------------------------------------------------------------------
| Bt-WebPanel-Happy FOR CentOS
+----------------------------------------------------------------------
| 本脚本用于宝塔面板7.7版本的一键开心，因为脚本造成的问题请自行负责！
+----------------------------------------------------------------------
"
while [ "$go" != 'y' ] && [ "$go" != 'n' ]
do
    read -p "请确认你已经安装的版本是7.7，请确保仅用于学习使用！(y/n): " go;
done

if [ "$go" == 'n' ];then
    exit;
fi

#修改强制登录开始
sed -i "s|if (bind_user == 'True') {|if (bind_user == 'REMOVED') {|g" /www/server/panel/BTPanel/static/js/index.js
rm -rf /www/server/panel/data/bind.pl
#修改强制登录结束
echo -e "修改强制登陆中..."
sleep 2
echo -e "插件商城开心开始..."
#判断plugin.json文件是否存在,存在删除之后再下载,不存在直接下载
plugin_file="/www/server/panel/data/plugin.json"
if [ -f ${plugin_file} ];then
    chattr -i /www/server/panel/data/plugin.json
    rm /www/server/panel/data/plugin.json
    cd /www/server/panel/data
    wget https://proxy.zyun.vip/https://raw.githubusercontent.com/elunez/other_script/master/bt_7.7_happy/plugin.json
    chattr +i /www/server/panel/data/plugin.json
    # 去除软件商城广告
    chattr -i /www/server/panel/BTPanel/templates/default/soft.html
    rm /www/server/panel/BTPanel/templates/default/soft.html
    cd /www/server/panel/BTPanel/templates/default
    wget https://proxy.zyun.vip/https://raw.githubusercontent.com/elunez/other_script/master/bt_7.7_happy/soft.html
    chattr +i /www/server/panel/BTPanel/templates/default/soft.html
else
    cd /www/server/panel/data
    wget https://proxy.zyun.vip/https://raw.githubusercontent.com/elunez/other_script/master/bt_7.7_happy/plugin.json
    chattr +i /www/server/panel/data/plugin.json
    # 去除软件商城广告
    cd /www/server/panel/BTPanel/templates/default
    wget https://proxy.zyun.vip/https://raw.githubusercontent.com/elunez/other_script/master/bt_7.7_happy/soft.html
fi
sleep 3
echo -e "去除升级红点开始..."
#判断index.html文件是否存在,存在删除之后再下载,不存在直接下载
index_file="/www/server/panel/BTPanel/templates/default/index.html"
if [ -f ${index_file} ];then
    rm /www/server/panel/BTPanel/templates/default/index.html
    cd /www/server/panel/BTPanel/templates/default
    wget https://proxy.zyun.vip/https://raw.githubusercontent.com/elunez/other_script/master/bt_7.7_happy/index.html
else
    cd /www/server/panel/BTPanel/templates/default
    wget https://proxy.zyun.vip/https://raw.githubusercontent.com/elunez/other_script/master/bt_7.7_happy/index.html
fi
sleep 3
echo -e "文件防止修改开始..."
#判断repair.json文件是否存在,存在删除之后再下载,不存在直接下载
repair_file="/www/server/panel/data/repair.json"
if [ -f ${repair_file} ];then
    chattr -i /www/server/panel/data/repair.json
    rm /www/server/panel/data/repair.json
    cd /www/server/panel/data
    wget https://proxy.zyun.vip/https://raw.githubusercontent.com/elunez/other_script/master/bt_7.7_happy/repair.json
    chattr +i /www/server/panel/data/repair.json
else
    cd /www/server/panel/data
    wget https://proxy.zyun.vip/https://raw.githubusercontent.com/elunez/other_script/master/bt_7.7_happy/repair.json
    chattr +i /www/server/panel/data/repair.json
fi
sleep 3
     /etc/init.d/bt restart
sleep 2 
echo -e "修改强制登陆结束."
echo -e "插件商城开心结束."
echo -e "去除升级红点结束."
echo -e "文件防止修改结束."
echo -e "宝塔面板开心结束！"