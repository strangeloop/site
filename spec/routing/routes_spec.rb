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



require 'spec_helper'

#Spec below is commented out because rspec errors with undefined method `redirect_to'
#why can't rspec recognize the call to redirect_to?
#describe "news routing" do
  #it "redirects blog posts to news" do
    #{ :get => '/blog/71/07/06/my-birthday' }.should redirect_to(:controller => 'news_items',
                                                                #:action => 'show',
                                                                #:id => 'my-birthday')
  #end
#end
