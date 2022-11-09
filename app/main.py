import os

from flask import Flask, request, make_response
import requests
import time

app = Flask(__name__)

@app.route('/')
def root():
    return '欢迎使用抖音云托管！'

@app.route('/v1/ping')
def ping():
    return "TZ:"+os.environ.get('TZ', 'unknown')+" NowTime:"+time.asctime(time.localtime(time.time()))


@app.route('/network_test')
def network_test():
    # Base URL being accessed
    protocol = request.args.get("protocol", "http")
    preffix = "http://"
    if protocol == "https":
        preffix = "https://"

    url = request.args.get("url", "developer.toutiao.com/api/apps/qrcode")
    url = preffix + url
    # Dictionary of query parameters (if any)
    parms = {
        'appname': 'douyin'
    }
    # Extra headers
    headers = {
        "Content-Type": "application/json"
    }


    # logid = request.headers["X-Tt-Logid"]
    # response = Flask.Response()
    # response.headers["r-logid"] = logid

    resp = requests.post(url, data=parms, headers=headers)
    # print("resp:", resp)
    # return "status:"+resp.status+"\nresp:"+resp.json()+"\n"
    return resp.json()


if __name__ == "__main__":
    app.run(debug=True,host='0.0.0.0',port=int(os.environ.get('PORT', 8000)))
