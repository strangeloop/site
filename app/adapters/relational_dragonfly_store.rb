class RelationalDragonflyStore

  def store(temp_object, opts={})
    timestamp = UUIDTools::UUID.timestamp_create.to_s
    SpeakerImage.create(:uid => timestamp, 
                         :db_image => temp_object.data)
    timestamp
  end

  def retrieve(uid)
    speaker_image = SpeakerImage.find_by_uid(uid)
    if speaker_image.nil?
      [nil, {}]
    else
      [speaker_image.db_image, {}]
    end
  end

  def destroy(uid)
     SpeakerImage.find_by_uid(uid).delete
  end

end  
