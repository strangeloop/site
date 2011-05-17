require 'spec_helper'

describe Talk do
  [:title, :abstract].each do |field| 
    it {should validate_presence_of field}
  end

  context "Tests with tags" do
    before do
      @model = Factory(:talk)
      @model.tag_list = "Ruby, Rails"
      @model.save
    end

    it "Should be tagged" do
      Talk.tagged_with("Ruby").size.should == 1
      Talk.tagged_with("Rails").size.should == 1
      Talk.tagged_with("Cobol").size.should == 0
    end
  end

  it {should have_and_belong_to_many :speakers}

  [:abstract, :prereqs, :comments, :av_requirement].each do |field|
    it {should have_db_column(field).of_type(:text)}
  end

  
  def self.test_enum_fields(enum_field_hash)
    enum_field_hash.each_pair do |enum, field |
      enum.each do |enum_field|
        it { should allow_value(enum_field).for(field)}
        it { should_not allow_value("chinaski").for(field) }
      end
    end
  end
    
  test_enum_fields( {Talk.video_approvals => :video_approval,
                      Talk.talk_types => :talk_type})

  it{ should_not allow_value("x" * 56).for(:title)}
  it{ should allow_value("x" * 1201).for(:abstract)}
  it{ should allow_value("x" * 2000).for(:abstract)}
  it{ should_not allow_value("x" * 2001).for(:abstract)}
  
end
