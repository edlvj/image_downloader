# frozen_string_literal: true

require_relative '../../lib/image_downloader/url_validator'

RSpec.describe ImageDownloader::UrlValidator do

  let(:base_result_class) { Dry::Monads::Result }

  describe '.call' do
    it 'return success if url valid' do
      url = 'http://valid.com'
      expect(ImageDownloader::UrlValidator.new(url).call.class).to eq base_result_class::Success
    end
    
    it 'return success if url valid' do
      expect(ImageDownloader::UrlValidator.new(nil).call.class).to eq base_result_class::Failure
    end

    it 'return failture if RCE danger' do
      url = '/ls'
      expect(ImageDownloader::UrlValidator.new(url).call.class).to eq base_result_class::Failure
    end

    it 'return failture if protocol invalid' do
      url = 'oops://oops'
      expect(ImageDownloader::UrlValidator.new(url).call.class).to eq base_result_class::Failure
    end  
  end
end