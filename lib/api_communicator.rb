require 'rest-client'
require 'json'
require 'pry'

def gets_character
  puts "Enter Character Name:"
  character_name = gets.chomp
end


def get_character_movies_from_api(character_name)
  collect_films(character_name)
end


def web_request(character_name)
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  response_hash["results"]
end


def collect_films (character_name)
  all_results = web_request(character_name)

  all_results.collect do |character_info|
    if character_info["name"] == character_name
      films_array = character_info["films"] 
      show_films(films_array)
    
    end
  end
end


def show_films(films_array)
  films_array.collect do |index|
    json_films = RestClient.get(index)
    parsed_films = JSON.parse(json_films)
    all_films = parsed_films["title"]
    puts all_films
  end
end


def run
  character_name = gets_character
  get_character_movies_from_api(character_name)
end

run


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?


