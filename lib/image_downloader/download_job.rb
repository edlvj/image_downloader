# frozen_string_literal: true

require 'dry-monads'
require 'net/http'
require_relative 'metadata_validator'

module ImageDownloader
  class DownloadJob
    attr_accessor :url, :destination_path

    include Dry::Monads[:result]

    def initialize(url, destination_path)
      @url = URI.parse(url)
      @destination_path = destination_path
    end

    def name
      "url: #{@url}"
    end

    def perform
      metadata = get_metadata
      
      case ImageDownloader::MetadataValidator.new(metadata['content-type'], metadata['content-length']).call
      when Success
        request = Net::HTTP::Get.new(@url.path)

        Net::HTTP.start(url.host) { |http|
          download_by_segment(http, request)
        }
      when Failure
        p 'invalid metadata for ' + url
      end
    end

    private

    def get_metadata
      begin
        http = Net::HTTP.new @url.host
        p http.inspect
        res = http.head @url.path
      rescue Net::OpenTimeout => e
        p "timeout for #{e}"
        nil
      end
    end 

    def download_by_segment(http, request)
      file = open("#{@destination_path}/#{@url.path}", 'wb')
      begin
        http.request_get(request.path) do |response|
          response.read_body do |segment|
            file.write(segment)
          end
        end
      ensure
        file.close()
      end
    end
  end
end