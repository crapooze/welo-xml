
require 'welo'

module Welo
  module Xml
    module Resource
      include Welo::Resource

      def self.included(mod)
        mod.extend ClassMethods
        mod.extend Welo::Resource::ClassMethods
      end

      module ClassMethods
        def xml_element(val=nil)
          (@xml_element ||= val.freeze) || base_path.tr('./','')
        end

        def xpath(persp=:default)
          ["//xmlns:#{xml_element}", {'xmlns' => ns(persp)}]
        end

        def proprietary_ns(val=nil)
          @proprietary_ns ||= val.freeze
        end

        def base_ns
          [NS, proprietary_ns, base_path].compact.join(':').freeze
        end

        def ns(persp=:default)
          [base_ns, persp.to_s].join('#').freeze
        end
      end

      def xml_element
        self.class.xml_element
      end

      def ns(persp=:default)
        self.class.ns(persp)
      end

      def build_xml_head(xml, persp=:default, id=:default)
        xml.send(xml_element,{:xmlns => ns(persp)}, :path => File.join('',path(id)))
      end

      def build_xml(xml, persp=:default, id=:default)
        xml.send(xml_element,{:xmlns => ns(persp)}, :path => File.join('',path(id))) do |node|
          structure_pairs(persp).each do |name, val|
            case val
            when Welo::Link #just write an xml head node
              val.to.build_xml_head(node)
            when Welo::LinksEnumerator #a list of xml head nodes
              node.send(name) do |n2|
                val.each do |link|
                  link.to.build_xml_head(n2)
                end
              end
            when Welo::Embedder #embeds one node
              val.to.build_xml(node, persp)
            when Welo::EmbeddersEnumerator #embeds multiple nodes
              node.send(val.label) do
                val.each do |embedder|
                  embedder.to.build_xml(node, persp)
                end
              end
            else
              node.send(name, val)
            end
          end
        end
      end
    end
  end
end
