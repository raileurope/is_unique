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
  subject do
    Location.create(
      :name  => 'London',
      :lat   => '51.5084152563931',
      :lng   => '-0.125532746315002',
      :alias => 'Londinium'
    )
  end

  it 'should have a 20 characters long unique hash' do
    subject.unique_hash.length.should == 20
  end

  it "should not create a new record with the same attributes" do
    new_record = subject.clone
    expect { new_record.save! }.to_not change(Location, :count)
  end

  it "should not create a new record with a different ignored attribute" do
    new_record = subject.clone
    new_record.alias = 'Greater London'
    expect { new_record.save! }.to_not change(Location, :count)
  end

  it "should return the existing record on creation" do
    new_record = subject.clone
    new_record.save!
    new_record.should == subject
  end

  it "should allow to create a record with different attributes" do
    new_record = subject.clone
    new_record.name = 'Greater London'
    expect { new_record.save! }.to change(Location, :count).by(1)
    new_record.should_not == subject
  end

  it "should allow to create a record with original attributes when an existing record is updated" do
    new_record = subject.clone
    subject.update_attribute(:name, 'Greater London')
    expect { new_record.save! }.to change(Location, :count).by(1)
    new_record.should_not == subject
  end

  context "that is a subclass of another model" do
    subject do
      PopulatedPlace.create(
        :name  => 'London',
        :lat   => '51.5084152563931',
        :lng   => '-0.125532746315002',
        :alias => 'Londinium'
      )
    end

    it "should be able to override columns that should be ignored" do
      new_record = subject.clone
      new_record.name = 'Greater London'
      new_record.alias = 'London, UK'
      expect { new_record.save! }.to_not change(PopulatedPlace, :count)
    end

    it "should run callbacks just once" do
      subject.should_receive(:calculate_unique_hash).once
      subject.save
    end
  end
end
