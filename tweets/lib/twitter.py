import oauth2 as oauth
import urllib2 as urllib
import json
from clay import config



def twitterreq(url, method, parameters, access_token_key, access_token_secret, consumer_key, consumer_secret):
  
  _debug = 0
  oauth_token    = oauth.Token(key=access_token_key, secret=access_token_secret)
  oauth_consumer = oauth.Consumer(key=consumer_key, secret=consumer_secret)
  signature_method_hmac_sha1 = oauth.SignatureMethod_HMAC_SHA1()
  http_method = "GET"
  http_handler  = urllib.HTTPHandler(debuglevel=_debug)
  https_handler = urllib.HTTPSHandler(debuglevel=_debug)
  
  req = oauth.Request.from_consumer_and_token(oauth_consumer,
                                             token=oauth_token,
                                             http_method=http_method,
                                             http_url=url, 
                                             parameters=parameters)

  req.sign_request(signature_method_hmac_sha1, oauth_consumer, oauth_token)

  headers = req.to_header()

  if http_method == "POST":
    encoded_post_data = req.to_postdata()
  else:
    encoded_post_data = None
    url = req.to_url()

  opener = urllib.OpenerDirector()
  opener.add_handler(http_handler)
  opener.add_handler(https_handler)

  response = opener.open(url, encoded_post_data)

  return response


def fetchsamples(hashes, access_token_key, access_token_secret, consumer_key, consumer_secret):
  
  
  tweets = []
  query='{}'.format(' OR '.join(hashes.keys()))
  geocode=''
  url = "https://api.twitter.com/1.1/search/tweets.json?q={}{}".format(
                urllib.quote(query), geocode)
  print url
  parameters = []
  response = twitterreq(url, "GET", parameters, access_token_key, access_token_secret, consumer_key, consumer_secret)
  response = json.loads(response.read())['statuses']
  hashes_w_tweets = {}
  for tweet in response:
    try:
      coordinates = tweet['coordinates']
    except KeyError:
      coordinates = None
    for htag in hashes.keys():
      hashes_w_tweets['htag'] = True
      if htag.lower() in tweet['text'].lower():
        tweets_found = True
        tweets.append({'user': tweet['user']['screen_name'],
                        'location': tweet['user']['location'],
                        'tweet': tweet['text'],
                        'coordinates': coordinates, 'game_info': hashes[htag]})
  for htag in hashes.keys():
    if htag not in hashes_w_tweets.keys():
      tweets.append({'user': None, 'location': None, 'tweet': None, 'coordinates': None, 'game_info': hashes[htag]})
  return json.dumps(tweets)
