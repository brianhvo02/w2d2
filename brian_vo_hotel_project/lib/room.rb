class Room
    attr_reader :capacity, :occupants

    def initialize(cap)
        @capacity = cap
        @occupants = []
    end

    def full?
        @occupants.length == @capacity
    end

    def available_space
        @capacity - @occupants.length
    end

    def add_occupant(name)
        full = full?
        @occupants << name if !full
        !full
    end
end