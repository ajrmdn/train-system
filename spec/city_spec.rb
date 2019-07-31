require('spec_helper')

describe '#City' do

  describe('.save') do
    it("creates and saves a new city to the database") do
      city = City.new({:name => "portland", :capacity => 3, :id => nil})
      city.save
      expect(City.all).to(eq([city]))
    end
  end

  describe('.all') do
    it("lists all cities in the database") do
      city1 = City.new({:name => "portland", :capacity => 3, :id => nil})
      city1.save
      city2 = City.new({:name => "seattle", :capacity => 6, :id => nil})
      city2.save
      expect(City.all).to(eq([city1, city2]))
    end
  end

  describe('.update') do
    it("updates information on a pre-existing city") do
      city = City.new({:name => "portland", :capacity => 3, :id => nil})
      city.save
      city.update({:name => "beantown"})
      expect(city.name).to(eq("beantown"))
    end
  end

  describe('.delete') do
    it("deletes pre-existing city from database") do
      city = City.new({:name => "portland", :capacity => 3, :id => nil})
      city.save
      city.delete
      expect(City.all).to(eq([]))
    end
  end

end
