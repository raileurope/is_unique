require 'spec_helper'

class Location < ActiveRecord::Base
  # String name 
  # Float lat
  # Float lng
  # String alias
  # Integer unique_hash

  is_unique :ignore => :alias
end

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

  it "should not create a new record with a different ignored attribute" do
    new_record = @it.clone
    new_record.alias = 'Greater London'
    lambda { new_record.save! }.
      should_not change(Location, :count)
  end

  it "should return the existing record on creation" do
    new_record = @it.clone
    new_record.save!
    new_record.should == @it
  end

  it "should allow to create a record with different attributes" do
    new_record = @it.clone
    new_record.name = 'Greater London'
    lambda { new_record.save! }.
      should change(Location, :count).by(1)
    new_record.should_not == @it
  end

  it "should handle updates properly" do
    new_record = @it.clone
    @it.update_attribute(:name, 'Greater London')
    lambda { new_record.save! }.
      should change(Location, :count).by(1)
    new_record.should_not == @it
  end
end
