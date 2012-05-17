class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :remember_me, :password_expired

  # jezeli haslo bedzie krotsze niz 6 znakow, to dodatkowo devise dorzuci swoj alert
  validates :password, :presence => true, :confirmation => true, :length => { :in => 8..32 }
  validates_format_of :password, :with => /(\D*[a-z]){2,}/, :message => "At least two small characters"
  validates_format_of :password, :with => /(\D*[A-Z]){2,}/, :message => "At least two big characters"
  validates_format_of :password, :with => /(\D*\d){2,}/, :message => "At least two digits"
  validates_format_of :password, :with => /(\D*[@\$=!:.#%]){2,}/, :message => "At least two special characters"
  validate :unique_password

  private
    def unique_password
      if true

      else
        errors.add(:password, "You used that password in the past")
      end
    end
end
