#- Copyright 2011 Strange Loop LLC
#-
#- Licensed under the Apache License, Version 2.0 (the "License");
#- you may not use this file except in compliance with the License.
#- You may obtain a copy of the License at
#-
#-    http://www.apache.org/licenses/LICENSE-2.0
#-
#- Unless required by applicable law or agreed to in writing, software
#- distributed under the License is distributed on an "AS IS" BASIS,
#- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#- See the License for the specific language governing permissions and
#- limitations under the License.
#-



require 'spec_helper'

describe Talk do
  [:title, :abstract].each do |field|
    it {should validate_presence_of field}
  end

  context "Tests with tags" do
    before do
      Factory(:talk).tap do |model|
        model.tag_list = "Ruby, Rails"
        model.save
      end
    end

    it "Should be tagged" do
      Talk.tagged_with("Ruby").size.should == 1
      Talk.tagged_with("Rails").size.should == 1
      Talk.tagged_with("Cobol").size.should == 0
    end
  end

  it {should have_and_belong_to_many :speakers}
  it {should belong_to :track}

  describe '#track_name' do
    let(:params) { {} }

    subject { described_class.new(params).track_name }

    context 'has a track' do
      let(:params) { {:track => Factory(:track)} }

      it { should == 'Ruby' }
    end

    context 'does not have a track' do
      it { should == ''}
    end
  end

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
                      Talk.talk_durations => :duration})

  it{ should_not allow_value("x" * 56).for(:title)}
  it{ should allow_value("x" * 1201).for(:abstract)}
  it{ should allow_value("x" * 4000).for(:abstract)}
  it{ should_not allow_value("x" * 4001).for(:abstract)}

  describe '#main_speaker' do
    let(:speaker) { Speaker.new }
    let(:mock_speaker) { mock 'speaker' }
    subject { Talk.new(:speakers => [speaker]) }

    it 'delegates to the first speaker' do
      subject.main_speaker.should == speaker
    end
  end
end
