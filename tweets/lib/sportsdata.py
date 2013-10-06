import urllib2 as urllib
from xml.dom.minidom import parseString
from clay import config


team_lookup = {'AF': 'Falcons',
              'ARI': 'Wildcats',
              'ARK': 'Razorbacks',
              'ARM': 'Knights',
              'ASU': 'Devils',
              'BAMA': 'Tide',
              'BAY': 'Bears',
              'BC': 'Eagles',
              'BOISE': 'Broncos',
              'BYU': 'Cougars',
              'CAL': 'Bears',
              'CIN': 'Bearcats',
              'CLE': 'Tigers',
              'CMB': 'Lions',
              'COL': 'Buffaloes',
              'CSU': 'Rams',
              'EMC': 'Eagles',
              'FLA': 'Gators',
              'GT': 'Jackets',
              'HOU': 'Cougars',
              'ISU': 'Cyclones',
              'IU': 'Hoosiers',
              'KEN': 'Wildcats',
              'KST': 'Wildcats',
              'LEI': 'Hawks',
              'LOU': 'Cardinals',
              'LSU': 'Tigers',
              'MAR': 'Terrapins',
              'MEM': 'Tigers',
              'MICH': 'Wolverines',
              'MIS': 'Rebels',
              'MIZ': 'Tigers',
              'MSU': 'Spartans',
              'NCC': 'Eagles',
              'NEB': 'Cornhuskers',
              'NM': 'Lobos',
              'NW': 'Wildcats',
              'OKL': 'Sooners',
              'ORE': 'Ducks',
              'ORS': 'Beavers',
              'PIT': 'Panthers',
              'PSU': 'Lions',
              'PUR': 'Boilermakers',
              'RUT': 'Knights',
              'SC': 'Gamecocks',
              'SCS': 'Bulldogs',
              'SDSU': 'Aztecs',
              'SJS': 'Spartans',
              'STA': 'Cardinal',
              'TEM': 'Owls',
              'TEP': 'Miners',
              'TEX': 'Longhorns',
              'TSA': 'Hurricane',
              'TT': 'Raiders',
              'TXAM': 'Aggies',
              'UCLA': 'Bruins',
              'UGA': 'Bulldogs',
              'USC': 'Trojans',
              'UTH': 'Utes',
              'UTS': 'Aggies',
              'UVA': 'Cavaliers',
              'VT': 'Hokies',
              'WAS': 'Huskies',
              'WIS': 'Badgers',
              'WST': 'Cougars',
              'WYO': 'Cowboys'}

def hashtag(game, broadcast_info):
  if broadcast_info['network'] != '' or broadcast_info['satellite'] != '' or broadcast_info['cable'] != '':
    return '#{}vs{}'.format(game.attributes['home'].value, game.attributes['away'].value)
  else:
    return None

def sportsdatareq(week, year, sportsdata_key, sportsdata_base_url):
  
  schedule_url = '{}{}/reg/{}/schedule.xml?api_key={}'.format(sportsdata_base_url, year, week, sportsdata_key)
  xml = parseString(urllib.urlopen(schedule_url).read()).getElementsByTagName('game')
  htag_lookup = {}
  for game in xml:
    broadcast = game.getElementsByTagName('broadcast')[0].attributes
    broadcast_info = {'network': broadcast['network'].value,
                      'satellite': broadcast['satellite'].value,
                      'cable': broadcast['cable'].value}
    htag = hashtag(game, broadcast_info)
    if htag:
      try:
        hometeam = team_lookup[game.attributes['home'].value]
      except KeyError:
        hometeam = 'Matties'
      try:
        awayteam = team_lookup[game.attributes['away'].value]
      except KeyError:
        awayteam = 'Matties'
      htag_lookup[htag] = {'game_id': game.attributes['id'].value, 'broadcast': broadcast_info,
                            'home_team': hometeam, 'away_team': awayteam, 'hashtag': htag}
  return htag_lookup
