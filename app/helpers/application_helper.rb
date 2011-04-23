# Methods added to this helper will be available to all templates in the application.

# You can extend refinery with your own functions here and they will likely not get overriden in an update.
module ApplicationHelper

  def link_tree(pages = [])
    pages.inject([]) do |arr, page|
      size = page.children.size + 1
      if arr.empty? || arr.last[:size] + size > tree_row_height
        holder = {}
        holder[:size] = size
        holder[:pages] = [page]
        arr << holder
      else
        last = arr.last
        last[:size] += size
        last[:pages] << page
      end
      arr
    end.map{|groups| groups[:pages]}
  end

  def speaker_for(talk)
    speaker = talk.speakers.first
    "#{speaker.first_name} #{speaker.last_name}"
  end

  def twitter_link(twitter_id = '', tag_type = :strong)
    link_to(content_tag(tag_type, "@#{twitter_id}"), "http://twitter.com/#{twitter_id}") unless twitter_id.blank?
  end

  private
  def tree_row_height
    7
  end
end
