page_position = -1

home_page = Page.create(:title => "Home",
            :deletable => false,
            :show_in_menu => false,
            :link_url => "/",
            :menu_match => "^/$",
            :position => (page_position += 1))
home_page.parts.create({
              :title => "Top",
              :body => "<p>Welcome to our site. This is just a place holder page while we gather our content.</p>",
              :position => 0
            })
home_page.parts.create({
              :title => "Middle",
              :body => "<p>This is another block of content over here.</p>",
              :position => 1
            })
home_page.parts.create({
              :title => "Bottom",
              :body => "<p>This is another block of content over here.</p>",
              :position => 2
            })

home_page_position = -1
page_not_found_page = home_page.children.create(:title => "Page not found",
            :menu_match => "^/404$",
            :show_in_menu => false,
            :deletable => false,
            :position => (home_page_position += 1))
page_not_found_page.parts.create({
              :title => "Body",
              :body => "<h2>Sorry, there was a problem...</h2><p>The page you requested was not found.</p><p><a href='/'>Return to the home page</a></p>",
              :position => 0
            })

about_us_page = Page.create(:title => "About",
            :deletable => true,
            :position => (page_position += 1),
            :menu_match => "^/about$")
about_us_page.parts.create({
              :title => "Body",
              :body => "<p>About info goes here</p>",
              :position => 0
            })

about_page_position = -1
team_page = about_us_page.children.create(:title => "Team",
            :show_in_menu => false,
            :deletable => true,
            :position => (about_page_position += 1),
            :path => "About - Team")
team_page.parts.create({
              :title => "Body",
              :body => "<p>Team info goes here</p>",
              :position => 0
            })

history_path = about_us_page.children.create(:title => "History",
            :show_in_menu => false,
            :deletable => true,
            :position => (about_page_position),
            :path => "About - History")
history_path.parts.create({
              :title => "Body",
              :body => "<p>History info goes here</p>",
              :position => 0
            })

volunteers_page = about_us_page.children.create(:title => "Volunteers",
            :show_in_menu => false,
            :deletable => true,
            :position => (about_page_position),
            :path => "About - Volunteers")
volunteers_page.parts.create({
              :title => "Body",
              :body => "<p>Info for volunteering to help with the conference goes here.</p>",
              :position => 0
            })

faq_path = about_us_page.children.create(:title => "FAQ",
            :show_in_menu => false,
            :deletable => true,
            :position => (about_page_position),
            :path => "About - FAQ")
faq_path.parts.create({
              :title => "Body",
              :body => "<p>FAQ info goes here</p>",
              :position => 0
            })

attendees_page = Page.create(:title => "Attendees",
            :deletable => true,
            :position => (page_position += 1),
            :menu_match => "^/attendees$")

attendees_page.parts.create({
              :title => "Body",
              :body => "<p>Attendees info goes here</p>",
              :position => 0
            })

attendees_page_position = -1
register_page = attendees_page.children.create(:title => "Register",
            :show_in_menu => false,
            :deletable => true,
            :position => (attendees_page_position += 1),
            :path => "Attendees - Register")
register_page.parts.create({
              :title => "Body",
              :body => "<p>No content should go here. Redirect to registration system.</p>",
              :position => 0
            })

connect_page = attendees_page.children.create(:title => "Connect",
            :show_in_menu => false,
            :deletable => true,
            :position => (attendees_page_position),
            :menu_match => "^/connect$")
connect_page.parts.create({
              :title => "Body",
              :body => "<p>No content should go here.  Redirect to connect functionality.</p>",
              :position => 0
            })

venue_page = attendees_page.children.create(:title => "Venue",
            :show_in_menu => false,
            :deletable => true,
            :position => (attendees_page_position),
            :path => "Attendees - Venue")
venue_page.parts.create({
              :title => "Body",
              :body => "<p>Content about the venue goes here.</p>",
              :position => 0
            })

travel_page = attendees_page.children.create(:title => "Travel",
            :show_in_menu => false,
            :deletable => true,
            :position => (attendees_page_position),
            :path => "Attendees - Travel")
travel_page.parts.create({
              :title => "Body",
              :body => "<p>Content about travel goes here.</p>",
              :position => 0
            })

activities_page = attendees_page.children.create(:title => "Things to do",
            :show_in_menu => false,
            :deletable => true,
            :position => (attendees_page_position),
            :path => "Attendees - Things to do")
activities_page.parts.create({
              :title => "Body",
              :body => "<p>Content about things to do goes here.</p>",
              :position => 0
            })

apps_page = attendees_page.children.create(:title => "Apps",
            :show_in_menu => false,
            :deletable => true,
            :position => (attendees_page_position),
            :path => "Attendees - Apps")
apps_page.parts.create({
              :title => "Body",
              :body => "<p>Content about conference apps goes here.</p>",
              :position => 0
            })

sessions_page = Page.create(:title => "Sessions",
            :deletable => true,
            :link_url => "/sessions",
            :position => (page_position += 1),
            :menu_match => "^/sessions$")

sessions_page.parts.create({
              :title => "Body",
              :body => "<p>No content goes here. Placeholder for dynamic schedule page.</p>",
              :position => 0
            })

sessions_page_position = -1
speakers_page = sessions_page.children.create(:title => "Speakers",
            :show_in_menu => false,
            :deletable => true,
            :position => (sessions_page_position += 1),
            :menu_match => "^/speakers$",
            :path => "Sessions - Speakers")
speakers_page.parts.create({
              :title => "Body",
              :body => "<p>No content goes here. Placeholder for dynamic speaker page.</p>",
              :position => 0
            })

schedule_page = sessions_page.children.create(:title => "Schedule",
            :show_in_menu => false,
            :deletable => true,
            :position => (sessions_page_position),
            :menu_match => "^/talks$")
sessions_page.parts.create({
              :title => "Body",
              :body => "<p>No content goes here. Placeholder for dynamic talks page.</p>",
              :position => 0
            })

content_page = sessions_page.children.create(:title => "Content",
            :show_in_menu => false,
            :deletable => true,
            :position => (sessions_page_position),
            :path => "Schedule - Content")
content_page.parts.create({
              :title => "Body",
              :body => "<p>Content about the schedule goes here.</p>",
              :position => 0
            })

sponsors_page = Page.create(:title => "Sponsors",
            :deletable => true,
            :position => (page_position += 1),
            :menu_match => "^/sponsors$")
sponsors_page.parts.create({
              :title => "Body",
              :body => "<p>Sponsor info goes here</p>",
              :position => 0
            })

sponsors_page_position = -1
prospectus_page = sponsors_page.children.create(:title => "Prospectus",
            :show_in_menu => false,
            :deletable => true,
            :position => (sponsors_page_position += 1),
            :path => "Sponsors - Prospectus")
prospectus_page.parts.create({
              :title => "Body",
              :body => "<p>Prospectus info goes here</p>",
              :position => 0
            })


password_reset_page = attendees_page.children.create(:title => "Password Reset",
                                                :show_in_menu => false,
                                                :deletable => true,
                                                :position => (attendees_page_position),                                                                             :path => "Attendees - Password Reset")
password_reset_page.parts.create({:title => "Body",
                                   :body => "<p>Password reset instructions go here</p>",
                                   :position => 0})


