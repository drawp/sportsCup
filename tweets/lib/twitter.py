import oauth2 as oauth
import urllib2 as urllib
import json
from clay import config

access_token_key = config.get('twitter.access_token_key')
access_token_secret = config.get('twitter.access_token_secret')
consumer_key = config.get('twitter.consumer_key')
consumer_secret = config.get('twitter.consumer_secret')

_debug = 0
oauth_token    = oauth.Token(key=access_token_key, secret=access_token_secret)
oauth_consumer = oauth.Consumer(key=consumer_key, secret=consumer_secret)
signature_method_hmac_sha1 = oauth.SignatureMethod_HMAC_SHA1()
http_method = "GET"
http_handler  = urllib.HTTPHandler(debuglevel=_debug)
https_handler = urllib.HTTPSHandler(debuglevel=_debug)

def twitterreq(url, method, parameters):
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

#def fetchsamples(team_codes, team_names, player_names, lat, lng, radius):
#def fetchsamples(hashes, lat, lng, radius):
def fetchsamples(hashes):
  tweets = []
  #team_codes_hash = ['#{}'.format(x) for x in team_codes]
  #team_names = [x.lower() for x in team_names]
  #team_names_hash = ['#{}'.format(x) for x in team_names]
  #player_names = [x.lower() for x in player_names]
  #player_names_hash = ['#{}'.format(x.replace(' ', '')) for x in player_names]
  #query='football ncaaf ncaa sports gameday espn'
  #query='#ncaaf OR #ncaa OR ncaaf OR ncaa OR college football OR {}'.format(' OR '.join(team_codes[0:10]))
  query='{}'.format(' OR '.join(hashes.keys()))
  #geocode='&geocode={},{},{}mi'.format(lat, lng, radius)
  geocode=''
  #url = "https://stream.twitter.com/1/statuses/filter.json?track=football,ncaa,ncaaf"#{}".format(track_tags)
  url = "https://api.twitter.com/1.1/search/tweets.json?q={}{}".format(
                urllib.quote(query), geocode)
  print url
  parameters = []
  response = twitterreq(url, "GET", parameters)
  #import pdb; pdb.set_trace()
  response = json.loads(response.read())['statuses']
  #import ipdb; ipdb.set_trace()
  for tweet in response:
    try:
      coordinates = tweet['coordinates']
    except KeyError:
      coordinates = None
    for htag in hashes.keys():
      if htag.lower() in tweet['text'].lower():
        tweets.append({'user': tweet['user']['screen_name'],
                        'location': tweet['user']['location'],
                        'tweet': tweet['text'],
                        'coordinates': coordinates, 'game_info': hashes[htag]})
  """for tweet in response:
    print tweet
    try:
      coordinates = tweet['coordinates']
    except KeyError:
      coordinates = None
    # must match an exact word
    text_words = [x.lower() for x in tweet['text'].split(' ')]
    #tweets.append({'user': tweet['user']['screen_name'],
                      #'tweet': tweet['text'],
                      #'coordinates': coordinates})
    if (any(word.lower() in tweet['text'].lower() for word in team_names) or
        any(word.lower() in tweet['text'].lower() for word in team_names_hash) or
        any(word.lower() in tweet['text'].lower() for word in player_names) or
        any(word.lower() in tweet['text'].lower() for word in player_names_hash) or
                        len(set(text_words) & set(team_codes)) > 0 or
                        len(set(text_words) & set(team_codes_hash)) > 0):
      tweets.append({'user': tweet['user']['screen_name'],
                        'tweet': tweet['text'],
                        'coordinates': coordinates})"""
  return json.dumps(tweets)