class Password < ActiveRecord::Base
  belongs_to :user

  def self.store_password(user)
    p = Password.new
    p.user = user
    p.value = user.password
    p.created_at = user.password_updated_at
    p.save
  end
end
