# frozen_string_literal: true

class ParsingStrategy
  attr_accessor :options

  def initialize(options)
    @options = options
  end

  def parse!(links)
    raise NotImplementedError,
          "#{self.class} has not implemented method '#{__method__}'"
  end
end
