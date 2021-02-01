FROM phusion/baseimage:0.10.2
LABEL author="junyuuuu@foxmail.com"

#用ubuntu国内源替换默认源
RUN  mv /etc/apt/sources.list /etc/apt/sources.list.bak
COPY sources.list /etc/apt/sources.list

RUN apt-get update \
    && apt-get install -y apt-transport-https vim iproute2 net-tools ca-certificates curl wget software-properties-common libxss1 libappindicator1 libindicator7 libgconf2-4 libnss3-1d unzip

#设置时区
RUN apt-get install -y tzdata
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#处理vim中文乱码、更改注释颜色
RUN echo -e "set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936 \n set termencoding=utf-8 \n echo set encoding=utf-8 \n hi comment ctermfg=6" >> /etc/vim/vimrc

#安装python3.6
RUN add-apt-repository ppa:jonathonf/python-3.6 && apt-get update && apt-get install -y python3.6 python3.6-dev python3.6-venv

#为3.6安装pip
RUN wget https://bootstrap.pypa.io/get-pip.py \
    && python3.6 get-pip.py \
    && rm get-pip.py

#和自带的3.5共存
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.5 1
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 2
RUN update-alternatives --config python3
#添加软链接
RUN ln -s /usr/bin/python3.6 /usr/bin/python

#安装chrome
RUN apt-get update \
    && apt-get install -y libxss1 libappindicator1 libindicator7 libgconf2-4 libnss3-1d  fonts-liberation libasound2 xdg-utils \
    && apt-get -f install

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && dpkg -i google-chrome*.deb \
    && ln -s /usr/bin/google-chrome-stable /usr/bin/chrome \
    && rm google-chrome*.deb

#安装chromedriver
RUN wget https://npm.taobao.org/mirrors/chromedriver/75.0.3770.140/chromedriver_linux64.zip \
    && unzip chromedriver_linux64.zip \
    && chmod 777 chromedriver && mv chromedriver /usr/bin/ \
    && rm chromedriver_linux64.zip

ADD build /opt
#安装最新版本supervisor
RUN /opt/supervisor.sh

#清理缓存包
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#print()时在控制台正常显示中文
ENV PYTHONIOENCODING=utf-8

CMD ["/sbin/my_init"]