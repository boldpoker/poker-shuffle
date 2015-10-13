defmodule PokerShuffle.Distributions do


  @doc """
  Returns a hashdict representing the occurences of each card at a position

  ## Examples

      iex> deck = PokerShuffle.PokerCards.deck
      iex> PokerShuffle.Distributions.build(deck, fn -> PokerShuffle.Shuffles.fisher_yates(deck) end, 1000)
      #HashDict<[{"3s",
      [17, 17, 14, 13, 27, 18, 16, 26, 15, 20, 18, 24, 24, 13, 17, 23, 21, 12, 19, 18, 21, 20, 20, 9, 16, 18, 24, 22, 18,
      15, 20, 26, 17, 21, 19, 16, 20, 22, 29, 22, 15, 22, 17, 10, 27, 20, 28, 17, 17, 19, 19, 22]},
      {"Jd",
      [22, 20, 25, 25, 21, 11, 24, 20, 17, 17, 25, 22, 23, 15, 16, 22, 19, 19, 21, 18, 12, 16, 20, 24, 27, 20, 21, 20, 22,
      19, 16, 21, 17, 21, 25, 16, 11, 20, 22, 14, 17, 17, 23, 20, 22, 18, 18, 16, 22, 14, 12, 15]},
      {"Kd",...
  """
  def build(deck, shuffle_fun, count, acc \\ HashDict.new)
  def build(_deck, _shuffle_fun, count, acc) when count == 0, do: acc
  def build(deck, shuffle_fun, count, acc) do
    cards = shuffle_fun.()
    acc = case HashDict.keys(acc) do
      [] -> dict_from_deck(deck)
      _ -> acc
    end

    acc = Enum.reduce(Enum.with_index(cards), acc, fn({card, index}, acc) ->
      positions = acc[card] |> List.update_at(index, &(&1 + 1))
      HashDict.put(acc, card, positions)
    end)

    build(deck, shuffle_fun, count - 1, acc)
  end

  def to_csv(deck, %HashDict{} = distributions_map) do
    header = deck |> Enum.join(",")
    lines = HashDict.values(distributions_map)
    |> Enum.map(fn(positions) -> Enum.join(positions, ",") end)
    |> Enum.join("\n")
    header <> "\n" <> lines
  end

  def dict_from_deck(deck) do
    cards_count = deck |> Enum.count
    Enum.map(deck, fn(card) ->
      positions = Enum.map(0..(cards_count - 1), fn(_) -> 0 end)
      {card, positions}
    end)
    |> Enum.into(HashDict.new)
  end
end
