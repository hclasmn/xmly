FROM python:alpine3.11
ADD . /usr/src/app
WORKDIR /usr/src/app
# 基础镜像已经包含pip组件
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
    && apk update \
    #&& apk add bash autoconf g++ \
    #&& pip install --no-cache-dir -r requirements.txt \
    && pip install requests \
    && crontab ./cron.sh
# 添加挂载点
VOLUME ["/usr/src/app/"]
ENTRYPOINT ["/usr/sbin/crond","-f","-L","/var/log/cron/cron.log"]
