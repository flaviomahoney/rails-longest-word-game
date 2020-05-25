require 'open-uri'
require 'json'

class GamesController < ApplicationController
	def new
		@grid = Array.new(10) { ('A'..'Z').to_a.sample }
	  @grid = @grid.join(" ")
	end

	def score
		@attempt = params[:word]
		@grid = params[:my_grid]
		if grid?(@attempt.upcase, @grid)
			if english_word?(@attempt)
				@result = "Congratulations #{@attempt} is a English Word"
			else
				@result = "Sorry but #{@attempt} is not a english word"
			end
		else
			@result = "It's not a grid"
		end
	end
	
	def english_word?(word)
		response = open("https://wagon-dictionary.herokuapp.com/#{word}")
		json = JSON.parse(response.read)
		return json['found']
	end

	def grid?(word, grid)
		word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
	end

end
