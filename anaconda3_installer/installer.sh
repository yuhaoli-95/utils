#!/bin/bash
###
 # @Author: Li Yuhao
 # @Date: 2021-08-09 13:53:24
 # @LastEditTime: 2021-08-09 18:31:08
 # @LastEditors: your name
 # @Description: 自动安装anaconda3
 # @FilePath: /proj/utils/anaconda3/installer.sh
### 
# 设置anaconda安装地址
INSTALL_DIR="$HOME/anaconda3"
ANACONDA_PATH=$1
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
