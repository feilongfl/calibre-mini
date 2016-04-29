FROM rastasheep/ubuntu-sshd

RUN apt-get update
RUN apt-get install -y tmux git fish wget curl
RUN apt-get install -y calibre
RUN apt-get clean
RUN apt-get autoclean

#RUN News.aws.recipe /Calibre-News.recipe 
RUN News.recipe /Calibre-News.recipe 

EXPOSE 8080
