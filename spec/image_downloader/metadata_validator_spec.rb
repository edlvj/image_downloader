# frozen_string_literal: true

require_relative '../../lib/image_downloader/image_validator'

RSpec.describe ImageValidator do
  before do
    @image_validator = ImageDownloader::ImageValidator.new('spec/fixtures/valid_urls.txt', 'tmp/dir/')
  end

  let(:base_result_class) { Dry::Monads::Result }

  describe '.call' do
    it 'return success if url valid' do
      url = 'http://valid.com'
      expect(ImageDownloader::UrlValidator.new(url).call.class).to eq base_result_class::Success
    end
  end  
end