require 'openssl'

module Crypto
  
  def self.encrypt (key)
    key_hash = Digest::SHA256.digest(key)
    aes = OpenSSL::Cipher::Cipher.new('aes-256-ecb')
    aes.encrypt
    aes.key = key_hash
    aes.update(self) << aes.final
  end

  def self.decrypt (key)
    key_hash = Digest::SHA256.digest(key)
    aes = OpenSSL::Cipher::Cipher.new('aes-256-ecb')
    aes.decrypt
    aes.key = key_hash
    aes.update(self) << aes.final
  end

end
