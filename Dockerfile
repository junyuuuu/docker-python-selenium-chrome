FROM phusion/baseimage:0.10.2
LABEL author="junyuuuu@foxmail.com"

#用ubuntu国内源替换默认源
RUN  mv /etc/apt/sources.list /etc/apt/sources.list.bak
COPY sources.list /etc/apt/sources.list

RUN apt-get update
RUN apt-get install -y apt-transport-https
RUN apt-get install -y vim iproute2 net-tools ca-certificates curl wget software-properties-common libxss1 libappindicator1 libindicator7 libgconf2-4 libnss3-1d unzip

#处理vim中文乱码
RUN echo set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936 >> /etc/vim/vimrc
RUN echo set termencoding=utf-8 >> /etc/vim/vimrc
RUN echo set encoding=utf-8 >> /etc/vim/vimrc

#安装python3.6
RUN add-apt-repository ppa:jonathonf/python-3.6
RUN apt-get update
RUN apt-get install -y python3.6
RUN apt-get install -y python3.6-dev
RUN apt-get install -y python3.6-venv

#为3.6安装pip
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python3.6 get-pip.py

#和自带的3.5共存
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.5 1
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 2
RUN update-alternatives --config python3
#添加软链接
RUN ln -s /usr/bin/python3.6 /usr/bin/python

#安装chrome
RUN apt-get update
RUN apt-get install -y libxss1 libappindicator1 libindicator7 libgconf2-4 libnss3-1d  fonts-liberation libasound2 xdg-utils
RUN apt-get -f install
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome*.deb
#添加软链接
RUN ln -s /usr/bin/google-chrome-stable /usr/bin/chrome

#安装chromedriver
RUN wget https://npm.taobao.org/mirrors/chromedriver/75.0.3770.140/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip
RUN chmod 777 chromedriver
RUN mv chromedriver /usr/bin/

#删除文件
RUN rm get-pip.py google-chrome*.deb chromedriver_linux64.zip

#清理缓存包
RUN apt-get clean

#print()时在控制台正常显示中文
ENV PYTHONIOENCODING=utf-8

CMD ["/sbin/my_init"]