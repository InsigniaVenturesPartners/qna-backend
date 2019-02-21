module ApplicationHelper

  def self.get_base64_image(string)

  end

  def self.convert_base64_image(image_url)
    if (!image_url)
      return image_url
    end
    uri = URI(image_url)
    serverHost = ENV.fetch('AWS_BUCKET') + '.s3-' + ENV.fetch('AWS_REGION') + '.amazonaws.com'
    dir = 'images/'
    file_key = Digest::MD5.hexdigest(image_url)
    file_object = open(image_url)
    conversion_result = self.upload_to_rafael_s3(dir + file_key, file_object, 'public-read')
    if (conversion_result['is_success'])
      image_url = conversion_result['aws_url']
    end
    return image_url
  end

end
