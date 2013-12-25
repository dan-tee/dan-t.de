class Admin < ActiveRecord::Base
  validates :admin_token, presence: true
  validates :ip, presence: true

  after_initialize :new_admin_token

  def new_admin_token
    self.admin_token = SecureRandom.urlsafe_base64
  end
end
