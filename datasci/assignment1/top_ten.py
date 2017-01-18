import sys
import json


def find_top_ten(tweet_file):
    tags_freq = {}

    for line in tweet_file:
        js = json.loads(line)
        if 'entities' in js \
                and 'hashtags' in js['entities'] \
                and len(js['entities']['hashtags']) > 0:
            for tag in js['entities']['hashtags']:
                t = tag['text']
                if t in tags_freq:
                    tags_freq[t] += 1
                else:
                    tags_freq[t] = 1

    i = 0
    for t in sorted(tags_freq.keys(), key=lambda x: tags_freq[x], reverse=True):
        print t, tags_freq[t]
        i += 1
        if i > 9:
            break


def main():
    tweet_file = open(sys.argv[1])
    find_top_ten(tweet_file)


if __name__ == '__main__':
    main()
