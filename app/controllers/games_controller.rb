require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = [*('A'..'Z')].sample(rand(3..26))
  end

  def score
    if params[:word]
      url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
      dictionary_response = URI.open(url).read
      dictionary = JSON.parse(dictionary_response)

      if check_letters?(params[:word], params[:letters]) == false
        @result = "#{params[:word]} Cannot be built out of #{params[:letters]}"
      elsif dictionary['found'] == false
        @result = 'The word is valid according to the grid, but is not a valid English word'
      else
        @result = "Word Found! Score: #{dictionary['length']}"
      end
    end
  end

  private

  def check_letters?(word, letters)
    word.upcase.chars.each do |char|
      return false if letters.chars.none?(char)
    end
  end
end
