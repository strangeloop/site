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



# This customizes the User model defined in the refinery-
# authentication plugin.  We have to do it this way bc
# Rails needs to load the model first and the below
# customizations are triggered after Rails has finished
# loading the app in an after_initialize callback.

require "net/http"
require "net/https"

class UserCustomizer

  def self.load
    User.class_eval do
      has_many :services, :dependent => :destroy
      ajaxful_rater

      def self.successful_response?(xml)
        xml_doc = Nokogiri::Slop(xml)
        xml_doc.remove_namespaces!
        xml_doc.ResultsOfListOfRegistration.Success.content == "true"
      end

      def self.authenticate_user(email, password, eventId)
        url = URI.parse "https://www.regonline.com/webservices/default.asmx/LoginRegistrant"
        req = Net::HTTP::Post.new(url.path)
        req.set_form_data({'email' => email,
                            'password' => password,
                            'eventID' => eventId})
        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true
        resp = https.start { |cx| cx.request(req) }
        successful_response? resp.body
      end
    end
  end
end
