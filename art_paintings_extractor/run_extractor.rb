require 'nokogiri'

require_relative "lib/art_paintings"

html_file = "./files/van-gogh-paintings.html"

extractor = ArtPaintingsExtractor::ArtPaintings.new(html_file)

paintings = extractor.extract_paintings
puts paintings