module Base64Handler
  extend ActiveSupport::Concern

  included do
    helper_method :split_base64
    helper_method :convert_data_uri_to_upload
  end

  def split_base64(uri_str)
  		  if uri_str.match(%r{^data:(.*?);(.*?),(.*)$})
  		    uri = Hash.new
  		    uri[:type] = $1 # "image/gif"
  		    uri[:encoder] = $2 # "base64"
  		    uri[:data] = $3 # data string
  		    uri[:extension] = $1.split('/')[1] # "gif"
  		    return uri
  		  else
  		    return nil
  		  end
  end

  def convert_data_uri_to_upload(obj_hash)
  		  if obj_hash[:image_url].try(:match, %r{^data:(.*?);(.*?),(.*)$})
  		    image_data = split_base64(obj_hash[:image_url])
  		    image_data_string = image_data[:data]
  		    image_data_binary = Base64.decode64(image_data_string)

  		    temp_img_file = Tempfile.new("")
  		    temp_img_file.binmode
  		    temp_img_file << image_data_binary
  		    temp_img_file.rewind

  		    img_params = {:filename => "image.#{image_data[:extension]}", :type => image_data[:type], :tempfile => temp_img_file}
  		    uploaded_file = ActionDispatch::Http::UploadedFile.new(img_params)

  		    obj_hash[:image] = uploaded_file
  		    obj_hash.delete(:image_url)
  		  end
  	return obj_hash
  end

end
