import oauth2 as oauth
import urllib2 as urllib
import sys
from lib import sportsdata


# See Assignment 1 instructions or README for how to get these credentials
access_token_key = "1414604976-4J8Fdcuk98aFEVtgGfcYL6OZ1cmabMblhH5iUJB"
access_token_secret = "Nc8pI8JAKmWJNWAcEtFeRAgX1hTex9G4LVQ7uRkD24"
consumer_key = "4fvDx0WrbThEeZB523LGTQ"
consumer_secret = "TMsGBcT3VM9zGpL1Y9jJ4aXLppzhroMh8vcgj2KGWw"

_debug = 0

oauth_token    = oauth.Token(key=access_token_key, secret=access_token_secret)
oauth_consumer = oauth.Consumer(key=consumer_key, secret=consumer_secret)

signature_method_hmac_sha1 = oauth.SignatureMethod_HMAC_SHA1()

http_method = "GET"


http_handler  = urllib.HTTPHandler(debuglevel=_debug)
https_handler = urllib.HTTPSHandler(debuglevel=_debug)

'''
Construct, sign, and open a twitter request
using the hard-coded credentials above.
'''
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
  
def fetchsamples(htag):
  url = "https://stream.twitter.com/1/statuses/sample.json"
  parameters = []
  response = twitterreq(url, "GET", parameters)
  for line in response:
    print line.strip()
  
# url = "https://stream.twitter.com/1/statuses/filter.json?track=football"#"{}".format(','.join(hashes.keys()))
if __name__ == '__main__':
  sportsdata_key = "u9x6nxranr5kv924nhhxudav"
  sportsdata_base_url = "http://api.sportsdatallc.org/ncaafb-t1/"
  week = sys.argv[2]
  year = sys.argv[1]
  htag_lookup = sportsdata.sportsdatareq(week, year, sportsdata_key, sportsdata_base_url)
  print str(htag_lookup)
  #fetchsamples(htag_lookup)
  #fetchsamples(home_teams + away_teams + team_names + players)
  #fetchsamples([u'APY', u'LOU', u'NCC', u'TNT', u'AF', u'USC', u'CIN', u'MER', u'NH', u'ARM', u'TCU', u'CHA', u'CMB', u'TEX', u'DEL', u'HOU', u'VT', u'TT', u'UCONN', u'MSU', u'STF', u'PUR', u'UGA', u'ARK', u'DUK', u'COR', u'DAV', u'PRI', u'GTOWN', u'BUT', u'GSO', u'HOW', u'BUC', u'BRY', u'SCH', u'STU', u'DUQ', u'VMI', u'DRT', u'WOF', u'DLS', u'HAMP', u'WMC', u'ALAST', u'SEM', u'AUB', u'NDS', u'OHI', u'SD', u'MVS', u'SHS', u'UMASS', u'BALL', u'CSU', u'TUL', u'APP', u'WM', u'JM', u'WYO', u'KST', u'CLE', u'GST', u'UND', u'WIS', u'LSU', u'MAR', u'NCST', u'JVS', u'WIL', u'WAS', u'UTSA', u'UCA', u'ALCST', u'NIC', u'SUT', u'FAU', u'UNI', u'NIL', u'PSU', u'IDS', u'SDG', u'CGT', u'CHT', u'SVS', u'CC', u'UTH', u'ARKS', u'SU', u'KEN', u'YSU', u'NTX', u'TWN', u'APB', u'UCD', u'TXST', u'BYU', u'MSST', u'FIU', u'TEP', u'UTS', u'SEL', u'UNLV', u'HB', u'MIS', u'CPS', u'CSUS', u'ASU', u'WST', u'UCLA', u'EIL', u'RUT', u'SCS', u'TNM', u'SDSU', u'ARI', u'TEM', u'VAL', u'RIL', u'EMC', u'KAN', u'UNCP', u'LEI', u'OKL', u'ALB', u'MEM', u'PIT', u'ISU', u'USF', u'IU', u'MON', u'NEB', u'MIZ', u'SC', u'NAV', u'HAR', u'DRA', u'LAF', u'FOR', u'CAM', u'CIT', u'BCU', u'HC', u'BRN', u'CCSU', u'DAY', u'WAG', u'CCH', u'YAL', u'ELO', u'NFS', u'NAT', u'BUF', u'PRV', u'MUR', u'WC', u'MIZST', u'CMC', u'INDS', u'JST', u'LAM', u'MOH', u'KNT', u'SJS', u'ECU', u'SAM', u'PEN', u'RCH', u'NM', u'BAY', u'BC', u'TRY', u'EW', u'NW', u'FLA', u'UVA', u'SYR', u'TNST', u'SDS', u'ORE', u'RICE', u'UNK', u'GRA', u'NWS', u'PRST', u'MSH', u'SIL', u'AKR', u'MICH', u'NOCO', u'MST', u'SBK', u'FUR', u'FAMU', u'GWB', u'STA', u'IDA', u'AAM', u'BAMA', u'ILS', u'MTS', u'VIL', u'TSO', u'MONT', u'ULM', u'GT', u'BGN', u'UAB', u'TSA', u'BOISE', u'SAU', u'HAW', u'ACU', u'TXAM', u'WBS', u'NAZ', u'COL', u'ORS', u'CAL'], 
                #[u'Cardinals', u'Knights', u'Eagles', u'Bulldogs', u'Falcons', u'Aztecs', u'Trojans', u'Wildcats', u'Bearcats', u'Owls', u'Knights', u'Eagles', u'Lions', u'Hawks', u'Longhorns', u'Sooners', u'Cougars', u'Tigers', u'Hokies', u'Panthers', u'Raiders', u'Cyclones', u'Spartans', u'Hoosiers', u'Boilermakers', u'Cornhuskers', u'Bulldogs', u'Tigers', u'Razorbacks', u'Gamecocks', u'Rams', u'Spartans', u'Cowboys', u'Lobos', u'Wildcats', u'Bears', u'Tigers', u'Eagles', u'Badgers', u'Wildcats', u'Tigers', u'Gators', u'Terrapins', u'Cavaliers', u'Huskies', u'Ducks', u'Lions', u'Wolverines', u'Utes', u'Cardinal', u'Wildcats', u'Tide', u'Cougars', u'Jackets', u'Miners', u'Hurricane', u'Aggies', u'Broncos', u'Rebels', u'Aggies', u'Devils', u'Buffaloes', u'Cougars', u'Beavers', u'Bruins', u'Bears'])