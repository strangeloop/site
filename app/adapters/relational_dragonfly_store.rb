class RelationalDragonflyStore

  def store(temp_object, opts={})
    timestamp = UUIDTools::UUID.timestamp_create.to_s
    DatastoreImage.create(:uid => timestamp, 
                         :image => temp_object.data)
    timestamp
  end

  def retrieve(uid)
    speaker_image = DatastoreImage.find_by_uid(uid)
    if speaker_image.nil?
      [nil, {}]
    else
      [speaker_image.image, {}]
    end
  end

  def destroy(uid)
     DatastoreImage.find_by_uid(uid).delete
  end

end  
