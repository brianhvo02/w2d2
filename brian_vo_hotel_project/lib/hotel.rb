require_relative "room"

class Hotel
    attr_reader :rooms

    def initialize(name, rooms)
        @name = name
        @rooms = rooms.transform_values { |v| Room.new(v) }
    end

    def name
        @name.split(" ").map(&:capitalize).join(" ")
    end

    def room_exists?(name)
        @rooms.has_key?(name)
    end

    def check_in(person, room)
        puts room_exists?(room) ? (rooms[room].add_occupant(person) ? "check in successful" : "sorry, room is full") : "sorry, room does not exist"
    end

    def has_vacancy?
        @rooms.any? { |k, v| !v.full? }
    end

    def list_rooms
        @rooms.each { |k, v| puts k + " " + v.available_space.to_s }
    end
end
