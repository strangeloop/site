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



module Admin
  class SponsorshipsController < Admin::BaseController
    include ImageUploadFix

    prepend_before_filter :find_all_levels, :only => [:new, :edit]

    crudify :sponsorship, :xhr_paging => true

    expose(:year) { params[:year] || Time.now.year }
    expose(:all_years) { Sponsorship.all_years }
    expose(:current_sponsorships){ Sponsorship.from_year(year).paginate({:page => params[:page], :per_page => 20})}
    
    def new
      @sponsorship = Sponsorship.new(:contact => Contact.new, :sponsor => Sponsor.new)
    end

    #callback invoked by ImageUploadFix
    def image_in_params(params)
      params[:sponsorship][:sponsor_attributes]
    end

    def find_all_levels
      @levels = SponsorshipLevel.all
    end
  end
end
