import sys
import json
import re

scores = {}


def get_score(txt):
    score = 0
    if txt:
        for uterm in scores:
            if re.match(u'.*\\b' + uterm + u'\\b.*', txt):
                #print '{0} matches {1}'.format(uterm, txt.encode('utf-8'))
                score += scores[uterm]
    return score


def read_scores(sent_file):
    for line in sent_file:
        term, score = line.split("\t")
        uterm = unicode(term, encoding="latin1")
        scores[uterm] = int(score)


def print_scores(tweet_file):
    for line in tweet_file:
        js = json.loads(line)
        if 'text' in js:
            print get_score(js['text'])
        else:
            print 0


def main():
    sent_file = open(sys.argv[1])
    tweet_file = open(sys.argv[2])
    read_scores(sent_file)
    print_scores(tweet_file)


if __name__ == '__main__':
    main()
