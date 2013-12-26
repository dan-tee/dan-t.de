class PrivateMessage < ActiveRecord::Base

  VALID_EMAIL_REGEX = /\A\s*\z|\A[\w+\-.]+@([a-z\d\-.]+\.)+[a-z]+\z/i

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :message, presence: true, length: { maximum: 10000 }

  default_scope -> { order('created_at DESC') }

  scope :not_archived, -> { where(archived: false) }
end
