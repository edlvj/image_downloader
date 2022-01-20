# frozen_string_literal: true

require_relative '../../lib/image_downloader/download_job'
require 'webmock/rspec'

RSpec.describe ImageDownloader::DownloadJob do
  let(:destination_path) { "#{Bundler.root.to_s}/spec/fixtures/tmp" }

  #after do
  #  Dir.foreach(destination_path) do |f|
  #   fn = File.join(destination_path, f)
  #    File.delete(fn) if f != '.' && f != '..'
  #  end
  #end

  describe '.call' do




    context 'do not create files from invalid status url' do
      before do
        stub_request(:head, "http://test.com/img/custom.jpeg").with(
          headers: {
            'Accept'=>'*/*',
            'User-Agent'=>'Ruby'
          }).to_return(status: 200, body: "", headers: { 'Content-Length' => 3, 'Content-Type' => 'image/jpeg' })
      end

      let(:name) { 'messanger_bot.c13ab147.png' }
      let(:image_url) { 'https://test.com/img/custom.jpeg' }  
    
      it 'return ' do
        expected_path = "#{destination_path}/#{name}.jpeg"
        ImageDownloader::DownloadJob.new(image_url, destination_path).perform
        expect(File.exist?(expected_path)).to be_falsey
      end
    end
  end
end
