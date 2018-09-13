class User < ApplicationRecord
  validates :username, :password_digest, presence: true, uniqueness: true
  validates :session_token, presence: true, uniqueness: true
  #password? validates? or validate 
  validates :password, length: {minimum: 7, allow_nil: true}
  after_initialize :ensure_session_token
  
  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end 
  
  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    #save will put in the database
    self.save!
    self.session_token
  end 
  
  attr_reader :password
  
  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end 
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end 
  
  def self.find_by_credentials(user_name, password)
    user = User.where(username: user_name)
    if user && user.is_password?(password)
      user 
    else 
      nil #? what should be returned if we don't find the user  
    end 
  end
end