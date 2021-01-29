
class Song

    attr_accessor :name
    attr_reader :artist, :genre
    @@all = []
    
    extend Concerns::Findable

    def initialize(name, artist = nil, genre = nil)
        self.name = name
        self.artist = artist if artist
        self.genre = genre if genre
        # self.save
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.songs << self unless genre.songs.include?(self)
    end

    def self.all
        @@all
    end

    def save
        @@all << self
    end

    def self.destroy_all
        self.all.clear
    end

    def self.create(name)
        inst = self.new(name)
        inst.save
        inst
    end

    def self.new_from_filename(filename)
        song_attributes = filename.split(".mp3")[0].split(" - ")
        song_name = song_attributes [1]
        artist_name = song_attributes[0]
        genre_name = song_attributes[2]
        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)
        self.new(song_name, artist, genre) if !self.find_by_name(song_name)
    end

    def self.create_from_filename(filename)
        song = self.new_from_filename(filename)
        song.save
    end
        
end








        



