# BoldPoker Shuffle Analysis

[BoldPoker](http://boldpoker.net) uses the [Fisher-Yates shuffle](http://en.wikipedia.org/wiki/Fisher–Yates_shuffle) to guarantee unbiased shuffling of the deck.
Naïve shuffling implementations introduce predictable biases which gives exploitable information to players who are aware of this.

The `Shuffles` module in `shuffles.ex` contains implementations of Fisher-Yates as well as a subtly-wrong shuffle implementation.
The .csv files in `distributions` compare the distribution produced by both shuffle algorithms for various sample sizes (it takes a while for the biases to become visible).

Visualisations of the distributions can be found here:
https://boldpoker.net/design#bold_poker_shuffle

The raw data – a list of 1mm decks shuffled with each respective algorithm – can be downloaded here:
[BoldPoker decks](https://www.dropbox.com/s/njwpg3svmh447fk/boldpoker_shuffle_1000000_hands.gz?dl=0)
[BotchedPoker decks](https://www.dropbox.com/s/am6kjehfjj15e28/botchedpoker_shuffle_1000000_hands.gz?dl=0)

