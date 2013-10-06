import urllib2 as urllib
from xml.dom.minidom import parseString
from clay import config




def hashtag(game, broadcast_info):
  if broadcast_info['network'] != '' or broadcast_info['satellite'] != '' or broadcast_info['cable'] != '':
    return '#{}vs{}'.format(game.attributes['home'].value, game.attributes['away'].value)
  else:
    return None

def sportsdatareq(week, year, sportsdata_key, sportsdata_base_url):
  # hardcoded response for week 7 of 2013 season for now
  
  if not 'sportsdata_key' in locals() or not 'sportsdata_base_url' in locals():
    sportsdata_key = 'u9x6nxranr5kv924nhhxudav'
    sportsdata_base_url = 'http://api.sportsdatallc.org/ncaafb-t1/'
    
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
  """home_teams = [game.attributes['home'].value for game in xml]
  away_teams = [game.attributes['away'].value for game in xml]
  players = []
  team_names = []
  for game in xml:
    # only care about games that are broadcast
    broadcast_info = game.getElementsByTagName('broadcast')[0].attributes
    if broadcast_info['network'].value != '' or broadcast_info['satellite'].value != '' or broadcast_info['cable'].value != '':
      print broadcast_info['network'].value, broadcast_info['satellite'].value, broadcast_info['cable'].value
      home_team = game.attributes['home'].value
      away_team = game.attributes['away'].value
      print home_team, away_team
      # get info about each team
      for team in (home_team, away_team):
        team_url = '{}teams/{}/roster.xml?api_key={}'.format(sportsdata_base_url, team, sportsdata_key)
        roster = parseString(urllib.urlopen(team_url).read()).getElementsByTagName('team')
        team_names.append(roster[0].attributes['name'].value)
        players += [player.attributes['name_full'].value for player in roster[0].getElementsByTagName('player')]
  return home_teams, away_teams, team_names, players"""