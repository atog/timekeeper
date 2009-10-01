require 'test_helper'

class KeeperTest < Test::Unit::TestCase
  
  should "store some time spend" do
    t = Keeper.new
    t.delete_all
    t.store(:name => "koen", :title => "development", :target => "some client or project", :date => Date.new, :time => 4)
    t.store(:name => "koen", :title => "development", :target => "some client or project", :date => "2009/09/01", :time => 4)
    assert_equal 2, t.count
  end
  
  should "track a record" do
    t = Keeper.new
    t.delete_all
    t.store(:name => "koen", :title => "development", :target => "some client or project", :date => Date.new, :time => 4)
    t.store(:name => "koen", :title => "development", :target => "some client or project", :date => Date.new, :time => 4)
    assert_equal 2, t.count
    t.track(1, "koen")
    t.track(2, "koen")    
  end
  
  should "update an existing element" do
    t = Keeper.new
    t.delete_all
    t.store(:name => "koen", :title => "development", :target => "some client or project", :date => Date.new, :time => 4)
    assert_equal 1, t.count
    t.update(1, {:target => "another title"})
    assert_equal 1, t.count
    assert_equal "another title", t.get(1).target
  end
  
  should "return nil for a non-existing element" do
    t = Keeper.new
    t.delete_all
    assert !t.get(4)
  end
    
  should "raise an exception" do
    t = Keeper.new
    t.delete_all    
    assert_raise StandardError do
      t.store(:name => "koen", :target => "some client or project", :date => Date.new)
    end
  end
  
end
