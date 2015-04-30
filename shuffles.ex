defmodule Shuffles do
  @suits ["s", "c", "h", "d"]
  @ranks ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"]
  @deck for rank <- @ranks, suit <- @suits, do: rank <> suit

  def fisher_yates(cards \\ @deck) do
    card_count = Enum.count(cards)
    Enum.reduce 0..(card_count - 1), cards, fn(i, shuffled_cards) ->
      swap(shuffled_cards, i, rand_uniform(i, card_count))
    end
  end

  def wrong(cards \\ @deck) do
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
