# frozen_string_literal: true

require_relative '../parsing_strategy'
require_relative '../song'

class AllSongsStrategy < ParsingStrategy
  attr_accessor :songs

  def initialize(options = { with_title: true })
    super
  end

  def parse!(links)
    @songs = links.map { |link| Song.new(link) }
    @songs.each(&:parse!)
    write!(songs, @options[:output_filename] || '_all_songs.txt')
  end

  def write!(songs, file_name, output_folder = @options[:output_folder] || 'output')
    Dir.mkdir(output_folder) unless File.exist?(output_folder)

    location = "#{Dir.pwd}/#{output_folder}/#{file_name}"
    File.open(location, 'w') do |f|
      songs.each_with_index do |song, song_index|
        f.write(@options[:songs_separator] || "\n\n\n*****\n\n\n") if song_index != 0
        f.write(song.title << "\n") if options[:with_title]
        f.write(song.text)
      end
    end
  end
end
