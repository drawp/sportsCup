import json
from geopy import geocoders
import time
import re

VALID_WORD = re.compile(r'^["\']*([a-z]+)[^a-z]*$')
output_file = open('tweet_loc_sentiment.csv','w')

g = geocoders.GoogleV3()
us = geocoders.GeocoderDotUS()
#gn = geocoders.GeoNames() 

def count_occurrences(text):
    count_dict = {}
    for word in text.split(' '):
        try:
            word = VALID_WORD.match(word.strip().lower()).group(1)
        # continue if pattern does not match
        except AttributeError:
            continue
        try:
            count_dict[word] += 1
        except KeyError:
            count_dict[word] = 1
    return count_dict

def sentiment_to_dict(sentiment):
    scores = {}
    for line in open(sentiment,'r').read().split('\n'):
        term, score = line.split("|")
        scores[term] = int(score)
    return scores

def tweet_sentiment(tweet,sent_scores):
    sentiment = 0
    word_count = count_occurrences(tweet)
    for word in word_count:
        try:
            sentiment += sent_scores[word] * word_count[word]
            # do nothing if word not found
        except KeyError:
            pass
    return sentiment

sent_dict = sentiment_to_dict('sentiments.txt')

tweets = open('nfl_tweets.json', 'r')
all_tweets = []
for line in tweets:
  try:  
    for tweet in json.loads(line):
      if tweet['tweet'] not in all_tweets:
        try:
          sentiment = tweet_sentiment(tweet['tweet'],sent_dict)
        except KeyError:
          sentiment = 0
        if tweet['coordinates']:
          print 'C', tweet['game_info']['hashtag'], tweet['coordinates']['coordinates'][1], tweet['coordinates']['coordinates'][0], sentiment
          output_file.write('C', tweet['game_info']['hashtag'], tweet['coordinates']['coordinates'][1], tweet['coordinates']['coordinates'][0], sentiment)
          all_tweets.append(tweet['tweet'])
        elif tweet['location'] != '':
          time.sleep(2)
          try:
            place, (lat, lng) = g.geocode(tweet['location'], exactly_one=False)[0]
            print 'L', tweet['game_info']['hashtag'], lat, lng, sentiment
            output_file.write('L', tweet['game_info']['hashtag'], lat, lng, sentiment)
            all_tweets.append(tweet['tweet'])
          except:
            pass
  except ValueError:
    pass
