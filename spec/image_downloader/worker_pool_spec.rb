
# frozen_string_literal: true

require_relative '../../lib/image_downloader/worker_pool'

RSpec.describe ImageDownloader::WorkerPool do

  before do 
  	ImageDownloader::WorkerPool.new()
  end

  describe '.execute' do

    it 'return success if url valid' do
      url = 'http://valid.com'
      #expect().to eq 
    end
  end
end