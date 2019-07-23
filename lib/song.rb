class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end
  
  #class constructor Song.create initializes a song and saves is to the @@all class variable either literally or through the Song.all class method:
  def self.create
    new_song = self.new
    new_song.save
    new_song
  end
  
  #class constructor Song.new_by_name takes in the name of a song
  #returns a song instance with that name set as its name prop
  def self.new_by_name(name)
    new_song = self.new
    new_song.name = name
    new_song
  end
  
  #class constructor create_by_name takes in song title and returns a song instance with that name set as a title.
  #saves the song into the @@all class variable
  def self.create_by_name(name)
    new_song = self.new
    new_song.name = name
    @@all << new_song
    new_song.save
    new_song
  end
  
  #class finder Song.find_by_name takes in string name of song and returns the matching instance of the song with that name
  def self.find_by_name(name)
    self.all.find {|song| song.name == name}
  end
  
  #Song.find_or_create_by_name method prevents duplicate songs from being created that actually represent the same songs
  #accepts a string name for a song and either returns a matching song instance or creates a new song and returns the new song instance:
  def self.find_or_create_by_name(name)
    if self.find_by_name(name)
      self.find_by_name(name)
    else
      self.create_by_name(name)
    end
  end
  
  #Song.alphabetical returns all songs in alphabetical order:
  def self.alphabetical
    @@all.uniq.sort_by {|song| song.name}
  end
  
  #Song.new_from_filename accepts filename in format of '-.mp3'
  #this constructor parses the data from the filename, returns new instance of a Song:
  def self.new_from_filename(filename)
    components = filename.split(" - ")
    song = self.new
    song.artist_name = components[0]
    song.name = components[1].chomp(".mp3")
    song
  end
  
  #Song.create_from_filename accepts a filename in format of '-.mp3'
  #not only parses filename correctly, as in Song.new_from_filename, but also saves Song instance that was created:
  def self.create_from_filename(filename)
    components = filename.split(" - ")
    song = self.new
    song.artist_name = components[0]
    song.name = components[1].chomp(".mp3")
    @@all << song
    song
  end
  
  #Song.destroy_all class method resets the state of the @@all class variable, thereby deleting all song instances
  def self.destroy_all
    @@all.clear
  end
  
end
