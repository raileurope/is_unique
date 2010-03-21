module IsUnique
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def is_unique
      self.class_eval do
        include InstanceMethods

        before_save :calculate_unique_hash
      end
    end
  end

  module InstanceMethods
    private

      def create
        if existing = self.class.find_by_unique_hash(unique_hash)
          self.id = existing.id
          @new_record = false
          reload
          id
        else
          super
        end
      end

      def calculate_unique_hash
        self.unique_hash = unique_attributes.hash
      end

      def unique_attributes
        attributes.except(
          self.class.primary_key,
          'unique_hash',
          'created_at', 'updated_at'
        )
      end
  end
end

ActiveRecord::Base.class_eval do
  include IsUnique
end
