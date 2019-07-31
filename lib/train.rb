class Train
  attr_accessor :color, :type, :current_city
  attr_reader :id

  def initialize(attributes)
    @color = attributes.fetch(:color)
    @type = attributes.fetch(:type)
    @current_city = attributes.fetch(:current_city)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned = DB.exec("SELECT * FROM trains ORDER BY id ASC;")
    trains = []
    returned.each() do |train|
      color = train.fetch("color")
      type = train.fetch("type")
      current_city = train.fetch("current_city")
      id = train.fetch("id").to_i
      trains.push(Train.new({:color => color, :type => type, :current_city => current_city, :id => id}))
    end
    trains
  end

  def self.clear
    DB.exec("DELETE FROM trains *;")
  end

  def self.find(id)
    train = DB.exec("SELECT * FROM trains WHERE id = #{id};").first
    if train
      color = train.fetch("color")
      type = train.fetch("type")
      current_city = train.fetch("current_city")
      id = train.fetch("id").to_i
      Train.new({:color => color, :type => type, :current_city => current_city, :id => id})
    else
      nil
    end
  end

  def save
    result = DB.exec("INSERT INTO trains (color, type, current_city) VALUES ('#{@color}', '#{@type}', '#{@current_city}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(train_to_compare)
    self.id == train_to_compare.id
  end

  def update(attributes)
    (attributes.key? :color) ? @color = attributes.fetch(:color) : @color = nil
    (attributes.key? :type) ? @type = attributes.fetch(:type) : @type = nil
    (attributes.key? :current_city) ? @current_city = attributes.fetch(:current_city) : @current_city = nil
    DB.exec("UPDATE trains SET color = '#{@color}' WHERE id = #{@id};")
    DB.exec("UPDATE trains SET type = '#{@type}' WHERE id = #{@id};")
    DB.exec("UPDATE trains SET current_city = '#{@current_city}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM trains WHERE id = #{@id};")
  end

end
