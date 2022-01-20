# frozen_string_literal: true

require_relative '../../lib/image_downloader/handle_input'

describe ImageDownloader::HandleInput do

  before do
    @handle_input = ImageDownloader::HandleInput.new('spec/fixtures/valid_urls.txt', 'tmp/dir/')
  end
  
  describe '.call' do
    context 'when file is absent' do
      let(:file_path) { 'absent.txt' }	
    
      it 'return ' do
        @handle_input.call
      end
    end

    context 'when file is persist valid urls' do
   	  let(:file_path) { 'spec/fixtures/valid_urls.txt' }

   	  it 'return error' do
        @handle_input.call
      end
    end
  end
end  