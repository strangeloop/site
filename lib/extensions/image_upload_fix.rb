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
