from __future__ import absolute_import
from clay import app, config
from flask import request, abort
from lib import twitter, sportsdata
import json

@app.route('/', methods=['GET'])
def health():
  return 'OK'
  
@app.route('/tweets/<path:ncaaf_or_nfl>', methods=['POST'])
def tweets(ncaaf_or_nfl):
  """Find all tweets relevant to NCAA football games in a given week."""
  
  sportsdata_key = config.get('sportsdata.key')
  access_token_key = config.get('twitter.access_token_key')
  access_token_secret = config.get('twitter.access_token_secret')
  consumer_key = config.get('twitter.consumer_key')
  consumer_secret = config.get('twitter.consumer_secret')
  
  if ncaaf_or_nfl not in ('ncaaf', 'nfl'):
    abort(400)
  
  try:
    request_info = request.json
  except AttributeError:
    abort(400)
  if not request_info:
    abort(400)
  year = request_info.get('year', None)
  week = request_info.get('week', None)
  if not (year and week):
    abort(400)
  htags = sportsdata.sportsdatareq(week, year, sportsdata_key, ncaaf_or_nfl)
  return twitter.fetchsamples(htags, access_token_key, access_token_secret, consumer_key, consumer_secret)

@app.route('/establishments', methods=['POST'])
def biz():
  """Dummy establishment data."""

  json_result = open('data/sample_tweets.json', 'r').read()
  return json_result
