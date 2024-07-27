# frozen_string_literal: true

require 'rspec'
require 'logger'
require 'nokogiri'

require_relative '../lib/art_paintings_extractor/html_document'

RSpec.describe 'ArtPaintingsExtractor::HtmlDocument Integration Test' do
  let(:logger) { Logger.new($stdout) }
  let(:html_file_path) { 'spec/fixtures/valid-document.html' }
  let(:invalid_html_file_path) { 'spec/fixtures/invalid-document.html' }
  let(:non_existent_file_path) { 'spec/fixtures/non_existent.html' }
  let(:subject) { ArtPaintingsExtractor::HtmlDocument.new(html_file_path) }

  before do
    allow(Logger).to receive(:new).and_return(logger)
  end

  describe '#call' do
    context 'with a valid HTML file' do
      it 'parses the HTML content correctly' do
        doc = subject.call
        expect(doc).to be_a(Nokogiri::HTML::Document)
        expect(doc.at('h1').text).to eq('Hello world')
      end
    end

    context 'with a non-existent HTML file' do
      let(:subject) { ArtPaintingsExtractor::HtmlDocument.new(non_existent_file_path) }

      it 'logs an error and returns nil' do
        expect(logger).to receive(:error).with(/File not found:/)
        expect(subject.call).to be_nil
      end
    end

    context 'with an invalid HTML file' do
      let(:subject) { ArtPaintingsExtractor::HtmlDocument.new(invalid_html_file_path) }

      before do
        File.write(invalid_html_file_path, '<html><h1>Invalid')
        allow(Nokogiri::HTML::Document).to receive(:parse).and_raise(Nokogiri::XML::SyntaxError.new('Syntax error'))
      end

      after do
        File.delete(invalid_html_file_path) if File.exist?(invalid_html_file_path)
      end

      it 'logs an error and returns nil' do
        expect(logger).to receive(:error).with(/Error parsing HTML:/)
        expect(subject.call).to be_nil
      end
    end
  end
end
