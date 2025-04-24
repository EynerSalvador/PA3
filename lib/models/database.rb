# lib/models/database.rb
require 'json'

class Database
  attr_reader :data

  def initialize(file_path)
    @file_path = file_path
    @data = load_data
  end

  def load_data
    if File.exist?(@file_path)
      JSON.parse(File.read(@file_path))
    else
      { 'members' => [] } # Initialize with string key
    end
  end

  def save
    File.write(@file_path, JSON.pretty_generate(@data))
  end
end
