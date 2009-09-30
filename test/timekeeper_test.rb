require 'test_helper'

class TimekeeperTest < Test::Unit::TestCase
  
  should "store some time spend" do
    t = Timekeeper.new
    t.delete_all
    t.store(:name => "koen", :title => "development", :target => "some client or project", :date => Date.new, :time_spend => 4)
    t.store(:name => "koen", :title => "development", :target => "some client or project", :date => "2009/09/01", :time_spend => 4)
    assert_equal 2, t.table.count
  end
  
end
