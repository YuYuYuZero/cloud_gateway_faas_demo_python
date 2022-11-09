#FROM tiangolo/uwsgi-nginx-flask:python3.8
FROM python:3.8-slim-buster
WORKDIR /app
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
COPY ./app /app
# CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]
CMD ["python3", "main.py"]
