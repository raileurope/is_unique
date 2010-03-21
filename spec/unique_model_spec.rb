require 'spec_helper'

describe "A unique model" do
  before(:each) do
    @it = Location.create(
      :name  => 'London',
      :lat   => '51.5084152563931',
      :lng   => '-0.125532746315002',
      :alias => 'Londinium'
    )
  end

  it "should not create a new record with the same attributes" do
    new_record = @it.clone
    lambda { new_record.save! }.
      should_not change(Location, :count)
  end
end
