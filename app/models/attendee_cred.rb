class AttendeeCred < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,
  :authentication_keys => [:email]


  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  [:email, :password].each do |field|
    validates field, :presence => true
  end

  has_one :attendee

  def self.successful_response?(xml)
    xml_doc = Nokogiri::Slop(xml)
    xml_doc.remove_namespaces!
    xml_doc.ResultsOfListOfRegistration.Success.content == "true"
  end

  def self.authenticate_user(email, password, eventId)
    url = URI.parse "https://www.regonline.com/webservices/default.asmx/LoginRegistrant"
    req = Net::HTTP::Post.new(url.path)
    req.set_form_data({'email' => email,
                        'password' => password,
                        'eventID' => eventId})
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    resp = https.start { |cx| cx.request(req) }
    successful_response? resp.body
  end
end
