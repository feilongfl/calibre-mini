FROM rastasheep/ubuntu-sshd

RUN apt-get update
RUN apt-get install -y tmux git fish wget curl vim mutt
RUN apt-get install -y calibre
RUN apt-get clean
RUN apt-get autoclean

#ADD News.aws.recipe /Calibre-News.recipe 
ADD News.recipe /Calibre-News.recipe 

ADD get.fish /get.fish

RUN mkdir /News

ADD rc.local /etc/rc.loacl

ADD task.crontab /task.crontab

RUN crontab /task.crontab

EXPOSE 8080
