module I18n
  module HTMLExtractor
    module Match
      class PlainTextMatch < BaseMatch
        def self.create(document, node)
          return nil if node.name.start_with?('script')
          node.text.split(/\@\@(=?)[a-z0-9\-_]+\@\@/).select { |t| t =~ /[\p{Han}]/ }.map! do |text|
            new(document, node, text.strip) unless text.blank?
          end
        end

        def replace_text!
          self.key = pinyin_name_key
          document.erb_directives[key] = " #{translation_key_object} "
          if node.content =~ /@@=(?<inner_text>[a-z0-9\-_]+)@@/
            node.content = node.content.gsub(/\A([\p{Han}]*[^\p{Han}]*[\p{Han}]*.*)(@@=[a-z0-9\-]+@@)\z/) do |matched_text|
              "@@=#{key}@@ #{$2}"
            end
          else
            node.content = node.content.gsub(text, "@@=#{key}@@")
        end
        end
      end
    end
  end
end
