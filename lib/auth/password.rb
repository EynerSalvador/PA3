require 'bcrypt'

module Password
  def self.create(password)
    BCrypt::Password.create(password).to_s
  end

  def self.valid?(hash, password)
    BCrypt::Password.new(hash) == password
  end
