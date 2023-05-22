require "open-uri"
class GamesController < ApplicationController

  def new
    @letters = ('a'..'z').to_a.shuffle.sample(9)
  end

  def score
    @word = params[:word].downcase.split("")
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    @response = JSON.parse(URI.open(url).read)
    @letters = params[:letters].downcase.split("")
      if (@word & @letters) != @word
        @message = "Sorry, but #{params[:word]} can’t be built out of #{@letters.join(“, “).upcase}."
      elsif (@word & @letters) == @word && @response[“found”] == true
        @message = "The word #{params[:word]} is valid according to the grid and is an English word."
      else
        @message = "The word #{params[:word]} is valid according to the grid, but is not a valid English word."
      end
  end
end
