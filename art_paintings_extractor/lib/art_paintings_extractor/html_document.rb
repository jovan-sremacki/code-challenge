# frozen_string_literal: true

module ArtPaintingsExtractor
  # Class responsible for reading the contents of an HTML file
  class HtmlDocument
    attr_reader :logger

    def initialize(html)
      @html = html
      @logger = Logger.new($stdout)
    end

    def call
      extract_from_html
    end

    private

    def read_html_file
      File.read(@html)
    rescue Errno::ENOENT
      @logger.error("File not found: #{@html}")
      nil
    rescue Errno::EACCES
      @logger.error("Permission denied: #{@html}")
      nil
    rescue StandardError => e
      @logger.error("Error reading file: #{e.message}")
      nil
    end

    def extract_from_html
      html_file = read_html_file

      return nil unless html_file

      Nokogiri::HTML(read_html_file)
    rescue Nokogiri::XML::SyntaxError => e
      @logger.error("Error parsing HTML: #{e.message}")
      nil
    end
  end
end
