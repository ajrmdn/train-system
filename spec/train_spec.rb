require('spec_helper')

describe '#Train' do

  describe('.save') do
    it("creates and saves a new train to the database") do
      train = Train.new({:color => "red", :type => "freight", :current_city => "Portland", :id => 1})
      train.save
      expect(Train.all).to(eq([train]))
    end
  end

  describe('.all') do
    it("lists all trains in the database") do
      train1 = Train.new({:color => "red", :type => "freight", :current_city => "Portland", :id => 1})
      train1.save
      train2 = Train.new({:color => "blue", :type => "passanger", :current_city => "Seattle", :id => 2})
      train2.save
      expect(Train.all).to(eq([train1, train2]))
    end
  end

  describe('.update') do
    it("updates information on a pre-existing train") do
      train = Train.new({:color => "red", :type => "freight", :current_city => "Portland", :id => nil})
      train.save
      train.update({:color => "blue"})
      expect(train.color).to(eq("blue"))
    end
  end

  describe('.delete') do
    it("deletes pre-existing train from database") do
      train = Train.new({:color => "red", :type => "freight", :current_city => "Portland", :id => 1})
      train.save
      train.delete
      expect(Train.all).to(eq([]))
    end
  end

end
