import requests
import json
import time

while True:
  params = {'week': 5, 'year': 2013}
  headers = {'content-type': 'application/json'}
  tweets = requests.post('http://127.0.0.1:1234/tweets/nfl', data=json.dumps(params), headers=headers)
  print tweets.text
  time.sleep(5)
