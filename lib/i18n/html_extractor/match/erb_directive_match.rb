module I18n
  module HTMLExtractor
    module Match
      class ErbDirectiveMatch < NodeMatch
        REGEXPS = [
          [/^([ \t]*link_to )(("[^"]+")|('[^']+'))/, '\1%s', 2],
          [/^([ \t]*link_to (.*),[ ]?title:[ ]?)(("[^"]+")|('[^']+'))/, '\1%s', 3],
          [/^([ \t]*link_to (.*),[ ]?label:[ ]?)(("[^"]+")|('[^']+'))/, '\1%s', 3],
          [/^([ \t]*link_to (.*),[ ]?"data-confirm"[ ]?=>[ ]?)(("[^"]+")|('[^']+'))/, '\1%s', 3],
          [/^([ \t]*link_to (.*),[ ]?confirm:[ ]?)(("[^"]+")|('[^']+'))/, '\1%s', 3],
          [/^([ \t]*content_for (.*),)[ ]*(("[^"]+")|('[^']+'))/, '\1%s', 3],
          [/^([ \t]*react_component (.*),[ ]?placeholder:[ ]?)(("[^"]+")|('[^']+'))/, '\1%s', 3],
          [/^([ \t]*react_component (.*),[ \t\n]*placeholder:[ ]?)(("[^"]+")|('[^']+'))/m, '\1%s', 3],
          [/^([ \t]*text_field_tag (.*),[ ]?placeholder:[ ]?)(("[^"]+")|('[^']+'))/, '\1%s', 3],
          [/^([ \t]*number_field_tag (.*),[ ]?placeholder:[ ]?)(("[^"]+")|('[^']+'))/, '\1%s', 3],
          [/^([ \t]*form_group(.*),[ ]?label_text:[ ]?)(("[^"]+")|('[^']+'))/, '\1%s', 3],
          [/^([ \t]*select_tag[ ]?(.*),[ ]?include_blank:[ ]?)(("[^"]+")|('[^']+'))/, '\1%s', 3],
          [/^([ \t]*select "",[ ]?(.*),[ ]?\{[ ]?include_blank:[ ]?)(("[^"]+")|('[^']+'))/, '\1%s', 3],
          [/^([ \t]*label_tag[ ]?(.*),[ ]?)(("[^"]+")|('[^']+'))/, '\1%s', 3],
          [/^([ \t]*submit_tag[ ]?)(("[^"]+")|('[^']+'))/, '\1%s', 2],
          [/^([ \t]*help_tag[ ]?)(("[^"]+")|('[^']+'))/, '\1%s', 2],
          [/^([ \t]*[a-z_]+\.[a-z_]+_field (.*),[ ]?placeholder:[ ]?)(("[^"]+")|('[^']+'))/, '\1%s', 3],
          [/^([ \t]*[a-z_]+\.text_area (.*),[ ]?placeholder:[ ]?)(("[^"]+")|('[^']+'))/, '\1%s', 3],
          [/^([ \t]*[a-z_]+\.text_field (.*),[ ]?placeholder:[ ]?)(("[^"]+")|('[^']+'))/, '\1%s', 3],
          [/^([ \t]*[a-z_]+\.submit )(("[^"]+")|('[^']+'))/, '\1%s', 2],
          [/^([ \t]*[a-z_]+\.select (.*),[ ]?{[ ]?include_blank:[ ]?)(("[^"]+")|('[^']+'))/, '\1%s', 3],
          [/^([ \t]*[a-z_]+\.label\s+\:[a-z_]+\,\s+)(("[^"]+")|('[^']+'))/, '\1%s', 2]
        ].freeze

        def initialize(document, fragment_id, text, regexp)
          super(document, text)
          @fragment_id = fragment_id
          @regexp = regexp
        end

        def replace_text!
          self.key = pinyin_name_key
          document.erb_directives[@fragment_id].gsub!(@regexp[0], @regexp[1] % translation_key_object)
        end

        def self.create(document, fragment_id)
          REGEXPS.map do |r|
            match = document.erb_directives[fragment_id].match(r[0])
            new(document, fragment_id, match[r[2]][1...-1], r) if match && match[r[2]] && match[r[2]] =~ /[\p{Han}]/
          end
        end
      end
    end
  end
end
