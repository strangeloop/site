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
  
  it "should return true with a successful auth XML" do
    AttendeeCred.successful_response?(example_xml).should be_true
  end

  let(:bad_xml){"<?xml version=\"1.0\" encoding=\"utf-8\"?>
<ResultsOfListOfRegistration xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns=\"http://www.regonline.com/api\">
  <Success>false</Success>
</ResultsOfListOfRegistration>"}

  it "should return false with a failed auth XML" do
    AttendeeCred.successful_response?(bad_xml).should be_false
  end

end
