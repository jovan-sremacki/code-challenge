# ArtPaintingsExtractor

ArtPaintingsExtractor is a Ruby gem designed to extract painting information from HTML files. The gem uses Nokogiri for parsing HTML and is structured to handle errors gracefully with logging.

## Installation

Add this line to your application's Gemfile:

```
gem 'art_paintings_extractor'
```

And then execute: <br>

```
bundle install
```

Or install it yourself as:

```
gem install art_paintings_extractor
```

## Usage

### Basic usage

To use the gem, first require it in your Ruby script:

```
require 'nokogiri'
require 'art_paintings'
```

Then, create an instance of the ArtPaintings class and pass the path to your HTML file:

```
html_file = "#{Dir.pwd}/path/to/your/file.html"
extractor = ArtPaintingsExtractor::ArtPaintings.new(html_file)
paintings = extractor.extract_paintings

paintings.each do |painting|
  puts "Name: #{painting['name']}"
  puts "Link: #{painting['link']}"
  puts "Image: #{painting['image']}"
  puts "Extensions: #{painting['extensions']}"
  puts "---------------------------"
end
```

### Limitations

Currently, the gem may have issues with extracting images that are set via JavaScript.

### Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.