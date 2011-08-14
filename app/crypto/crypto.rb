require 'openssl'

class Crypto
  
  def self.encrypt (key, text)
    key_hash = Digest::SHA256.digest(key)
    aes = OpenSSL::Cipher::Cipher.new('aes-256-ecb')
    aes.encrypt
    aes.key = key_hash
    aes.update(text) << aes.final
  end

  def self.decrypt (key, cipher_text)
    key_hash = Digest::SHA256.digest(key)
    aes = OpenSSL::Cipher::Cipher.new('aes-256-ecb')
    aes.decrypt
    aes.key = key_hash
    aes.update(cipher_text) << aes.final
  end

end
