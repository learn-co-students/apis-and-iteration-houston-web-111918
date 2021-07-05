require 'rest-client'
require 'json'
require 'pry'
require 'pp'

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  
  results_arr = response_hash['results'].find do |character_info|
    character_info['name'].downcase == character_name.downcase
  end
  
  final_arr = []
  
  results_arr['films'].each do |url|
    final_arr << JSON.parse(RestClient.get(url))
  end
  final_arr
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films.each do |film_info|
    puts film_info['title']
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
