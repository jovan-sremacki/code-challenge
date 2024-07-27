# run_extractor.rb

require_relative "lib/art_paintings_extractor"

# Path to the HTML file you want to parse
html_file = "./files/van-gogh-paintings.html"

# Output JSON file
# output_file = 'files/extracted_paintings.json'

# Create an instance of the extractor
extractor = ArtPaintingsExtractor::ArtPaintings.new(html_file)

# Extract paintings and print them
paintings = extractor.extract_paintings
puts paintings

# Save paintings to a JSON file
# extractor.save_to_file(output_file)
