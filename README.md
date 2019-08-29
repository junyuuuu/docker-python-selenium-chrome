# docker-python-selenium-chrome

## 镜像内容

此镜像包括如下内容：

- ~~Ubuntu 16.04 LTS~~
- [phusion/baseimage](https://github.com/phusion/baseimage-docker)
- Python 3.6
- Chrome
- Chromedriver
- [supervisor](https://github.com/Supervisor/supervisor)

apt源修改为了阿里的，具体请查看Dockerfile内容。

## 安装与运行
### 构建

`git clone` 此仓库，在 **Dockerfile** 所在的目录执行命令： 

	docker build -t='[ImageName]:[Tag]' .    // [ImageName] 为你想要的镜像名称,如果不想标识版本，请忽略:[Tag]。但是别忽略了"."

然后等待构建成功即可。

### 在线仓库

```
docker pull junyuuuu/python-selenium-chrome:1.0.3
```


### 运行

构建成功后，使用 `docker images` 查看该镜像信息。

	 docker run -it -v D:\pythonwww:/home/www [ImageId] /bin/bash  // 其中ImageID替换为对应的镜像ID。

该命令创建容器，并将宿主机的D:\pythonwww目录挂载到了容器的/home/www目录，进入命令交互界面。


### 注意
在build过程中如果遇到提示/bin/sh: 1: *.sh: not found类似的提示，可能有两种原因

1.在Dockerfile使用 ADD 添加文件夹，镜像中必须存在和当前文件夹同名的文件夹才行

2.shell文件的line endings必须设置为 Unix，可以用sublime打开shell文件，来设置line endings