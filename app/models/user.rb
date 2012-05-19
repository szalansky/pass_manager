class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  attr_accessible :email, :remember_me, :password_expired, :password, :password_confirmation

  before_create :save_password

  # jezeli haslo bedzie krotsze niz 6 znakow, to dodatkowo devise dorzuci swoj alert
  validates :password, :presence => true, :length => { :in => 8..32 }
  validates_format_of :password, :with => /(\S*[a-z]){2,}/, :message => "At least two small characters"
  validates_format_of :password, :with => /(\S*[A-Z]){2,}/, :message => "At least two big characters"
  validates_format_of :password, :with => /(\S*\d){2,}/, :message => "At least two digits"
  validates_format_of :password, :with => /(\S*[@\$!#%]){2,}/, :message => "At least two special characters"
  validate :unique_password

  def password_expired?
    #self.password_updated_at + PASSWD_EXPIRATION.days <= DateTime.now 
    self.password_updated_at + 1.minutes <= DateTime.now
    # ZAKTUALIZUJ FLAGE password_expired ALE TO CHYBA NIE BEDZIE KONIECZNE
  end

  protected
    def unique_password
      #passwords = ["aaBB12!@"]
      if true#passwords.include? password
        #errors.add(:password, "You used that password in the past")
      else
        errors.add(:password, "You used that password in the past")
      end
    end

    def save_password
      self.password_updated_at = DateTime.now
    end

end
