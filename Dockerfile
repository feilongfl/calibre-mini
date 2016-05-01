FROM rastasheep/ubuntu-sshd

RUN apt-get update
RUN apt-get install -y tmux git fish wget curl vim mutt
RUN apt-get install -y libjpeg62 libjpeg8 libpng12-0
#RUN apt-get install -y calibre
RUN wget -nv -O- https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py | sudo python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main()"
RUN apt-get clean
RUN apt-get autoclean

#ADD News.aws.recipe /Calibre-News.recipe 
ADD News.recipe /Calibre-News.recipe 

ADD get.fish /get.fish

RUN mkdir /News

#ADD rc.local /etc/rc.local

RUN echo 'root:calibre' |chpasswd

ADD task.crontab /task.crontab

RUN crontab /task.crontab

RUN /etc/init.d/ssh start
RUN start cron

EXPOSE 8080

CMD ["/usr/bin/calibre-server", "--with-library=/News"]
#CMD ["/etc/rc.local"]
