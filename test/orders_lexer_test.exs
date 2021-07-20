defmodule OrdersLexerTest do
  use ExUnit.Case

  test "lexes longform army" do
    assert :orders_lexer.string('A') == {:ok,
      [
        {:army, 1},
      ], 1}
  end

  test "hold" do
    assert :orders_lexer.string('H') == {:ok,
      [
        {:hold, 1},
      ], 1}
  end

  test "lexes hold longform" do
    assert :orders_lexer.string('Hold') == {:ok,
      [
        {:hold, 1},
      ], 1}
  end

  test "lexes hold longform ignores case" do
    assert :orders_lexer.string('hOlD') == {:ok,
      [
        {:hold, 1},
      ], 1}
  end

  test "lexes invade" do
    assert :orders_lexer.string('-') == {:ok,
      [
        {:-, 1},
      ], 1}
  end

  test "lexes invade from endash" do
    assert :orders_lexer.string('\xe2\x80\x94') == {:ok,
      [
        {:-, 1},
      ], 1}
  end

  test "lexes invade from emdash" do
    assert :orders_lexer.string('\xe2\x80\x95') == {:ok,
      [
        {:-, 1},
      ], 1}
  end

  test "lexes support" do
    assert :orders_lexer.string('S') == {:ok,
      [
        {:support, 1},
      ], 1}
  end

  test "lexes support longform" do
    assert :orders_lexer.string('Support') == {:ok,
      [
        {:support, 1},
      ], 1}
  end

  test "lexes support longform ignores case" do
    assert :orders_lexer.string('suPPoRt') == {:ok,
      [
        {:support, 1},
      ], 1}
  end

  test "lexes convoy" do
    assert :orders_lexer.string('C') == {:ok,
      [
        {:convoy, 1},
      ], 1}
  end

  test "lexes convoy longform" do
    assert :orders_lexer.string('Convoy') == {:ok,
      [
        {:convoy, 1},
      ], 1}
  end

  test "lexes convoy longform ignores case" do
    assert :orders_lexer.string('cOnvOy') == {:ok,
      [
        {:convoy, 1},
      ], 1}
  end

  test "lexes territory shortform" do
    assert :orders_lexer.string('Gas') == {:ok,
      [
        {:territory, 1, 'Gas'},
      ], 1}
  end

  test "lexes territory with coast short form" do
    assert :orders_lexer.string('Spa/nc') == {:ok,
      [
        {:territory, 1, 'Spa/nc'},
      ], 1}
  end
end
