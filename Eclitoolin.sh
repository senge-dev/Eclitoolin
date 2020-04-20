#!/bin/bash

# Copyright @ 森哥
# QQ:1356872768
# Version 1.0.0
# 

# 判断java环境是否成功安装
java -version
if [ $? != 0 ]; then
	reset
	echo "您的电脑没有安装JDK，请自行安装"
# 判断是否为Root用户
elif [ $UID != 0 ]; then
	reset
	echo "请用root用户执行此脚本，否则无法正常安装"
else
	echo " _____          _   _   _                     _   _"
	echo "| ____|   ___  | | (_) | |_    ___     ___   | | (_)  _ __"
	echo "|  _|    / __| | | | | | __|  / _ \   / _ \  | | | | | '_ \ "
	echo "| |___  | (__  | | | | | |_  | (_) | | (_) | | | | | | | | |"
	echo "|_____|  \___| |_| |_|  \__|  \___/   \___/  |_| |_| |_| |_|"
	echo " "
	echo " "
	echo "欢迎使用Eclipse"
	# 开始下载Eclipsei
	cd ~/
	wget http://mirrors.neusoft.edu.cn/eclipse/technology/epp/downloads/release/2020-03/R/eclipse-java-2020-03-R-linux-gtk-x86_64.tar.gz
	if [ $? != 0]; then
		echo "Eclipse下载失败"
		exit
	else
		echo "Eclipse下载成功"
	fi
	cd ~/
	# 解压Eclipse，并移动到指定目录
	tar -zxvf eclipse-java-2020-03-R-linux-gtk-x86_64.tar.gz
	mv ~/eclipse /opt
	# 创建桌面快捷方式
	cd /usr/share/applications
	touch Eclipse.desktop
cat >> Eclipse.desktop << EOF
[Desktop Entry]
Encoding=UTF-8
Name=Eclipse
Comment=Eclipse IDE
Exec=/opt/eclipse/eclipse
Icon=/opt/eclipse/icon.xpm
Terminal=false
StartupNotify=true
Type=Application
Categories=Application;Development;
EOF
	# 判断桌面是否创建成功
	if [ $? !=0 ]; then
		echo "桌面快捷方式创建失败"
		exit
	else
		echo "桌面快捷方式创建成功"
	fi
	# Eclipse汉化
	cd ~/
	wget http://mirrors.neusoft.edu.cn/eclipse/technology/babel/babel_language_packs/R0.17.1/2019-12/BabelLanguagePack-eclipse-zh_4.14.0.v20200113020001.zip
	if [ $? != 0 ]; then
		echo "汉化包下载失败，但是Eclipse安装成功了"
		exit
	else
		echo "汉化包下载成功"
	fi
	# 解压汉化包，并配置
	unzip -n ~/BabelLanguagePack-eclipse-zh_4.14.0.v20200113020001.zip
	mv ~/eclipse ~/dropins
	mv ~/dropins /opt/eclipse
	if [ $? != 0 ]; then
		echo "汉化失败"
		rm -rf /opt/eclipse/dropins/*
	else
		echo "汉化成功，请自行验证界面是否为中文"
	fi
fi
