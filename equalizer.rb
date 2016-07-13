require 'dry-equalizer'

class GeoLocation
  include Dry::Equalizer(:latitude, :longitude)

  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude, @longitude = latitude, longitude
  end
end

point_a = GeoLocation.new(1, 2)
point_b = GeoLocation.new(1, 2)
point_c = GeoLocation.new(2, 2)

point_a.inspect    # => "#<GeoLocation latitude=1 longitude=2>"

point_a == point_b           # => true
point_a.hash == point_b.hash # => true
point_a.eql?(point_b)        # => true
point_a.equal?(point_b)      # => false

point_a == point_c           # => false
point_a.hash == point_c.hash # => false
point_a.eql?(point_c)        # => false
point_a.equal?(point_c)      # => false



class GeoLocation2
  include Dry::Equalizer(:latitude, :longitude)

  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude, @longitude = latitude, longitude
  end
end

point_a_2 = GeoLocation2.new(1, 2)

puts point_a == point_a_2
puts point_a.hash == point_a_2.hash
puts point_a.eql?(point_a_2)
puts point_a.equal?(point_a_2)

