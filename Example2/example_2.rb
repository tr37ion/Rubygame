class Thing
  attr_accessor(:name, :description)

  def initialize(a_name, a_description)
    @name = a_name
    @description = a_description
  end
end

class ThingHolder < Thing
  attr_accessor(:things)

  def initialize(a_name, a_description, some_things)
    super(a_name, a_description)
    @things = some_things
  end

  #:arg: a_thing => Thing
  def add_thing(a_thing)
    @things << a_thing
  end

  #:arg: some_things => Array
  def add_things(some_things)
    @things.concat(some_things)
  end

  def ob_in_things(a_name)
    ob = nil
    @things.each { |t|
      if t.name == a_name
        ob = t
        break
      end
    }
    ob
  end

  #:arg: a_thing => Thing
  #:arg: some_things => Array
  def take_thing_from(a_thing, some_things)
    add_thing(some_things.delete(a_thing))
  end

end

class Treasure < ThingHolder
  attr_accessor(:value)

  def initialize(a_name, a_description, some_things, a_value)
    super(a_name, a_description, some_things)
    @value = a_value
  end
end

class Room < ThingHolder
  attr_accessor(:north, :south, :west, :east)

  def initialize(a_name, a_description, some_things, dir_n, dir_s, dir_w, dir_e)
    super(a_name, a_description, some_things)
    @north = dir_n
    @south = dir_s
    @west = dir_w
    @east = dir_e
  end

end

class Actor < ThingHolder
  attr_accessor(:position)

  def initialize(a_name, a_description, some_things, a_position)
    super(a_name, a_description, some_things)
    @position = a_position
  end

end

class Map < ThingHolder
  alias :rooms :things
  undef_method(:things)
end

class Game
  attr_accessor(:map)

  def initialize(some_rooms)
    @map = Map.new("The Map", "The locations", some_rooms) # << ERROR: two many arguments - 1 expected?
  end
end

class Implementer
  attr_accessor(:game)
  attr_accessor(:player)

  def initialize(some_rooms)
    @player = Actor.new("The Player", "You", some_rooms, 0)
    @game = Game.new(some_rooms)
  end

  def move_actor_to(an_actor, a_direction)
    reply = 'No Exit!'
    exit = @game.map.rooms[an_actor.position].send(a_direction)
    if exit > -1
      an_actor.position = exit
      reply = "You have entered the #{@game.map.rooms[exit].name} which is #{@game.map.rooms[exit].description}."
    end
    reply
  end

  def move_to(a_direction)
    move_actor_to(@player, a_direction)
  end

end

def init_game_data
  some_things = [Treasure.new("sword", "a lovely golden sword", [], 50),
                 Treasure.new("ring", "a ring of great power", [], 100),
                 Treasure.new("wombat", "small, furry, gently snoring creature", [], 3)]

  some_rooms = [Room.new("Treasure Room", "a fabulous golden chamber", some_things, -1, 2, -1, 1),
                Room.new("Dragon's Lair", "a huge and glittering lair", [], -1, -1, 0, -1),
                Room.new("Troll Cave", "a dank and gloomy cave", [], 0, -1, -1, 3),
                Room.new("Crystal Dome", "a vast dome of glass", [], -1, -1, 2, -1)]

  @imp = Implementer.new(some_rooms)
end

init_game_data

puts(@imp.move_to(:east))
puts(@imp.move_to(:west))
puts(@imp.move_to(:north))
puts(@imp.move_to(:south))
puts(@imp.move_to(:east))
puts(@imp.move_to(:south))

