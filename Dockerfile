FROM egoncalves/centos7:golang1.8.1
ENV PKG_CONFIG_PATH /usr/lib/pkgconfig

ADD http://www.imagemagick.org/download/ImageMagick-7.0.5-4.tar.gz /tmp

RUN yum -y install gcc make
RUN cd /tmp \
    && tar -xvzf ImageMagick*.tar.gz \
    && cd ImageMagick* \
    && ./configure --prefix=/usr \
    && make \
    && make install \
    && ldconfig /usr/local/lib
RUN go get gopkg.in/gographics/imagick.v3/imagick
RUN cd /tmp \
    && rm ImageMagick*.tar.gz \
    && rm -r Image*
VOLUME [$GOPATH]

LABEL   br.com.egoncalves="Eduardo Gonçalves" \
        version="1.0" \
        description="ImageMagick-7.0.5-4 and Golang 1.8.1 running on CentOs7"
