require 'strscan'

class Name
  def self.parse(text)
    new(text).parse
  end

  attr_reader :original

  def initialize(text)
    @original = text.strip
  end

  def parse
    parts = []
    scanner = StringScanner.new(@original)

    latest_part = nil
    until scanner.eos?
      text = scanner.scan(/[^ ,]+/)
      if text
        if text =~ /^"(.*)"$/
          parts << { content: '"' }
          parts << { content: $1, type: :nickname }
          parts << { content: '"' }
        else
          type = title?(text) ? :title : :given
          parts << { content: text, type: type }
        end
      end

      text = scanner.scan(/[ ,]+/)
      if text
        parts << { content: text }
      end
    end

    parts = consolidate_adjacent_whitespace parts
    index = index_parts parts
    consolidate_surname_parts parts, index
  end

  def as_json(*args)
    { original: @original,
      parts:    parse }
  end

  private

  TITLES = %w(mr ms mrs sir dr jr sr)
  NUMERALS = %w(I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI XVII XVIII XIX XX)

  def title?(text)
    TITLES.include?(text.sub(/\.$/, "").downcase) || roman_numeral?(text)
  end

  def roman_numeral?(text)
    NUMERALS.include?(text)
  end

  def index_parts(parts)
    index = Hash.new { |h,k| h[k] = [] }
    parts.each_with_index do |part, n|
      index[part[:type]] << n
    end
    index
  end

  def consolidate_adjacent_whitespace(parts)
    index = 0

    while index < parts.length-1
      if !parts[index][:type] && !parts[index+1][:type]
        parts[index][:content] << parts[index+1][:content]
        parts.delete_at(index+1)
      else
        index += 1
      end
    end

    parts
  end

  def consolidate_surname_parts(parts, index)
    if index[:given].length > 1 || index[:given].any? && index[:title].any?
      surname = index[:given].last
      parts[surname][:type] = :surname

      index = surname
      loop do
        index -= 1
        break if index < 0
        break if parts[index][:type]
      end

      if index >= 0 && parts[index][:type] == :given && parts[index][:content].downcase == "van"
        content = ""
        n = index
        while n <= surname
          content << parts[n][:content]
          n += 1
        end
        part = { content: content, type: :surname }
        parts[index..surname] = part
      end
    end

    parts
  end
end
