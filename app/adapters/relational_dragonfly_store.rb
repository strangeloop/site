class RelationalDragonflyStore

  def store(temp_object, opts={})
    email_hash = Digest::MD5.hexdigest(opts[:email])
    SpeakerImage.create(:uid => email_hash, 
                         :image => temp_object.data)
    email_hash
  end

  def retrieve(uid)
    speaker_image = SpeakerImage.find_by_uid(uid)
    if speaker_image.nil?
      [nil, {}]
    else
      [speaker_image.image, {}]
    end
  end

  def destroy(uid)
     SpeakerImage.find_by_uid(uid).delete
  end

end  
