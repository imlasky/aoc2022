defmodule RockPaperScissors do


  def run do
    # Read in data
    File.stream!("data.txt")

    # Remove new line symbols
    |> Stream.map(&String.replace(&1, "\n", ""))

    # Split their move and my move
    |> Stream.map(&String.split/1)

  end



  def calculate_game_score_one(element) do

    case element do
      ["A", "X"] -> 4 # Rock = 1, Tie = 3, Total = 4
      ["A", "Y"] -> 8 # Paper = 2, Win = 6, Total = 8
      ["A", "Z"] -> 3 # Scissors = 3, Loss = 0, Total = 3
      ["B", "X"] -> 1 # Rock = 1, Loss = 0, Total = 1
      ["B", "Y"] -> 5 # Paper = 2, Tie = 3, Total = 5
      ["B", "Z"] -> 9 # Scissors = 3, Win = 6, Total = 9
      ["C", "X"] -> 7 # Rock = 1, Win = 6, Total = 7
      ["C", "Y"] -> 2 # Paper = 2, Loss = 0, Total = 2
      ["C", "Z"] -> 6 # Scissors = 3, Tie = 3, Total = 6
    end

  end

  def run_part_one do
    game_score = run()
    |> Enum.map(&calculate_game_score_one(&1))
    |> Enum.sum()

    IO.puts(game_score)
  end

  def calculate_game_score_two(element) do

    case element do
      ["A", "X"] -> 3 # Lose = 0, Choose scissors = 3, Total = 3
      ["A", "Y"] -> 4 # Tie = 3, Choose rock = 1, Total = 4
      ["A", "Z"] -> 8 # Win = 6, Choose paper = 2, Total = 8
      ["B", "X"] -> 1 # Lose = 0, Choose rock = 1, Total = 1
      ["B", "Y"] -> 5 # Tie = 3, Choose paper = 2, Total = 5
      ["B", "Z"] -> 9 # Win = 6, Choose scissors = 3, Total = 9
      ["C", "X"] -> 2 # Lose = 0, Choose paper = 2, Total = 2
      ["C", "Y"] -> 6 # Tie = 3, Choose scissors = 3, Total = 6
      ["C", "Z"] -> 7 # Win = 6, Choose rock = 1, Total = 7
    end

  end

  def run_part_two do
    game_score = run()
    |> Enum.map(&calculate_game_score_two(&1))
    |> Enum.sum()

    IO.puts(game_score)
  end


end

RockPaperScissors.run_part_one()
RockPaperScissors.run_part_two()
