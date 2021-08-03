# King and Jester (Король и Шут) lyrics parser

![Gorshok](https://github.com/maxbarsukov/korol-i-shut-lyrics-parser/blob/master/docs/images/gorshok.jpg?raw=true)

> Будь как дома, путник, Я ни в чём не откажу

Allows you to collect all the lyrics of your favorite band

## What is this? 

This program will help you use the lyrics of all the songs of the King and Jester and maybe even track
the appearance of new songs by the artist. Maybe

I think each of us has his own favorite taiga musician.

## About the code

- Using Nokogiri for web scraping

## Setup

Clone this repository:

`git clone git@github.com:maxbarsukov/korol-i-shut-lyrics-parser.git`

Install gems:

`bundle install`

## Run

Run `ruby src/main.rb -h` to view the help.
```
Usage:
   ruby src/main.rb [-h] [-b/-a] [-o output_file] [-o output_folder] [-w] [-s separator] [-d]
   -h, --help           Show this help.
   -b, --by_song        Records one song lyrics per file.
                        [Enable by default]
   -a, --all_songs      Writes all the lyrics to a single file.
   -o, --output_file    Name of the output file
                        [Works with -a / --allsongs only]
   -f, --output_folder  Name of the output folder
                        ['output' by default]
   -w, --with_title     The name of the song is included in the file.
                        [Disabled by default]
   -s, --separator      Defines how song lyrics are separated.
                        [Works with -a / --allsongs only]
   -u, --url            URL to parse.
                        Works with site http://slushat-tekst-pesni.ru/ only!
                        Also, you can change the artist to another one and get
                        the lyrics of his songs
                        Be careful, changing to another site will
                        most likely lead to a breakdown of the application
   -d, --debug          Displays messages about the progress of the program.
                        [Disabled by default]
```

For example, you can run  `ruby src/main.rb -a -w -o=kish.txt -f=out -s=ANOTHER SONG!` and get one file at `out/kish.txt` with all lyrics and titles separated by `ANOTHER SONG!` string! Pretty good!

In addition, you can receive texts from any artists located on the http://slushat-tekst-pesni.ru/ website.
You only need to use a  `-u` or `--url` key with a link to the artist, for example
`ruby src/main.rb -a -o=ariya.txt -u=http://slushat-tekst-pesni.ru/ariya/` it will return you a file with all the songs of the Aria band.

## Usage

You can use this application both to simply get the lyrics of your favorite songs,
but also, for example, to collect data for AI- or ML-related applications.

You can find some of the lyrics that I have collected in the [output](https://github.com/maxbarsukov/korol-i-shut-lyrics-parser/tree/master/output) folder

## License

MIT License. Copyright 2021 Max Barsukov
