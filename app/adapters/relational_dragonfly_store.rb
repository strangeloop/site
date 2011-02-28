class RelationalDragonflyStore

  def store(temp_object, opts={})
     email_hash = Digest::MD5.hexdigest(opts[:email])
     img = SpeakerImage.create(:uid => email_hash, 
                               :image => temp_object.data)
    img.save
    email_hash
  end

  def retrieve(uid)
    speaker_image = SpeakerImage.where(:uid => uid).first
    if speaker_image.nil?
      [nil, {}]
    else
      [speaker_image.image, {}]
    end
  end

  def destroy(uid)
     SpeakerImage.where(:uid => uid).first.delete
  end

end  
