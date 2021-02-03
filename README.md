# DockerTestDemo
Docker测试项目

## 生成镜像
* docker build --build-arg PROJECT_NAME="WebApplication1" -t testapp1 . --network=host
* docker build --build-arg PROJECT_NAME="WebApplication2" -t testapp2 . --network=host

## 运行容器
* docker run --name testApp1 -p 8082:80 -d testapp1
* docker run --name testApp2 -p 8082:80 -d testapp2
