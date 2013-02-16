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
require_relative '../../../app/controllers/admin/conference_sessions_controller'

describe Admin::ConferenceSessionsController do
  login_organizer

  let(:conf_session) { mock_model(ConferenceSession).as_null_object }
  let(:params) do
    { :id => 1,
      :conference_session => {
        'talk_attributes' => {
          'title' => 'A new title',
          'speakers_attributes' => {
            '0' => {}
          }
        }
      }
    }
  end
  let(:params_with_image) do
    p = params
    p[:conference_session]['talk_attributes']['speakers_attributes']['0'] = {:image => 'foo'}
    p
  end
  let(:image) { mock_model(Image).as_null_object }

  context "#update" do

    before do
      ConferenceSession.stub(:find).with(1, {:include=>[]}).and_return(conf_session)
    end

    it "writes to flash on successful update" do
      conf_session.stub(:update_attributes).with(params[:conference_session]).and_return(true)
      post :update, params
      flash[:notice].should eq("'#{conf_session}' was successfully updated.")
    end

    it "renders edit page when update fails" do
      conf_session.stub(:update_attributes).with(params[:conference_session]).and_return(false)
      post :update, params
      response.should render_template('admin/conference_sessions/edit')
    end

    context "handles image form param" do
      it "fixes image before update" do
        conf_session.stub(:title).and_return('title')
        post :update, params_with_image
        flash[:notice].should eq("'title' was successfully updated.")
      end
    end
  end

  it "fixes image before create" do
    conf_session.stub(:valid?).and_return(true)
    conf_session.stub(:title).and_return('foo')
    ConferenceSession.stub(:create).and_return(conf_session)
    post :create, params_with_image
    flash[:notice].should eq("'foo' was successfully added.")
  end

  context "export action" do
    it "exports conference sessions to CSV" do
      ConferenceSession.stub(:to_csv).with("2011").and_return('a, b, c')
      get "export", :year => "2011", :format => "csv"
      response.body.should == 'a, b, c'
    end
  end

  describe '#all_years' do
    let(:mock_years) { mock 'all years'  }
    it 'delegates to ConferenceSession' do
      ConferenceSession.should_receive(:all_years).and_return(mock_years)
      subject.all_years.should == mock_years
    end
  end

  describe '#current_conference_sessions' do
    let(:mock_year) { Time.now.year }
    let(:mock_page) { mock 'page' }
    let(:mock_params) { {:page => mock_page, :year => mock_year} }
    let(:mock_scope) { mock 'session scope' }
    before { subject.stub(:params => mock_params) }

    it 'returns paginated sessions for the requested year' do
      ConferenceSession.should_receive(:from_year).with(mock_year).and_return(mock_scope)
      mock_scope.should_receive(:paginate).with({:page => mock_page, :per_page => 30}).and_return(mock_scope)
      subject.current_conference_sessions.should == mock_scope
    end
  end
end


