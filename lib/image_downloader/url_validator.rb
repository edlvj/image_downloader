# frozen_string_literal: true

require 'dry-monads'

module ImageDownloader
  class UrlValidator
    include Dry::Monads[:result]

    attr_reader :image_url

    def initialize(image_url)
      @image_url = image_url
    end
    
    def call
      return Failure(:blank) if image_url.nil?

      if image_url.match(ImageDownloadConfig.config.url_regex).nil?
        Failure(:invalid_url)
      else
        Success(image_url)
      end  
    end
  end
end  
