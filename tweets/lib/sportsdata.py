import urllib2 as urllib
from xml.dom.minidom import parseString
from clay import config




def hashtag(game, broadcast_info):
  if broadcast_info['network'] != '' or broadcast_info['satellite'] != '' or broadcast_info['cable'] != '':
    return '#{}vs{}'.format(game.attributes['home'].value, game.attributes['away'].value)
  else:
    return None

def sportsdatareq(week, year, sportsdata_key, sportsdata_base_url):
  
  schedule_url = '{}{}/reg/{}/schedule.xml?api_key={}'.format(sportsdata_base_url, year, week, sportsdata_key)
  print schedule_url
  xml = parseString(urllib.urlopen(schedule_url).read()).getElementsByTagName('game')
  htag_lookup = {}
  for game in xml:
    broadcast = game.getElementsByTagName('broadcast')[0].attributes
    broadcast_info = {'network': broadcast['network'].value,
                      'satellite': broadcast['satellite'].value,
                      'cable': broadcast['cable'].value}
    htag = hashtag(game, broadcast_info)
    if htag:
      htag_lookup[htag] = {'game_id': game.attributes['id'].value, 'broadcast': broadcast_info}
  return htag_lookup
