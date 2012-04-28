# Welo::Xml

Welo::Xml is an easy way to serialize your Welo::Resources in XML. Thanks to
the awesome Nokogiri.

## Installation

### Rubygems

    gem install 'welo-xml'

### Bundler

Add this line to your application's Gemfile:

    gem 'welo-xml'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install welo-xml

## Usage

Just include Welo::Xml::Resource in your class.  Then you can use
#build_xml(builder) where builder is a Nokogiri::XML::Builder.

see ./samples/foo.rb for an usage example


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
