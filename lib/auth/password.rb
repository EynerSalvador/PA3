require 'bcrypt'

module Password
  def self.hash(password)
    BCrypt::Password.create(password)
  end

  def self.valid?(hash, password)
    BCrypt::Password.new(hash) == password
  end
end 
