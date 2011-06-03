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



module ImageUploadFix

  def ImageUploadFix.included(mod)
    mod.class_eval do
      prepend_before_filter :fix_image, :only => [:create, :update]
    end
  end

  def fix_image
    image_param = image_in_params(params).delete(:image)
    if image_param
      image = Image.new(image_param)
      image.save
      image_in_params(params)[:image] = image
    end
  end
end
