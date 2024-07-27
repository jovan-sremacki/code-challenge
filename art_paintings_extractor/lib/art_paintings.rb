# frozen_string_literal: true

require_relative 'art_paintings_extractor/version'
require_relative 'art_paintings_extractor/html_document'

require 'logger'

# ArtPaintingsExtractor module
module ArtPaintingsExtractor
  # This class is responsible for extracting painting information from an HTML file.
  class ArtPaintings
    attr_reader :doc, :logger

    def initialize(html_file)
      @logger = Logger.new($stdout)
      @doc = HtmlDocument.new(html_file).call
    end

    def paintings
      @doc.css('.klitem')
    end

    def extract_paintings
      paintings.map { |item| build_painting_info(item) }
    end

    
    private
    
    def build_painting_info(item)
      info = {
        'name' => extract_name(item),
        'link' => extract_link(item),
        'image' => nil
        # 'image' => extract_image(item) ## There was a problem with the image extract
      }

      extensions = extract_extensions(item)
      info['extensions'] = [extensions] unless extensions.empty?

      info
    end

    def extract_name(item)
      item['aria-label'] || 'Unknown'
    end

    def extract_extensions(item)
      item.css('.ellip.klmeta').text
    rescue NoMethodError
      @logger.warn("Failed to extract extensions for item: #{item}")
      'No extension found for item'
    end

    def extract_link(item)
      href = item['href']
      href ? "https://www.google.com#{href}" : 'No link'
    end

    def extract_image(item)
      image = item.at_css('g-img > img')
      image ? image['src'] : 'No image'
    end
  end
end
