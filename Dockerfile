FROM       ubuntu
MAINTAINER calibre

RUN apt-get update

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]

#############################################

#RUN apt-get update
RUN apt-get install -y tmux git fish wget curl vim mutt
RUN apt-get install -y xz-utils
RUN apt-get install -y libjpeg62 libjpeg8 libpng12-0

RUN apt-get install -y ImageMagick
#RUN apt-get install -y build-essential autoconf
#RUN wget http://www.imagemagick.org/download/delegates/jpegsrc.v9a.tar.gz
#RUN tar -zxvf http://www.imagemagick.org/download/delegates/jpegsrc.v9a.tar.gz
#RUN cd jpeg-9a && ./configure && make && make install && cd .. && rm -rfv jpeg-9a
#RUN git clone https://github.com/ImageMagick/ImageMagick.git
#RUN cd ImageMagick && ./configure && make && make install && cd .. &&rm -rfv ImageMagick
#RUN apt-get purge -y build-essential

RUN apt-get install -y ttf-wqy-microhei
#RUN apt-get install -y calibre
RUN wget -nv -O- https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py | sudo python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main()"

RUN apt-get autoremove -y
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
