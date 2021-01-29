require 'pry'
class MusicImporter

    attr_reader :path

    def initialize(path)
        @path = path
    end


    def files
        file_paths = Dir.glob("#{self.path}/*.mp3")
        file_paths.collect {|file_path| File.basename(file_path)}
    end

    def import
        self.files.each {|file| Song.create_from_filename(file)}
    end
         

end