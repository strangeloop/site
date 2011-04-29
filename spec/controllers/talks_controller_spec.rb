require 'spec_helper'

describe TalksController do
  describe "#create" do
    before do
      @talk = Factory(:talk)
      @talk.id= nil
    end
    it "saves the talk" do
      pending
      post :create, :talk => @talk
    end
  end
  
  describe "#index" do
    before do
	  @talk = Factory(:talk)
	  @talk.save
    end
    it "returns CSV" do
      pending "This call isn't calling the CSV code in the controller"
      get :index, :format => 'csv'
    end
  end
end
