defmodule PokerShuffle.PokerCards do
  def deck do
    suits = ["s", "c", "h", "d"]
    ranks = ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"]
    for rank <- ranks, suit <- suits, do: rank <> suit
  end
end
