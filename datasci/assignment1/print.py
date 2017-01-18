import urllib
import json

for i in xrange(1, 11):
	url = "http://search.twitter.com/search.json?q=microsoft&page={0}".format(i)
	response = urllib.urlopen(url)
	res = json.load(response)
	if res['results']:
		for record in res['results']:
			print record['text'].encode('utf-8')