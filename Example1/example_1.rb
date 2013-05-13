
# Base class for world items

class Thing
  attr_accessor(:name, :description)

  def initialize(a_name, a_description)
    @name = a_name
    @description = a_description
  end
end

# Defining the actor

class Actor < Thing
  attr_accessor(:position)

  def initialize(a_name, a_description, a_position)
    super(a_name, a_description)
    @position = a_position
  end
end

# Defining treasure

class Treasure < Thing

  def initialize(a_name, a_description, a_value)
    super(a_name, a_description)
    @value = a_value
  end
end

# Defining a room

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

# Defining the game world

class Game
  attr_accessor(:map)

  def initialize(some_rooms, player)
    @map = Map.new(some_rooms)
  end
end

# Initializing the game world with data

class Implementer
  attr_accessor(:game)

  def initialize(a_player)

    # The rooms: ("Name", "Description", north, east, south, west)
    # While "-1" = "no exit" all other no. represent the destination's room no.

    @room_0 = Room.new("Treasure Room", "a fabulous golden chamber", -1, 2, -1, 1)
    @room_1 = Room.new("Dragon's Lair", "a huge and glittering Lair", -1, -1, 0, -1)
    @room_2 = Room.new("Troll Cave", "a dank and gloomy cave", 0, -1, -1, 3)
    @room_3 = Room.new("Crystal Dome", "a vast dome of glass", -1, -1, 2, -1)

    @player = a_player

    @game = Game.new([@room_0, @room_1, @room_2, @room_3], @player)
  end

  # Move the player around the game world

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

# Create test player and game world

the_player = Actor.new("John", "He is tall and a warrior.", 0)
imp = Implementer.new(the_player)

# Test the player's movement

puts(imp.move_actor_to(the_player, :east))
puts(imp.move_actor_to(the_player, :west))
puts(imp.move_actor_to(the_player, :north))
puts(imp.move_actor_to(the_player, :south))
puts(imp.move_actor_to(the_player, :east))
puts(imp.move_actor_to(the_player, :south))
  
