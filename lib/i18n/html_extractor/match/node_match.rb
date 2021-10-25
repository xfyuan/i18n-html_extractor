require 'ruby-pinyin'

module I18n
  module HTMLExtractor
    module Match
      class NodeMatch
        attr_reader :document, :text

        def initialize(document, text)
          @document = document
          @text = text
        end

        def pinyin_name_key
          PinYin.of_string(text[0,9]).join '_'
        end

        def translation_key_object
          "t('.#{key}')"
        end

        def replace_text!
          raise NotImplementedError
        end

        attr_writer :key

        def key
          @key ||= text.parameterize.underscore
        end
      end
    end
  end
end
