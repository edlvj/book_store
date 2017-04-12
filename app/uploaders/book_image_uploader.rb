class BookImageUploader < CarrierWave::Uploader::Base


  if Rails.env.production?
    storage :dropbox
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  def default_url(*args)
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
