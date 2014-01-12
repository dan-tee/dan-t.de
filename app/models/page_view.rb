class PageView < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :page, presence: true

  default_scope -> { order('created_at DESC') }
end
