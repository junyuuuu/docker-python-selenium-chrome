# docker-python-selenium-chrome

## 镜像内容

此镜像包括如下内容：

- Ubuntu 16.04 LTS
- Python 3.6
- Chrome
- Chromedriver

apt源修改为了阿里的，具体请查看Dockerfile内容。

## 安装与运行
### 构建

`git clone` 此仓库，在 **Dockerfile** 所在的目录执行命令： 

	docker build -t='[ImageName]:[Tag]' .    // [ImageName] 为你想要的镜像名称,如果不想标识版本，请忽略:[Tag]。但是别忽略了"."

然后等待构建成功即可。


### 运行

构建成功后，使用 `docker images` 查看该镜像信息。

	 docker run -it -v D:\pythonwww:/home/www [ImageId] /bin/bash  // 其中ImageID替换为对应的镜像ID。

该命令创建容器，并将宿主机的D:\pythonwww目录挂载到了容器的/home/www目录，进入命令交互界面。