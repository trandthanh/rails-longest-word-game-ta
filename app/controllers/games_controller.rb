require "open-uri"

class GamesController < ApplicationController
    LETTERS = ('a'..'z').to_a

  def new
    @letters = LETTERS.sample(10)
  end

  def score
    @letters = params[:letters].split
    @word = params[:word]
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end


  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

end
