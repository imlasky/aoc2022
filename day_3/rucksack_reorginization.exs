defmodule RuckSack do

  def get_mapping do
    # Get all characters between 'a' and 'z'
    a_to_z = ?a..?z

    # Map them to strings
    |> Enum.map(&List.to_string([&1]))

    # Zip them with numbers 1 to 26
    |> Enum.zip(1..26)

    # Convert into a map
    |> Enum.into(%{})


    # Similar to above but for capital letters
    capital_a_to_z = ?A..?Z
    |> Enum.map(&List.to_string([&1]))
    |> Enum.zip(27..52)
    |> Enum.into(%{})

    # Merge the maps together
    Map.merge(a_to_z, capital_a_to_z)
  end

  def run do
    File.stream!("data.txt")

    |> Stream.map(&String.replace(&1, "\n", ""))
  end

  def run_part_one do

    all_a_to_z = get_mapping()

    # Get cleaned input data
    total_sum_priorities = run()

    # Split at half-way point
    |> Stream.map(&String.split_at(&1, trunc(String.length(&1)/2)))

    # Convert the tuple into a list
    |> Stream.map(&Tuple.to_list/1)

    # For each compartment, convert the string into a char list
    |> Stream.map(fn compartments -> Enum.map(compartments, &String.to_charlist/1) end)

    # Get the intersection of the two char lists by converting them to mapsets
    |> Stream.map(&MapSet.intersection(MapSet.new(Enum.at(&1, 0)), MapSet.new(Enum.at(&1, 1))))

    # Convert back to lists
    |> Stream.map(&MapSet.to_list/1)

    # Convert to string
    |> Stream.map(&List.to_string([&1]))

    # Index the map
    |> Enum.map(&all_a_to_z[&1])

    # Sum results
    |> Enum.sum

    IO.inspect(total_sum_priorities)
  end
end

RuckSack.run_part_one()
