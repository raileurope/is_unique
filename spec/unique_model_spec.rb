require 'spec_helper'

class Location < ActiveRecord::Base
  # String type
  # String name 
  # Float lat
  # Float lng
  # String alias
  # Integer unique_hash

  is_unique :ignore => :alias
end

class PopulatedPlace < Location
  is_unique :ignore => [:name, :alias]
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

  it 'should have a 20 character long unique hash' do
    @it.unique_hash.length.should == 20
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

  it "should allow to create a record with original attributes when an existing record is updated" do
    new_record = @it.clone
    @it.update_attribute(:name, 'Greater London')
    lambda { new_record.save! }.
      should change(Location, :count).by(1)
    new_record.should_not == @it
  end

  context "that is a subclass of another model" do
    before(:each) do
      @it = PopulatedPlace.create(
        :name  => 'London',
        :lat   => '51.5084152563931',
        :lng   => '-0.125532746315002',
        :alias => 'Londinium'
      )
    end

    it "should be able to override columns that should be ignored" do
      new_record = @it.clone
      new_record.name = 'Greater London'
      new_record.alias = 'London, UK'
      lambda { new_record.save! }.
        should_not change(PopulatedPlace, :count)
    end

    it "should run callbacks just once" do
      @it.should_receive(:calculate_unique_hash).once
      @it.save
    end
  end
end
