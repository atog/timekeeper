require 'test_helper'

class TimeviewerTest < Test::Unit::TestCase
  
  context "Query" do
    setup do
      t = Timekeeper.new
      t.delete_all
      t.store(:name => "koen", :title => "development", :target => "some client or project", :date => Date.new, :time => 4)
      t.store(:name => "koen", :title => "development", :target => "some client or project", :date => "2009/09/01", :time => 4)
    end
    should "retrieve some time spend" do
      tv = Timeviewer.new
      assert_equal 2, tv.all.size      
    end
  end
  
end
