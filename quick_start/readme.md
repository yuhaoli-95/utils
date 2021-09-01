# 快速配置ubuntu系统
在国内环境中快速配置一台ubuntu系统，包括以下内容:

1. 根据系统版本号，将ubuntu源更换为对应的阿里源（如果为非root账户下配置，则需要sudo密码）;
2. 下载git（如果为非root账户下配置，则需要sudo密码）;
3. 下载清华源的anaconda指定安装包并自动安装anaconda;

使用命令:

```sh
chmod +x ./quick_start_ubuntu.sh
source ./quick_start_ubuntu.sh
```
