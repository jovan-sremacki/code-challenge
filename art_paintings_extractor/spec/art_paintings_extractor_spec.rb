# frozen_string_literal: true

require 'rspec'
require 'json'

require_relative '../lib/art_paintings'

RSpec.describe ArtPaintingsExtractor::ArtPaintings do
  let(:html_file) { "#{File.dirname(__FILE__)}/../files/van-gogh-paintings.html" }
  let(:expected_array) do
    file_path = "#{File.dirname(__FILE__)}/../files/expected-array-without-images.json"
    JSON.parse(File.read(file_path))['artworks']
  end

  subject { described_class.new(html_file) }

  describe '.extract_paintings' do
    it 'extracts paintings information from the HTML document' do
      paintings = subject.extract_paintings
      expect(paintings).not_to be_empty
      expect(paintings.first).to include('name', 'extensions', 'link')
    end

    it 'returns the expected array of paintings' do
      expect(subject.extract_paintings).to eq(expected_array)
    end
  end

  describe '.extract_name' do
    it 'extracts the name of the painting' do
      painting = subject.paintings.first

      expect(subject.send(:extract_name, painting)).to eq('The Starry Night')
    end
  end

  describe '.extract_extension' do
    it 'extracts the extensions of the painting' do
      painting = subject.paintings.first

      expect(subject.send(:extract_extensions, painting)).to eq('1889')
    end
  end

  describe '.extract_link' do
    it 'extracts the link of the painting' do
      painting = subject.paintings.first

      expect(subject.send(:extract_link, painting)).to eq("https://www.google.com#{painting['href']}")
    end
  end

  describe '.extract_image' do
    it 'etracts the image of the painting' do
      painting = subject.paintings.first

      expect(subject.send(
               :extract_image,
               painting
             ))
        .to eq('data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==')
    end
  end
end
