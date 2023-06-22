#!/bin/bash

# 获取当前脚本所在目录的绝对路径
script_dir=$(cd "$(dirname "$0")" && pwd)

# 运行start.sh脚本
"$script_dir/shutdown.sh"

proxy_off

# 读取用户输入的订阅节点链接
read -p "请输入您的订阅节点链接：" node_url

# 将用户输入的链接格式化为适用于sed命令的形式
escaped_url=$(printf '%s\n' "$node_url" | sed -e 's/[\/&]/\\&/g')

# 检查start.sh文件中是否已经存在URL变量
if grep -q '^URL=' start.sh; then
  # 如果存在，替换URL变量的值为用户输入的节点链接
  sed -i "s#^URL=.*#URL='${escaped_url}'#" start.sh
else
  # 如果不存在，添加URL变量并设置为用户输入的节点链接
  echo "URL='${escaped_url}'" >>start.sh
fi

echo "节点链接已成功替换为 ${node_url}。"

echo "正在启动代理中，请耐稍等片刻~"

# 获取当前脚本所在目录的绝对路径
script_dir=$(cd "$(dirname "$0")" && pwd)

# 运行start.sh脚本
"$script_dir/start.sh"

# 执行source /etc/profile.d/clash.sh命令
source /etc/profile.d/clash.sh

# 运行proxy_on命令
proxy_on

echo ">>>>代理已全自动开启完成,若要关闭代理：proxy_off"
echo "○ 如果中途有失败，请检查您的订阅链接并重新运行本脚本"
echo "如果要远程设置节点请在您的【服务器控制台】开启：9090 端口"
echo "然后访问：http://你的服务器IP:9090/ui"
echo "如果您使用的是类似“挂机宝”的产品，请设置NAT转发，创建9090端口，然后将【你的服务器IP:9090】替换为创建的外网IP及端口"
