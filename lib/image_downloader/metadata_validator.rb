# frozen_string_literal: true

require 'dry-monads'

module ImageDownloader
  class MetadataValidator
    include Dry::Monads[:result]
    
    attr_reader :type, :length

    def initialize(type, length)
      @type = type
      @length = length
    end

    def call
      return Failure(:invalid_path) unless valid_format?(format)
      return Failure(:invalid_size) unless validate_max_length?(length)
      return Failure(:invalid_size) unless valid_min_length?(length)

      Success(type, length)
    end  

    private

    def validate_max_length?(image_size)
      image_size > ImageDownloadConfig.config.max_file_size
    end

    def valid_min_length?(image_size)
      image_size < ImageDownloadConfig.config.min_file_size
    end  

    def valid_format?(format)
      ALLOWED_FORMATS.include?(ImageDownloadConfig.config.formats)
    end    
  end
end  
