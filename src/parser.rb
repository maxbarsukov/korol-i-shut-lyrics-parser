# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'uri'

class Parser
  attr_accessor :parsing_strategy

  def initialize(url, parsing_strategy)
    @url = url
    @parsing_strategy = parsing_strategy
    @song_links = []

    uri = URI.parse(url)
    @base_url = "#{uri.scheme}://#{uri.host}"
  end

  def parse_links!
    parsing_strategy.parse!(@song_links)
  end

  def collect_links
    doc = Nokogiri::HTML(URI.open(@url))
    @song_links = doc
                  .xpath('//div[@class="col-sm-6"]/ul[@class="nolist"]/li/a/@href')
                  .map(&:value)
                  .map { |link| @base_url + link }
  end
end
