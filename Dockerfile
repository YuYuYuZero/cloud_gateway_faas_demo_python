#FROM tiangolo/uwsgi-nginx-flask:python3.8
#FROM python:3.8-slim-buster
FROM public-cn-beijing.cr.volces.com/public/base:python-3.10.6
WORKDIR /opt/application
COPY . .
RUN pip3 install -r requirements.txt
RUN cp /opt/application/douyincloud_egress.crt /etc/ssl/certs/douyin_cloud_egress.crt

# wget 安装证书
ENV DOUYINCLOUD_CERT_PATH=/usr/local/share/ca-certificates/douyincloud_egress.crt
RUN wget https://raw.githubusercontent.com/bytedance/douyincloud_cert/master/douyincloud_egress.crt -O $DOUYINCLOUD_CERT_PATH
# 设置环境变量REQUESTS_CA_BUNDLE
ENV REQUESTS_CA_BUNDLE=$DOUYINCLOUD_CERT_PATH

## debian/ubuntu
#RUN apt install ca-certificates -y
# alpine
#RUN apk add ca-certificates
# centos/fedora/rhelca-certificates
#RUN yum install ca-certificates

## 执行信任证书
#RUN update-ca-certificates

RUN chmod 777 run.sh
# CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]
CMD ["/bin/sh", "./run.sh"]
