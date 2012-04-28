
$LOAD_PATH.unshift './lib'

require 'welo-xml'
require 'json'

class Foo
  include Welo::Xml::Resource
  identify :default, [:name]
  perspective :default, [:name, :bars, :bar, :baz, :bazs]
  relationship :bar, :Bar, [:one]
  relationship :bars, :Bar, [:many]
  relationship :baz, :Baz, [:one]
  relationship :bazs, :Baz, [:many]
  embedding :bazs, :default
  embedding :baz, :default
  attr_accessor :name, :bars, :bazs, :bar, :baz
  def initialize(name)
    @name = name
    @bars = []
    @bazs = []
    @bar  = nil
    @baz  = nil
  end
end

class Baz
  include Welo::Xml::Resource
  identify :default, [:id]
  perspective :default, [:id]
  def id
    @id ||= rand(256)
  end
end

class Bar
  include Welo::Xml::Resource
  identify :default, [:id]
  perspective :default, [:id]
  def id
    @id ||= rand(256)
  end
end


jon = Foo.new('jon')
jon.bar = Bar.new
jon.baz = Baz.new
jon.bars << Bar.new
jon.bars << Bar.new
jon.bazs << Baz.new


dat = Nokogiri::XML::Builder.new do |xml|
    jon.build_xml xml
end

puts jon.to_json :default
puts dat.to_xml



