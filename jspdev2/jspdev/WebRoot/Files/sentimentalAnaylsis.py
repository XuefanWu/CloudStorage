import nltk
import string
import pickle
from nltk.util import LazyMap


pos_sent = open("positive.txt").read()
poswd = pos_sent.split('\r\n')
neg_sent = open("negative.txt").read()
negwd = neg_sent.split('\r\n')


review_file = open("24kData.txt")
lines = review_file.readlines()
pos = []
neg = []
i = 1000-1
for line in lines:
    delset=string.punctuation
    line=line.translate(None,delset)
    line=line.lower()
    line_string = line.split('\t')
    if line_string[0] == '1':
        neg.append((line_string[1], 'negative'))
    else:
        pos.append((line_string[1], 'positive'))
    i -= 1
    if i < 0:
        break
review_file.close()

neglib=open("negative.txt")
neglines=neglib.readlines()
for negline in neglines:
 neg.append((negline,'negative'))
neglib.close()

poslib=open("positive.txt")
poslines=poslib.readlines()
for posline in poslines:
 pos.append((posline,'positive'))
poslib.close()

reviews = []
for (words, sentiment) in pos + neg:
    words_filtered = [e.lower() for e in words.split() if len(e) >= 3]
    words_extract_sent=[]
    for word in words_filtered:
     if word in poswd or word in negwd:
      words_extract_sent.append(word)
     if len(words_extract_sent):
      reviews.append(( words_extract_sent, sentiment))


def get_words_in_reviews(reviews):
    all_words = []
    for (words, sentiment) in reviews:
        all_words.extend(words)
    return all_words


def get_word_features(wordlist):
    wordlist = nltk.FreqDist(wordlist)
    word_features = wordlist.keys()
    return word_features

word_features = get_word_features(get_words_in_reviews(reviews))

f3=open('word_features.txt','wb')
for i in word_features:
 f3.write(i+"\n")
f3.close()


def extract_features(document):
    document_words = set(document)
    features = {}
    for word in word_features:
        features['contains(%s)' % word] = (word in document_words)
    return features


training_set = nltk.classify.apply_features(extract_features, reviews)
classifier = nltk.NaiveBayesClassifier.train(training_set)
f=open('my_classifier01.pickle','wb')
pickle.dump(classifier,f)
f.close()




