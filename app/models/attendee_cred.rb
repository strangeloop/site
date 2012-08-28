class AttendeeCred < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
  :rememberable, :trackable, :validatable,
  :authentication_keys => [:email]


  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  [:email, :password].each do |field|
    validates field, :presence => true
  end

  has_one :attendee

  def self.safe_content(xml, path)
    ele = xml.at_xpath(path)
    ele.content if ele
  end

  def self.attendee_from_regonline(xml)
    xml_doc = Nokogiri::XML(xml)
    xml_doc.remove_namespaces!

    if !xml_doc.xpath("//ResultsOfListOfRegistration/Success[text()='true']").empty?
      a = Attendee.new
      reg_info = xml_doc.xpath("//ResultsOfListOfRegistration/Data/APIRegistration")
      a.first_name = safe_content(reg_info, "FirstName")
      a.last_name = safe_content(reg_info, "LastName")
      a.city = safe_content(reg_info, "City")
      a.state = safe_content(reg_info, "State")
      a.email = safe_content(reg_info, "Email")
      a.reg_id = safe_content(reg_info, "ID")
      a
    end
  end

  REGONLINE = URI.parse("https://www.regonline.com/webservices/default.asmx/LoginRegistrant")

  def self.authenticate_user(email, password, eventId)
    req = Net::HTTP::Post.new(REGONLINE.path)
    req.set_form_data({'email' => email,
                        'password' => password,
                        'eventID' => eventId})
    https = Net::HTTP.new(REGONLINE.host, REGONLINE.port)
    https.use_ssl = true
    resp = https.start { |cx| cx.request(req) }
    attendee = attendee_from_regonline(resp.body)
    attendee.register_attendee.attendee_cred if attendee
  end

  def valid_password?(password)
    !encrypted_password.blank? && !password.blank?
  end
end
