require 'spec_helper'

describe AttendeeCred do

  [:password, :email].each do |field|
    it {should validate_presence_of field}
  end

  let(:example_xml){"<?xml version=\"1.0\" encoding=\"utf-8\"?>
<ResultsOfListOfRegistration xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns=\"http://www.regonline.com/api\">
  <Success>true</Success>
  <Data>
    <APIRegistration>
      <ID>24331859</ID>
      <EventID>849922</EventID>
      <GroupID>24331859</GroupID>
      <RegTypeID>354270</RegTypeID>
      <RegistrationType>Attendee</RegistrationType>
      <StatusID>2</StatusID>
      <StatusDescription>Confirmed</StatusDescription>
      <FirstName>Ryan</FirstName>
      <LastName>Senior</LastName>
      <Email>rsenior@revelytix.com</Email>
      <Company>Revelytix</Company>
      <City>St Louis</City>
      <State>MO</State>
      <BalanceDue>0</BalanceDue>
      <Phone>3147865362</Phone>
      <CellPhone>3146145286</CellPhone>
      <DateOfBirth xsi:nil=\"true\" />
      <NationalityID xsi:nil=\"true\" />
      <RoomSharerID>24331859</RoomSharerID>
      <CheckedIn>false</CheckedIn>
      <CancelDate xsi:nil=\"true\" />
      <DirectoryOptOut>false</DirectoryOptOut>
      <IsSubstitute>false</IsSubstitute>
      <AddBy>Attendee</AddBy>
      <AddDate>2010-04-22T15:06:48.65</AddDate>
      <ModBy>System Process</ModBy>
      <ModDate>2011-02-07T21:00:54.807</ModDate>
      <PaymentDocNumber />
      <APIToken>A4ZiFZ5L3w7HqLRlfG1wQG8/Vd6SuWJIlPkSXHnZlNuOmYpuYigAa+6vDrDaoYvKj20hw7QLzbPu
iI6T+Wo5K+WCEfa0rsTF</APIToken>
    </APIRegistration>
  </Data>
</ResultsOfListOfRegistration>"}
  
  let(:bad_xml){"<?xml version=\"1.0\" encoding=\"utf-8\"?>
<ResultsOfListOfRegistration xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns=\"http://www.regonline.com/api\">
  <Success>false</Success>
</ResultsOfListOfRegistration>"}

  it "should return false with a failed auth XML" do
    AttendeeCred.attendee_from_regonline(bad_xml).should be_nil
  end

  it "should populate an attendee with regonline info" do
    a = AttendeeCred.attendee_from_regonline(example_xml)
    a.first_name.should == "Ryan"
    a.last_name.should == "Senior"
    a.reg_id.should == "24331859"
    a.city.should == "St Louis"
    a.state.should == "MO"
    a.email.should == "rsenior@revelytix.com"
  end

  it "should not allow empty passwords" do
    ac = AttendeeCred.new({:email => "foo@bar.com", :password => "a really good password"})
    ac.valid_password?("").should be_false
  end
  
  it "should not allow invalid users" do
    ac = AttendeeCred.new({:email => "foo@bar.com", :password => nil})
    ac.valid_password?("foo").should be_false
  end



  it "should validate real passwords" do
    ac = AttendeeCred.new({:email => "foo@bar.com", :password => "a really good password"})
    ac.valid_password?("foo").should be_true
  end

    let(:example_xml_without_state){"<?xml version=\"1.0\" encoding=\"utf-8\"?>
<ResultsOfListOfRegistration xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns=\"http://www.regonline.com/api\">
  <Success>true</Success>
  <Data>
    <APIRegistration>
      <ID>24331859</ID>
      <EventID>849922</EventID>
      <GroupID>24331859</GroupID>
      <RegTypeID>354270</RegTypeID>
      <RegistrationType>Attendee</RegistrationType>
      <StatusID>2</StatusID>
      <StatusDescription>Confirmed</StatusDescription>
      <FirstName>Ryan</FirstName>
      <LastName>Senior</LastName>
      <Email>rsenior@revelytix.com</Email>
      <Company>Revelytix</Company>
      <City>St Louis</City>
      <BalanceDue>0</BalanceDue>
      <Phone>3147865362</Phone>
      <CellPhone>3146145286</CellPhone>
      <DateOfBirth xsi:nil=\"true\" />
      <NationalityID xsi:nil=\"true\" />
      <RoomSharerID>24331859</RoomSharerID>
      <CheckedIn>false</CheckedIn>
      <CancelDate xsi:nil=\"true\" />
      <DirectoryOptOut>false</DirectoryOptOut>
      <IsSubstitute>false</IsSubstitute>
      <AddBy>Attendee</AddBy>
      <AddDate>2010-04-22T15:06:48.65</AddDate>
      <ModBy>System Process</ModBy>
      <ModDate>2011-02-07T21:00:54.807</ModDate>
      <PaymentDocNumber />
      <APIToken>A4ZiFZ5L3w7HqLRlfG1wQG8/Vd6SuWJIlPkSXHnZlNuOmYpuYigAa+6vDrDaoYvKj20hw7QLzbPu
iI6T+Wo5K+WCEfa0rsTF</APIToken>
    </APIRegistration>
  </Data>
</ResultsOfListOfRegistration>"}

  it "should allow users without states" do
    a = AttendeeCred.attendee_from_regonline(example_xml_without_state)
    a.first_name.should == "Ryan"
    a.last_name.should == "Senior"
    a.reg_id.should == "24331859"
    a.city.should == "St Louis"
    a.state.should be_nil
    a.email.should == "rsenior@revelytix.com"
  end

  it "should return content when available" do
    AttendeeCred.safe_content(Nokogiri::XML("<a><b>some text</b></a>"), "//a/b").should == "some text"
    AttendeeCred.safe_content(Nokogiri::XML("<a><b>some text</b></a>"), "//a/c").should be_nil
  end

  REGONLINE = URI.parse("https://www.regonline.com/webservices/default.asmx/LoginRegistrant")

  def net_http_mock(n)
    p = double("post")
    p.should_receive(:set_form_data).with({'email' => 'foo@bar.com',
                                            'password' => 'pass',
                                            'eventID' => '12345'}).exactly(n).times
    Net::HTTP::Post.should_receive(:new).with(REGONLINE.path).exactly(n).times.and_return(p)
    https = double("https")
    resp = double("resp")
    resp.stub(:body){example_xml}
    https.stub(:start){ |x| resp }
    https.should_receive(:use_ssl=).with(true).exactly(n).times
    Net::HTTP.should_receive(:new).with("www.regonline.com", 443).exactly(n).times.and_return(https)
  end


  context "regonline tests" do
    before do
      net_http_mock(1)
    end
    
    it "should register authenticated but unknown users" do
      Attendee.existing_attendee?("24331859").should be_nil
      new_registered = AttendeeCred.authenticate_user('foo@bar.com','pass','12345')
      after_reg = Attendee.existing_attendee?("24331859")
      after_reg.attendee_cred.should  == new_registered
    end

  end

  context "multi login regonline tests" do

    before do
      net_http_mock(2)
    end

    it "should not register existing users" do
      Attendee.existing_attendee?("24331859").should be_nil
      new_registered = AttendeeCred.authenticate_user('foo@bar.com','pass','12345')
      Attendee.existing_attendee?("24331859").should_not be_nil
      second_login = AttendeeCred.authenticate_user('foo@bar.com','pass','12345')
      new_registered.should == second_login
    end

  end


  

  # it "should call post" do
  #   uri = URI.parse "https://www.regonline.com/webservices/default.asmx/LoginRegistrant"
  #   Net::HTTP::Post.should_receive(:new).with(uri.path).once.and_return("the stuff")
  #   AttendeeCred.small_thing().should == "the stuff"
  # end

end
