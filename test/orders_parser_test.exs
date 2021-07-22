defmodule OrdersParserTest do
  use ExUnit.Case

  test "parses hold" do
    assert :orders_parser.parse([
      {:army, 1},
      {:territory, 1, 'Pic'},
      {:hold, 1},
    ]) == {:ok,
      [{:army, {:hold, {:territory, 'Pic'}}, 1}]}
  end

  test "parses support hold" do
    assert :orders_parser.parse([
      {:army, 1},
      {:territory, 1, 'Pic'},
      {:support, 1},
      {:territory, 1, 'Bre'},
    ]) == {:ok,
      [{:army, {:support, {:territory, 'Pic'}, {:hold, {:territory, 'Bre'}}}, 1}]}
  end

  test "parses support invade" do
    assert :orders_parser.parse([
      {:fleet, 1},
      {:territory, 1, 'ENG'},
      {:support, 1},
      {:territory, 1, 'Pic'},
      {:-, 1},
      {:territory, 1, 'Bre'},
    ]) == {:ok,
      [{:fleet,
        {:support, {:territory, 'ENG'},
          {:invade, {:territory, 'Pic'}, {:territory, 'Bre'}}}, 1}]
      }
  end

  test "parses invade" do
    assert :orders_parser.parse([
      {:army, 1},
      {:territory, 1, 'Pic'},
      {:-, 1},
      {:territory, 1, 'Bre'},
    ]) == {:ok,
      [{:army, {:invade, {:territory, 'Pic'}, {:territory, 'Bre'}}, 1}]
    }
  end

  test "parses convoy" do
    assert :orders_parser.parse([
      {:fleet, 1},
      {:territory, 1, 'ENG'},
      {:convoy, 1},
      {:territory, 1, 'Lon'},
      {:-, 1},
      {:territory, 1, 'Bre'},
    ]) == {:ok,
      [{:fleet, {:convoy, {:territory, 'ENG'}, {:invade, {:territory, 'Lon'}, {:territory, 'Bre'}}}, 1}]
    }
  end

  test "parse multiple orders" do
    assert :orders_parser.parse([
      {:army, 1},
      {:territory, 1, 'Pic'},
      {:hold, 1},
      {:separator, 1},
      {:army, 1},
      {:territory, 1, 'Bre'},
      {:hold, 1},
    ]) == {:ok,
      [
        {:army, {:hold, {:territory, 'Pic'}}, 1},
        {:army, {:hold, {:territory, 'Bre'}}, 1},
      ],
    }
  end

  test "parse multiple orders newline" do
    assert :orders_parser.parse([
      {:army, 1},
      {:territory, 1, 'Pic'},
      {:hold, 1},
      {:separator, 1},
      {:army, 2},
      {:territory, 2, 'Bre'},
      {:hold, 2},
    ]) == {:ok,
      [
        {:army, {:hold, {:territory, 'Pic'}}, 1},
        {:army, {:hold, {:territory, 'Bre'}}, 2},
      ],
    }
  end
end
