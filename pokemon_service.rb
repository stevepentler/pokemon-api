require 'net/http'
require 'json'

class PokemonService

  def get(url: url = "http://pokeapi.co/api/v1/", path: path)
    uri = URI(url + path + "/")
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body) #turns JSON into a ruby hash, must require JSON
  end

  def pokemon_information(info)
    path = "pokemon/#{info}"
    get(path: path)
  end

  def get_moves_for(pokemon)
    response = pokemon_information(pokemon)
    response["moves"].map { |move| move["name"] }
  end

  def next_evolution(id) #broken, not sure how to handle nils in JSON
    response = pokemon_information(id)
    response["evolutions"].first["to"]
  end

  def evolutions(id)
    @next = next_evolution(id)
    unless next_evolution(@next).nil?
      @next = next_evolution(@next)
      p @next
    end
  end 

  def types(id)
    response = pokemon_information(id)
    response["types"].map {|type| type["name"]}.join(", ")
  end 

  def pokemon_for_type(type) #very slow because of include, but can have multiple types for single pokemon
    1.upto(718) do |i|
      p pokemon_information(i)["name"] if types(i).include?(type)
    end
  end 

end



#require './pokemon_service'
# p = PokemonService.new
# p.get(path: "pokemon/25")