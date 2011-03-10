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
end
