#FROM tiangolo/uwsgi-nginx-flask:python3.8
#FROM python:3.8-slim-buster
FROM public-cn-beijing.cr.volces.com/public/base:python-3.10.6
WORKDIR /opt/application
COPY . .
RUN pip3 install -r requirements.txt
RUN chmod 777 run.sh
# CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]
CMD ["/bin/sh", "./run.sh"]
