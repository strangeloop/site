require 'spec_helper'

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
      response.should render_template('layouts/admin', 'admin/conference_sessions/edit')
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
end


