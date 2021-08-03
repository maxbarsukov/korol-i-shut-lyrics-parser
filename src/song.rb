# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

class Song
  attr_reader :text, :title

  def initialize(url)
    @url = url
  end

  def parse!
    doc = Nokogiri::HTML(URI.open(@url))
    @title = doc.css('li.active')[0].text
    @text = doc.css('div.abp')[0]
               .inner_html
               .gsub('<br>', "\n")
               .gsub('<br/>', "\n")
               .gsub('<br />', "\n")
               .gsub('&amp;', '')
               .gsub('&nbsp;', ' ')
  end

  def parse
    parse!
    [@title, @text]
  end
end
