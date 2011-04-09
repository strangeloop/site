class ClearPagesLinkUrl < ActiveRecord::Migration
  # This migration is necessary because of a change in RefineryCMS between
  # v0.9.9 and 0.9.9.15.  One of the consequences of the upgrade was that 
  # link_url fields (which had been populated by a seed in this application)
  # contained a path that caused an infinite re-direct for each page other
  # than the root.  Clearing this field resolves this problem.
  def self.up
    Page.find(:all).each {|page|
      next if page.link_url == '/'
      page.link_url = '' if page.link_url != ''
      page.save
    }
  end

  def self.down
  end
end
