defmodule CampCleanup do
  def run do
    File.stream!("data.txt")

    |> Stream.map(&String.replace(&1, "\n", ""))

    # Split on the comma
    |> Stream.map(&String.split(&1, ","))

    # Split on the dash
    |> Stream.map(fn assignments -> Enum.map(assignments, &String.split(&1,"-")) end)

    # Get the ranges
    |> Stream.map(fn assignments -> Enum.map(assignments, &get_ranges(&1)) end)
  end

  def get_ranges(range) do

    # Convert range to integers
    range
    |> Enum.map(&String.to_integer/1)

  end

  def check_sub_range_one(range1, range2) do

    range1_low = Enum.at(range1, 0)
    range1_high = Enum.at(range1, 1)
    range2_low = Enum.at(range2, 0)
    range2_high = Enum.at(range2, 1)

    # Check if either range is completely enveloped in the other
    (range1_low >= range2_low and range1_high <= range2_high) or (range2_low >= range1_low and range2_high <= range1_high)
  end

  def run_part_one do

    num_overlapping_assignments = run()

    # Check subranges
    |> Stream.map(&(check_sub_range_one(Enum.at(&1, 0), Enum.at(&1, 1))))

    # Count if true
    |> Enum.count(fn sub_range_value -> sub_range_value == :true end)


    IO.puts(num_overlapping_assignments)
  end

  def check_sub_range_two(range1, range2) do

    range1_low = Enum.at(range1, 0)
    range1_high = Enum.at(range1, 1)
    range2_low = Enum.at(range2, 0)
    range2_high = Enum.at(range2, 1)

    # Create map sets
    range1_num = MapSet.new(range1_low..range1_high)
    range2_num = MapSet.new(range2_low..range2_high)

    # Check if intersection is non-empty
    MapSet.intersection(range1_num, range2_num) != MapSet.new([])
  end

  def run_part_two do

    num_overlapping_assignments = run()

    # Check subranges
    |> Stream.map(&(check_sub_range_two(Enum.at(&1, 0), Enum.at(&1, 1))))

    # Count if true
    |> Enum.count(fn sub_range_value -> sub_range_value == :true end)


    IO.puts(num_overlapping_assignments)
  end
end

CampCleanup.run_part_one()
CampCleanup.run_part_two()
