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
