
class MusicLibraryController

    attr_accessor :path
    
    def initialize(path = "./db/mp3s")
        self.path = path
        MusicImporter.new("#{self.path}").import
    end

    def call
        entry = nil
        until entry == "exit"
            puts "Welcome to your music library!"
            puts "To list all of your songs, enter 'list songs'."
            puts "To list all of the artists in your library, enter 'list artists'."
            puts "To list all of the genres in your library, enter 'list genres'."
            puts "To list all of the songs by a particular artist, enter 'list artist'."
            puts "To list all of the songs of a particular genre, enter 'list genre'."
            puts "To play a song, enter 'play song'."
            puts "To quit, type 'exit'."
            puts "What would you like to do?"
            entry = gets
        
            case entry
            when "list songs"
              self.list_songs
            when "list artists"
              self.list_artists
            when "list genres"
              self.list_genres
            when "list artist"
              self.list_songs_by_artist
            when "list genre"
              self.list_songs_by_genre
            when "play song"
              self.play_song
            end
        end
    end

    def list_songs
        songs_in_name_order = Song.all.sort {|song1, song2| song1.name <=> song2.name}
        songs_in_name_order.each.with_index(1) do |song, index|
            puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end

    def list_artists
        artists_in_name_order = Artist.all.sort {|artist1, artist2| artist1.name <=> artist2.name}
        artists_in_name_order.each.with_index(1) do |artist, index|
            puts "#{index}. #{artist.name}"
        end
    end

    def list_genres
        genres_in_name_order = Genre.all.sort {|genre1, genre2| genre1.name <=> genre2.name}
        genres_in_name_order.each.with_index(1) do |genre, index|
            puts "#{index}. #{genre.name}"
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        artist_input = gets
        artist = Artist.find_by_name(artist_input)
        if artist
            sorted = artist.songs.sort {|song1,song2| song1.name <=> song2.name}
            sorted.each.with_index(1) do |song , index|
                puts "#{index}. #{song.name} - #{song.genre.name}"
            end
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        genre_input = gets
        genre = Genre.find_by_name(genre_input)
        if genre
            sorted = genre.songs.sort {|song1,song2| song1.name <=> song2.name}
            sorted.each.with_index(1) do |song , index|
                puts "#{index}. #{song.artist.name} - #{song.name}"
            end
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        choice_index = gets.to_i - 1
        if (1..(Song.all.count)).include?(choice_index + 1)
            song = Song.all.sort {|song1, song2| song1.name <=> song2.name}[choice_index]
            puts "Playing #{song.name} by #{song.artist.name}" 
        end
    end
end



