import sys
import json
import re

scores = {}


def read_scores(sent_file):
    for line in sent_file:
        term, score = line.split("\t")
        uterm = unicode(term, encoding="latin1")
        if re.match('.*[\s-].*', uterm):
            scores[uterm] = float(score)


def get_score(txt):
    tweet_score = 0
    if txt:
        for uterm in scores:
            if re.match(u'.*\\b' + uterm + u'\\b.*', txt):
                txt = re.sub(uterm, '', txt)
                tweet_score += scores[uterm]
    return tweet_score


def assign_scores(tweet_file):
    new_terms = {}
    for line in tweet_file:
        js = json.loads(line)
        if 'text' in js:
            tweet_score = get_score(js['text'])
            txt = re.sub('@\w+', '', js['text'])
            tweet_terms = re.split('\W+', txt)
            for t in tweet_terms:
                if t not in scores and len(t) > 2 and re.match('[a-zA-Z]', t):
                    if t in new_terms:
                        if tweet_score < 0: new_terms[t]['neg'] += 1
                        if tweet_score > 0: new_terms[t]['pos'] += 1
                    else:
                        new_terms[t] = {'pos': 0, 'neg': 0}
                        if tweet_score < 0: new_terms[t]['neg'] = 1
                        if tweet_score > 0: new_terms[t]['pos'] = 1

    for t in sorted(new_terms.keys()):
        total = new_terms[t]['pos'] + new_terms[t]['neg']
        if total:
            print t, (new_terms[t]['pos'] - new_terms[t]['neg']) / total
        else:
            print t, 0.0


def main():
    sent_file = open(sys.argv[1])
    tweet_file = open(sys.argv[2])
    read_scores(sent_file)
    assign_scores(tweet_file)


if __name__ == '__main__':
    main()
