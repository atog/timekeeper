require 'test_helper'

class TimekeeperTest < Test::Unit::TestCase
  
  should "store some time spend" do
    t = Timekeeper.new
    t.delete_all
    t.store(:name => "koen", :title => "development", :target => "some client or project", :date => Date.new, :time => 4)
    t.store(:name => "koen", :title => "development", :target => "some client or project", :date => "2009/09/01", :time => 4)
    assert_equal 2, t.table.count
  end
  
  should "update an existing element" do
    t = Timekeeper.new
    t.delete_all
    t.store(:name => "koen", :title => "development", :target => "some client or project", :date => Date.new, :time => 4)
    assert_equal 1, t.table.count
    t.update(1, {:target => "another title"})
    assert_equal 1, t.table.count
    assert_equal "another title", t.get(1).target
  end
  
  should "return nil for a non-existing element" do
    t = Timekeeper.new
    t.delete_all
    assert !t.get(4)
  end
  
  should "track" do
    t = Timekeeper.new
    t.delete_all
    t.store(:name => "koen", :title => "development", :target => "some client or project", :date => Date.new, :time => 4, :track => "yes")
    assert t.get(1).track
  end
  
  should "raise an exception" do
    t = Timekeeper.new
    t.delete_all    
    assert_raise StandardError do
      t.store(:name => "koen", :target => "some client or project", :date => Date.new)
    end
  end
  
end
