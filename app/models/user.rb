class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  attr_accessible :email, :remember_me, :password_expired, :password, :password_confirmation
  has_many :passwords

  before_create :store_password

  # jezeli haslo bedzie krotsze niz 6 znakow, to dodatkowo devise dorzuci swoj alert
  validates :password, :presence => true, :length => { :in => 8..32 }
  validates_format_of :password, :with => /(\S*[a-z]){2,}/, :message => "At least two small characters"
  validates_format_of :password, :with => /(\S*[A-Z]){2,}/, :message => "At least two big characters"
  validates_format_of :password, :with => /(\S*\d){2,}/, :message => "At least two digits"
  validates_format_of :password, :with => /(\S*[@\$!#%]){2,}/, :message => "At least two special characters"
  validate :unique_password

  def password_expired?
    #self.password_updated_at + PASSWD_EXPIRATION.days <= DateTime.now 
    self.password_updated_at + 2.minutes <= DateTime.now
  end

  protected
    def unique_password
      if password_used?
        errors.add(:password, "You used that password in the past")
      end
    end

    def password_used?
      #puts self.password + "\n\n\n"
      true if passwords.order("`created_at` DESC").limit(3).any? { |p| p.value == self.password }
    end

    def store_password
      self.password_updated_at = DateTime.now
      password = Password.new(:value => self.password)
      self.passwords << password
    end

end
