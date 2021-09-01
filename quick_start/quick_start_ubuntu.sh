#!/bin/bash
###
 # @Author: Li Yuhao
 # @Date: 2021-08-18 22:41:19
 # @LastEditTime: 2021-09-01 14:49:52
 # @LastEditors: your name
 # @Description: ubuntu system quick start: config aliyun source ip / update source / install anconda
 # @FilePath: /utils/quick_start/quick_start_ubuntu.sh
### 

echo "----------------------------------------"
echo "开始换源..."
# 备份源
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
# 查看ubuntu版本
version=`cat /etc/issue`
# version: Ubuntu xx.yy.zz LTS \n \l

# ubuntu 20.04(LTS): Focal Fossa（专注的马达加斯加长尾狸猫）
# 找到对应系统版本的名称
if [[ $version == *"Ubuntu 20.04"* ]]
then
    TODO="focal"
elif [[ $version == *"Ubuntu 18.04"* ]]
then
    TODO="bionic"
elif [[ $version == *"Ubuntu 16.04"* ]]
then
    TODO="xenial"
fi

# ubuntu 换国内阿里云的源
echo "deb http://mirrors.aliyun.com/ubuntu/ $TODO main restricted universe multiverse" | sudo tee -a /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ $TODO main restricted universe multiverse" | sudo tee -a /etc/apt/sources.list

echo "deb http://mirrors.aliyun.com/ubuntu/ $TODO-security main restricted universe multiverse" | sudo tee -a /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ $TODO-security main restricted universe multiverse" | sudo tee -a /etc/apt/sources.list

echo "deb http://mirrors.aliyun.com/ubuntu/ $TODO-updates main restricted universe multiverse" | sudo tee -a /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ $TODO-updates main restricted universe multiverse" | sudo tee -a /etc/apt/sources.list

echo "deb http://mirrors.aliyun.com/ubuntu/ $TODO-proposed main restricted universe multiverse" | sudo tee -a /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ $TODO-proposed main restricted universe multiverse" | sudo tee -a /etc/apt/sources.list

echo "deb http://mirrors.aliyun.com/ubuntu/ $TODO-backports main restricted universe multiverse" | sudo tee -a /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ $TODO-backports main restricted universe multiverse" | sudo tee -a /etc/apt/sources.list

# 更新源
sudo apt-get update -y
sudo apt-get upgrade -y

# 下载git，并设置用户名与邮箱
echo "----------------------------------------"
echo "开始安装git..."
sudo apt install git -y

# 
echo "----------------------------------------"
echo "开始安装anaconda..."
ANACONDA_VERSION="Anaconda3-2021.05-Linux-x86_64.sh"

# 下载anaconda
wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/$ANACONDA_VERSION


# 使用安装脚本安装anaconda

INSTALL_DIR="$HOME/anaconda3"
ANACONDA_PATH="./$ANACONDA_VERSION"
echo "anaconda3 will be installed in: $INSTALL_DIR" #参数存在$OPTARG中

# 检查地址是否有anaconda安装残留
if [ -d $INSTALL_DIR ]; then
    rm -rf $INSTALL_DIR
fi

# 开始安装anaconda3
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"  # script dir
bash $ANACONDA_PATH -b -p $INSTALL_DIR

# 设置环境变量
echo "add env path to ~/.bashrc"

cat ~/.bashrc | grep ". $INSTALL_DIR/etc/profile.d/conda.sh"
if [ ! $? -eq 0 ];then
    echo ". $INSTALL_DIR/etc/profile.d/conda.sh" >> ~/.bashrc
fi

cat ~/.bashrc | grep "export PATH=$INSTALL_DIR/bin:\$PATH"
if [ ! $? -eq 0 ];then
    echo "export PATH=$INSTALL_DIR/bin:\$PATH" >> ~/.bashrc
fi

cat ~/.bashrc | grep "conda activate"
if [ ! $? -eq 0 ]; then
    echo "conda activate" >> ~/.bashrc
fi

# 刷新环境变量
echo "source ~/.bashrc"
source ~/.bashrc

echo "source activate base"
source activate base
