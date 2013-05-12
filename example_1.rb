# That's my first small example code.

class Thing
  attr_accessor(:name, :description)

  # @param [String] a_name
  # @param [Object] a_description
  def initialize(a_name, a_description)
    @name = a_name
    @description = a_description
  end
end

class Actor < Thing
  attr_accessor(:position)

  def initialize(a_name, a_description, a_position)
    super(a_name, a_description)
    @position = a_position
  end
end

class Treasure < Thing

  def initialize(a_name, a_description, a_value)
    super(a_name, a_description)
    @value = a_value
  end
end

class Room < Thing
  attr_accessor(:north, :east, :south, :west)

  def initialize(a_name, a_description, dir_n, dir_e, dir_s, dir_w)
    super(a_name, a_description)
    @north = dir_n
    @east = dir_e
    @south = dir_s
    @west = dir_w
  end
end

# Defining the map 

class Map
  attr_reader(:rooms)

  def initialize(some_rooms)
    @rooms = some_rooms
  end
end

class Game
  attr_accessor(:map)

  def initialize(some_rooms, player)
    @map = Map.new(some_rooms)
  end
end

class Implementer
  attr_accessor(:game)

  def initialize(a_player)

    @room_0 = Room.new("Treasure Room", "a fabulous golden chamber", -1, 2, -1, 1)
    @room_1 = Room.new("Dragon's Lair", "a huge and glittering Lair", -1, -1, 0, -1)
    @room_2 = Room.new("Troll Cave", "a dank and gloomy cave", 0, -1, -1, 3)
    @room_3 = Room.new("Crystal Dome", "a vast dome of glass", -1, -1, 2, -1)

    @player = a_player

    @game = Game.new([@room_0, @room_1, @room_2, @room_3], @player)
  end

  def move_actor_to(an_actor, a_direction)
    reply = 'No Exit!'

    exit = @game.map.rooms[an_actor.position].method(a_direction).call
    if exit > -1
      an_actor.position = exit
      reply = "You have entered the #{@game.map.rooms[exit].name} which is #{@game.map.rooms[exit].description}."
    end
    reply
  end
end

the_player = Actor.new("John", "He is tall and a warrior.", 0)
imp = Implementer.new(the_player)

puts(imp.move_actor_to(the_player, :east))
puts(imp.move_actor_to(the_player, :west))
puts(imp.move_actor_to(the_player, :north))
puts(imp.move_actor_to(the_player, :south))
puts(imp.move_actor_to(the_player, :east))
puts(imp.move_actor_to(the_player, :south))
  
