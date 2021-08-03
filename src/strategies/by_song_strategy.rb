# frozen_string_literal: true

require_relative '../parsing_strategy'
require_relative '../song'

class BySongStrategy < ParsingStrategy
  attr_accessor :songs

  def initialize(options = { with_title: true })
    super
  end

  def parse!(links)
    @songs = links.map { |link| Song.new(link) }
    @songs.each(&:parse!)
    @songs.each do |song|
      write!(song, "#{song.title}.txt")
    end
  end

  def write!(song, file_name, output_folder = @options[:output_folder] || 'output')
    Dir.mkdir(output_folder) unless File.exist?(output_folder)

    location = "#{Dir.pwd}/#{output_folder}/#{file_name}"
    File.open(location, 'w') do |f|
      f.write(song.title << "\n") if options[:with_title]
      f.write(song.text)
    end
  end
end
