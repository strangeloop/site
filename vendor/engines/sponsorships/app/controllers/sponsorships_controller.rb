class SponsorshipsController < ApplicationController

  before_filter :find_all_sponsorships
  before_filter :find_page

  def index
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @sponsorship in the line below:
    present(@page)
  end

  def show
    @sponsorship = Sponsorship.find(params[:id])

    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @sponsorship in the line below:
    present(@page)
  end

protected

  def find_all_sponsorships
    @sponsorships = Sponsorship.order('position ASC')
  end

  def find_page
    @page = Page.where(:link_url => "/sponsorships").first
  end

end
