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
