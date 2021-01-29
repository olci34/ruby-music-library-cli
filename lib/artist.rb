class Artist

    attr_accessor :name
    attr_reader :songs
    @@all = []

    extend Concerns::Findable

    def initialize(name)
        self.name = name
        @songs = []
        # self.save
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

    def add_song(song)
        song.artist = self if song.artist == nil
        self.songs << song unless self.songs.include?(song)
    end

    def genres
        self.songs.collect {|song| song.genre}.uniq
    end
    

end