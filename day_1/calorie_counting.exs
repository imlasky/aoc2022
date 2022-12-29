defmodule CalorieCounting do

  def run do
     # Read in data
     File.stream!("data.txt")

     # Remove new line symbols
     |> Stream.map(&String.replace(&1, "\n", ""))

     # Chunk lines by the blanks
     |> Stream.chunk_by(&(&1 == ""))

     # Remove the empty lines
     |> Stream.filter(&(&1 != [""]))

     # Take each list of strings and convert it to a list of integers
     |> Stream.map(fn calories -> Enum.map(calories, &String.to_integer/1) end)

     # Map the sum for each list
     |> Stream.map(&Enum.sum(&1))

  end

  def run_part_one do

    # Get max calories from main run function
    max_calories = run()

    # Find the max and return
    |> Enum.max()

    IO.puts("The largest number of calories for one elf is #{max_calories} calories.")

  end

  def run_part_two do

    # Get max calories from main run function
    top_3_calories_sum = run()

    # Convert to list
    |> Enum.to_list()

    # Sort the list from smallest to largest
    |> Enum.sort()

    # Get the last three elements
    |> Enum.take(-3)

    # Sum them together
    |> Enum.sum()

    IO.puts("The sum of the top 3 elves' calories is equal to #{top_3_calories_sum} calories.")

  end
end

CalorieCounting.run_part_one()
CalorieCounting.run_part_two()
