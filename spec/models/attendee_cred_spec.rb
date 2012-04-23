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

  let(:attendee) do
    a = Attendee.new
    a.first_name= "Ryan"
    a.last_name= "Senior"
    a.reg_id= "112233445566"
    a.city= "St Louis"
    a.state= "MO"
    a.email= "rsenior@revelytix.com"
    a
  end
  
  it "Should create a password for the new attendee cred" do
    ac = AttendeeCred.create_attendee_cred(attendee)

    ac.email.should == attendee.email
    ac.password.should_not be_nil
    ac.password.length.should == 20
  end

  it "should create a new attendee if one does not exist" do
    Attendee.existing_attendee?(attendee.reg_id).should be_false
    AttendeeCred.create_new_attendee(attendee)
    Attendee.existing_attendee?(attendee.reg_id).should be_true
  end

  it "should not create a new attendee if it already exists" do
    Attendee.existing_attendee?(attendee.reg_id).should be_false
    AttendeeCred.create_new_attendee(attendee)
    prev_attendee = Attendee.existing_attendee?(attendee.reg_id)
    AttendeeCred.create_new_attendee(attendee)
    curr_attendee = Attendee.existing_attendee?(attendee.reg_id)
    prev_attendee.created_at.should == curr_attendee.created_at
    prev_attendee.id.should == curr_attendee.id
  end

end
