import sys
import json
import re


def assign_frequency(tweet_file):
    all_terms = {}
    all_freq = 0

    for line in tweet_file:
        js = json.loads(line)
        if 'text' in js:
            txt = re.sub('@\w+', '', js['text'])
            tweet_terms = re.split('\W+', txt)
            for t in tweet_terms:
                if len(t) > 2 and re.match('[a-zA-Z]', t):
                    if t in all_terms:
                        all_terms[t] += 1.0
                    else:
                        all_terms[t] = 1.0
                    all_freq += 1.0

    for t in sorted(all_terms.keys()):
        freq = all_terms[t] / all_freq
        if freq:
            print t, freq
        else:
            print t, 0.0


def main():
    tweet_file = open(sys.argv[1])
    assign_frequency(tweet_file)


if __name__ == '__main__':
    main()
