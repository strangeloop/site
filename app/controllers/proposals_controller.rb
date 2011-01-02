class ProposalsController < ApplicationController
  def new
    @proposal = Proposal.new
  end

  def create
    @proposal = Proposal.new params[:proposal]
    @proposal.save
  end

  def index
  end

  def destroy
  end

end
