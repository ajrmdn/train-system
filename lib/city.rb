class City
  attr_accessor :name, :capacity
  attr_reader :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @capacity = attributes.fetch(:capacity)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned = DB.exec("SELECT * FROM cities ORDER BY name;")
    cities = []
    returned.each() do |city|
      name = city.fetch("name")
      capacity = city.fetch("capacity")
      id = city.fetch("id").to_i
      cities.push(City.new({:name => name, :capacity => capacity, :id => id}))
    end
    cities
  end

  def self.clear
    DB.exec("DELETE FROM cities *;")
  end

  def self.find(id)
    city = DB.exec("SELECT * FROM cities WHERE id = #{id};").first
    if city
      name = city.fetch("name")
      capacity = city.fetch("capacity")
      id = city.fetch("id").to_i
      City.new({:name => name, :capacity => capacity, :id => id})
    else
      nil
    end
  end

  def save
    result = DB.exec("INSERT INTO cities (name, capacity) VALUES ('#{@name}', '#{@capacity}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(city_to_compare)
    self.id == city_to_compare.id
  end

  def update(attributes)
    (attributes.key? :name) ? @name = attributes.fetch(:name) : @name
    (attributes.key? :capacity) ? @capacity = attributes.fetch(:capacity).to_i : @capacity
    DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{@id};")
    DB.exec("UPDATE cities SET capacity = #{@capacity} WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM cities WHERE id = #{@id};")
  end

end
