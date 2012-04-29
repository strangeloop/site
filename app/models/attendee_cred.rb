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

  def self.attendee_from_regonline(xml)
    xml_doc = Nokogiri::Slop(xml)
    xml_doc.remove_namespaces!
    if xml_doc.ResultsOfListOfRegistration.Success.content == "true" 
      a = Attendee.new
      reg_info = xml_doc.ResultsOfListOfRegistration.Data.APIRegistration
      a.first_name = reg_info.FirstName.content
      a.last_name = reg_info.LastName.content
      a.city = reg_info.City.content
      a.state = reg_info.State.content
      a.email = reg_info.Email.content
      a.reg_id = reg_info.ID.content
      a
    else
      nil
    end
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
    attendee = attendee_from_regonline(resp.body)
    attendee = attendee.create_new_attendee(attendee) if attendee
    attendee && attendee.attendee_cred
  end

  def valid_password?(password)
    !encrypted_password.blank? && !password.blank?
  end
end
