FROM swift:5.3-amazonlinux2

RUN yum -y install \
     libuuid-devel \
     libicu-devel \
     libedit-devel \
     libxml2-devel \
     sqlite-devel \
     python-devel \
     ncurses-devel \
     curl-devel \
     openssl-devel \
     libtool \
     jq \
     tar \
     zip
