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
    state_sentiment = {}

    for line in tweet_file:
        js = json.loads(line)
        if 'text' in js and 'place' in js and js['place'] and js['place']['country_code'] == 'US':
            city_state = js['place']['full_name'].encode('utf8').split(', ')
            if city_state[1] != 'US':
                score = get_score(js['text'])
                state = city_state[1]
                if state not in state_sentiment:
                    state_sentiment[state] = []
                state_sentiment[state].append(score)

    for state in state_sentiment:
        average = (0.0 + sum(state_sentiment[state])) / len(state_sentiment[state])
        state_sentiment[state] = average

    print max(state_sentiment, key=state_sentiment.get)
    #for state in sorted(state_sentiment, key=lambda x: state_sentiment[x], reverse=True):
    #    print state, state_sentiment[state]

def main():
    sent_file = open(sys.argv[1])
    tweet_file = open(sys.argv[2])
    read_scores(sent_file)
    print_scores(tweet_file)


if __name__ == '__main__':
    main()
