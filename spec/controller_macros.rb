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



# Provides a convenience method for simulating login via
# an administrative user (to get through the devise authentication)
module ControllerMacros
  def login_admin
    handle_login :admin
  end

  def login_organizer
    handle_login :organizer
  end

  def login_reviewer
    handle_login :reviewer
  end

  private
  def handle_login(role)
    before(:each) do
      @request.env['devise.mapping'] = :admin
      sign_in Factory.create(role)
    end
  end

end


