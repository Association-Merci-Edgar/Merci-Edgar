def update_room(room, capacity)
  room.modular_space = capacity.modular

  if capacity.kind == 'seating'
    room.seating = capacity.nb
  elsif capacity.kind == 'standing'
    room.standing = capacity.nb
  elsif capacity.kind == 'mixed'
    if capacity.nb > 500
      room.seating = capacity.nb
    else
      room.standing = capacity.nb
    end
  end
end

class AddCapacitiesInfoToRoom < ActiveRecord::Migration

  class Venue < ActiveRecord::Base
    has_many :rooms
  end

  class Room < ActiveRecord::Base
    has_many :capacities
    belongs_to :venue
  end

  class Capacity < ActiveRecord::Base
    belongs_to :room
  end

  def up
    add_column :rooms, :seating, :int, default: 0
    add_column :rooms, :standing, :int, default: 0
    add_column :rooms, :modular_space, :boolean, default: false

    rooms_to_create = []

    Room.all.each do |room|
      qte = room.capacities.count
      next if qte == 0
      if qte == 1
        update_room(room, room.capacities.first)
        room.save!
        room.venue.save!
        puts "update room #{room.id}"
      else
        first_capacity = room.capacities.first
        second_capacity = room.capacities.second

        if qte == 2 &&
            first_capacity.kind != second_capacity.kind &&
            ['seating', 'standing'].include?(first_capacity.kind) &&
            ['seating', 'standing'].include?(second_capacity.kind)
          room.modular_space = first_capacity.modular || second_capacity.modular
          room.send("#{first_capacity.kind}=", first_capacity.nb)
          room.send("#{second_capacity.kind}=", second_capacity.nb)
          room.save!
          room.venue.save!
          puts "update room #{room.id}"
        else
          update_room(room, first_capacity)
          room.save!
          room.venue.save!
          puts "update room #{room.id}"

          capacities = room.capacities[1..-1]
          capacities.each_with_index do |capacity, index|
            new_room = Room.new
            new_room.name = "#{room.name}-#{index + 1}"
            new_room.depth = room.depth
            new_room.width = room.width
            new_room.height = room.height
            new_room.bar = room.bar
            new_room.venue_id = room.venue_id
            update_room(new_room, capacity)
            rooms_to_create << new_room
          end
        end
      end
    end

    rooms_to_create.each do |room|
      room.save!
      room.venue.save!
      puts "create new room #{room.id}"
    end
  end

  def down
    remove_column :rooms, :seating, :int, default: 0
    remove_column :rooms, :standing, :int, default: 0
    remove_column :rooms, :modular_space, :boolean, default: false
  end

end
