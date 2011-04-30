module ConferenceSessionsHelper
  # expects an Image object as the first param and a display size (:small or :medium)
  # returns a "default" image tag if no/nil Image is supplied
  def image_tag_for(image = nil, size = :medium)
    image.nil? ? image_tag(default_image[size]) : image_fu(image, size)
  end

  private
  def default_image
    {:medium => 'attendees.jpeg', :small => 'attendees-small.jpeg'}
  end

end
