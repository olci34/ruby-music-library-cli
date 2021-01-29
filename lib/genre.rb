class Genre
    attr_accessor :name
    attr_reader :songs
    @@all = []
    extend Concerns::Findable

    def initialize(name)
        self.name = name
        @songs = []
    end

    def self.all
        @@all
    end

    def save
        self.class.all << self
    end

    def self.destroy_all
        self.all.clear
    end

    def self.create(name)
        inst = self.new(name)
        inst.save
        inst
    end

    def songs
        @songs
    end

    def artists
        self.songs.collect {|song| song.artist}.uniq
    end

end