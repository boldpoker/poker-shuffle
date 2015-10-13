defmodule PokerShuffle.Distributions do

  def build(shuffle_fun, count, acc \\ %{})
  def build(_shuffle_fun, count, acc) when count == 0, do: acc
  def build(shuffle_fun, count, acc) do
    cards = shuffle_fun.()
    acc = case Map.keys(acc) do
      [] -> map_from_cards(cards)
      _ -> acc
    end

    acc = Enum.reduce(Enum.with_index(cards), acc, fn({card, index}, acc) ->
      positions = acc[card] |> List.update_at(index, &(&1 + 1))
      Map.put(acc, card, positions)
    end)

    build(shuffle_fun, count - 1, acc)
  end

  def to_csv(%{} = distributions_map) do
    header = distributions_map |> Map.keys |> Enum.join(",")
    lines = Map.values(distributions_map)
    |> Enum.map(fn(positions) -> Enum.join(positions, ",") end)
    |> Enum.join("\n")
    header <> "\n" <> lines
  end

  defp map_from_cards(cards) do
    cards_count = cards |> Enum.count
    Enum.map(cards, fn(card) ->
      positions = Enum.map(0..(cards_count - 1), fn(_) -> 0 end)
      {card, positions}
    end)
    |> Enum.into(%{})
  end
end
