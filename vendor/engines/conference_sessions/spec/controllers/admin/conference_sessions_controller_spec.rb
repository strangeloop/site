require 'spec_helper'

describe Admin::ConferenceSessionsController do
  login_organizer

  context "#update" do
    let(:conf_session) { mock_model(ConferenceSession).as_null_object }
    let(:params) { params = {:id => 1, :conference_session => {
        'talk_attributes' => {
          'title' => 'A new title',
          'speakers_attributes' => {
            '0' => {}}}}}}
    let(:params_with_image) { 
      p = params
      p[:conference_session]['talk_attributes']['speakers_attributes']['0'] = {:image => 'foo'}
      p
    }
    let(:image) { mock_model(Image).as_null_object }

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

    it "fixes image before update" do
      Image.stub(:new).with('foo').and_return(image)
      image.stub(:save)
      post :update, params_with_image
      flash[:notice].should eq("'#{conf_session}' was successfully updated.")
    end
  end
end


