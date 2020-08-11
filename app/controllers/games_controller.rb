require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
      @letters = []
      10.times do
        @letters << ("a".."z").to_a.sample
      end
      @letters
  end

  def english_word
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    word_dictionary = open(url).read
    word = JSON.parse(word_dictionary)
    return word['found']
  end

  def score
    @score = 0
    @submitted_word = params[:word].to_s.downcase.chars
    @grid = params[:letters].downcase.split(' ')
    if @submitted_word.all? { |letter| @submitted_word.count(letter) <= @grid.count(letter) }
      if english_word
        @results = 'congrats'
      else
        @results = 'sorry not english'
      end
    else
      @results = 'sorry not in the grid idiot!'
    end
  end
end


 # @submitted_word.each do |letter|
 #      if (@grid.include? letter) == false
 #        @result = "Sorry '#{letter}' cannot be made out of the '#{params[:letters]}' grid we provided idiot!"
 #      else
 #        @score += 1
 #        index = @grid.find_index(letter)
 #        @grid.delete_at(index)
 #      end
 #    end
