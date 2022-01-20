# frozen_string_literal: true

require 'dry-configurable'
require 'bundler/setup'
require_relative 'image_downloader/version'

module ImageDownloader
  class Error < StandardError; end

  class ImageDownloadConfig
    extend Dry::Configurable

    setting(:splitter, default: ' ')
    setting(:min_file_size, default: 10)
    setting(:max_file_size, default: 100_000)
    setting(:formats, default: %w[jpg jpeg png gif ico svg bmp])
    setting(:download_store_path, default: "#{::Bundler.root.to_s}/downloads")
    setting(:url_regex, default: %r{\A((http|https):\/\/)[\w]+([\-\.]{1}[\w]+)*\.[\w]{2,25}(:[0-9]{1,5})?(\/.*)?\z})
  end
end