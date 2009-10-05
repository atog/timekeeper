require 'test_helper'

class ViewerTest < Test::Unit::TestCase
  
  context "Query" do
    setup do
      t = Keeper.new
      t.delete_all
      t.store(:title => "development1", :target => "some client or project", :date => Date.today, :time => 4)
      t.store(:title => "development", :target => "some client or project", :date => "2009/09/01", :time => 4)
      t.track(2, "koen")
    end
    should "retrieve some time spend" do
      tv = Viewer.new
      result = tv.all
      assert_equal 2, result.size
      assert result[1].tracked
      
      result = tv.select{|q|
        q.add "title", :eq, "development1"
        q.add "time", :gt, 3
      }
      assert_equal 1, result.size      
    end
  end
  
  context "Query this month" do
    setup do
      t = Keeper.new
      t.delete_all
      t.store(:title => "development", :target => "some client or project", :date => "2009/10/02", :time => 4)
      t.store(:title => "development", :target => "some client or project", :date => "2009/09/01", :time => 4)
    end
    should "retrieve some time spend" do
      tv = Viewer.new
      result = tv.by_month
      assert_equal 1, result.size
      assert_equal "2009-10-02", result[0].date.to_s
      result = tv.by_month(9)
      assert_equal 1, result.size
      assert_equal "2009-09-01", result[0].date.to_s      
    end
  end

  context "Query by name" do
    setup do
      t = Keeper.new
      t.delete_all
      t.store(:title => "development", :target => "some client or project", :date => "2009/10/02", :time => 4)
      t.store(:title => "development", :target => "some client or project", :date => "2009/09/01", :time => 4)
    end
    should "retrieve some time spend" do
      tv = Viewer.new
      result = tv.by_name(nil)
      assert_equal 0, result.size
      result = tv.by_name("jos")
      assert_equal 0, result.size
      result = tv.by_name("koen")
      assert_equal 2, result.size      
    end
  end
  
end
