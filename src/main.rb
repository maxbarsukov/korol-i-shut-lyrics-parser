# frozen_string_literal: true

require_relative 'parser'
require_relative 'strategies/all_songs_strategy'
require_relative 'strategies/by_song_strategy'

USAGE = <<~ENDUSAGE
  Usage:
     ruby src/main.rb [-h] [-b/-a] [-o output_file] [-o output_folder] [-w true/false] [-s separator] [-d]
ENDUSAGE

HELP = <<ENDHELP
   -h, --help           Show this help.
   -b, --by_song        Records one song lyrics per file.
                        [Enable by default]
   -a, --all_songs      Writes all the lyrics to a single file.
   -o, --output_file    Name of the output file
                        [Works with -a / --allsongs only]
   -f, --output_folder  Name of the output folder
                        ['output' by default]
   -w, --with_title     The name of the song is included in the file.
                        [Enabled by default]
   -s, --separator      Defines how song lyrics are separated.
                        [Works with -a / --allsongs only]
   -d, --debug          Displays messages about the progress of the program.
                        [Disabled by default]
ENDHELP

# -x=foo -h --jim=jam
# =>
# {"x"=>"foo", "h"=>nil, "jim"=>"jam"}
ARGS = Hash[ARGV.flat_map { |s| s.scan(/--?([^=\s]+)(?:=(\S+))?/) }]

# Setting default values
OPTIONS = { output_file: '_all_songs.txt',
            output_folder: 'output',
            with_title: true,
            separator: "\n\n\n\n\n"}

ARGS.each do |key, value|
  case key
  when 'h', 'help'           then OPTIONS[:help]           = true
  when 'a', 'all_songs'      then OPTIONS[:all_songs]      = true
  when 'b', 'by_song'        then OPTIONS[:by_song]        = true
  when 'w', 'with_title'     then OPTIONS[:with_title]     = value == 'true'
  when 'o', 'output_file'    then OPTIONS[:output_file]    = value
  when 'f', 'output_folder'  then OPTIONS[:output_folder]  = value
  when 's', 'separator'      then OPTIONS[:separator]      = value
  when 'd', 'debug'          then OPTIONS[:debug]          = true
  end
end

if OPTIONS[:help]
  puts USAGE
  puts HELP
  exit
end

parsing_strategy = if OPTIONS[:by_song]
                     BySongStrategy.new(OPTIONS)
                   else
                     AllSongsStrategy.new(OPTIONS)
                   end

URL = 'http://slushat-tekst-pesni.ru/korol-i-shut/'
parser = Parser.new(URL, parsing_strategy)
parser.collect_links
parser.parse_links!
