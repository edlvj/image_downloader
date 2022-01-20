# frozen_string_literal: true

module ImageDownloader
  class HandleInput
    attr_accessor :load_path, :download_path

    def initialize(load_path, download_path)
      @load_path = load_path
      @download_path = download_path || ImageDownloadConfig.config.download_path
    end

    def call
      pool = WorkerPool.new(10)
      splitter = ImageDownloadConfig.config.splitter

      @document.split(splitter).each do |image_url|

        case ImageDownloader::UrlValidator.new(request).call
        when Success
          pool.do_work(DownloadJob.new(image_url, download_path))
        when Failure
          p 'invalid url' + url
        end
      end

      #pool.wait
      #pool.close
    end

    private

    def loaded_file
      @loaded_file = File.open(load_path)
    rescue Errno::ENOENT
      p 'file is not exist'
    end
  end
end  