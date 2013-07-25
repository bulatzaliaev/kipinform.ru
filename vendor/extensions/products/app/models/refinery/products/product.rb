module Refinery
  module Products
    class Product < Refinery::Core::BaseModel
      self.table_name = 'refinery_products'

      attr_accessible :title, :features, :description, :photo_id, :category_id, :docs_id, :position,
                      :manufacturer, :usage, :gosreestr_number, :si_identity, :m_interval, :complectation

      acts_as_indexed :fields => [:title, :features, :description]

      validates :title, :presence => true, :uniqueness => true

      belongs_to :photo, :class_name => '::Refinery::Image'

      belongs_to :docs, :class_name => '::Refinery::Resource'

      belongs_to :category, :class_name => 'Category', :foreign_key => "category_id"

      has_many :image_pages, :as => :item, :order => 'position ASC'
      has_many :images, :through => :image_pages, :order => 'position ASC'
      has_many_page_images

      protected
      def self.random
        if (c = count) != 0
        find(:first, :offset =>rand(c))
        end
      end
    end
  end
end
