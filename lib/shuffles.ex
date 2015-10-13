defmodule PokerShuffle.Shuffles do
  alias PokerShuffle.PokerCards

  def fisher_yates(cards \\ PokerCards.deck) do
    card_count = Enum.count(cards)
    result = Enum.reduce 0..(card_count - 1), cards, fn(i, shuffled_cards) ->
      swap(shuffled_cards, i, rand_uniform(i, card_count))
    end
  end

  def wrong(cards \\ PokerCards.deck) do
    card_count = Enum.count(cards)
    Enum.reduce 0..(card_count - 1), cards, fn(i, shuffled_cards) ->
      swap(shuffled_cards, i, rand_uniform(0, card_count))
    end
  end

  defp swap(list, i, j) do
    i_element = Enum.at(list, i)
    j_element = Enum.at(list, j)
    list |> List.replace_at(i, j_element) |> List.replace_at(j, i_element)
  end

  defp rand_uniform(lo, hi) do
    :crypto.rand_uniform(lo, hi)
  end
end
