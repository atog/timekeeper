require 'test_helper'

class ViewerTest < Test::Unit::TestCase
  
  context "Query" do
    setup do
      t = Keeper.new
      t.delete_all
      t.store(:name => "koen", :title => "development", :target => "some client or project", :date => Date.new, :time => 4)
      t.store(:name => "koen", :title => "development", :target => "some client or project", :date => "2009/09/01", :time => 4)
      t.track(2, "koen")
    end
    should "retrieve some time spend" do
      tv = Viewer.new
      result = tv.all
      assert_equal 2, result.size
      assert result[1].tracked
    end
  end
  
end
