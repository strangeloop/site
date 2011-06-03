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



class ProposalsController < ApplicationController

  before_filter :find_all_proposals
  before_filter :find_page

  def index
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @proposal in the line below:
    present(@page)
  end

  def show
    @proposal = Proposal.find(params[:id])

    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @proposal in the line below:
    present(@page)
  end

protected

  def find_all_proposals
    @proposals = Proposal.find(:all, :order => "position ASC")
  end

  def find_page
    @page = Page.find_by_link_url("/proposals")
  end

end
