Refinery::Products::Product.class_eval do
  has_many :image_pages, :as => :item, :order => 'position ASC'
  has_many :images, :through => :image_pages, :order => 'position ASC'
  has_many_page_images

  def self.search(search)
        if search
          find(:all, :conditions => ['lower(title) LIKE ?', "%#{search.downcase}%"])
        else
          find(:all)
        end
      end
end