  require 'pry'
class MusicImporter
  attr_accessor :path

  def initialize(path)
    @path = path
  end

  # def files
  #   Dir.entries(path).select{|file| file.include?(".mp3")}
  # end

  def files
   @files ||= Dir.glob("#{path}/*.mp3").collect do |f|
     binding.pry
     f.gsub("#{path}/", "")
   end
 end

  def import
    self.files.each {|file| Song.create_from_filename(file)}
  end
end
