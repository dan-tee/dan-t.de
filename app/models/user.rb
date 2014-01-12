class User < ActiveRecord::Base
  has_many :page_views

  validates :id_token, presence: true

end
