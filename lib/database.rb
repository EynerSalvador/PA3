require 'json'

class JSONDatabase
  def initialize(file_path = '_data/members.json')
    @file_path = file_path
    load_data
  end

  def all_members
    @data['members'] || []
  end

  def add_member(member_data)
    @data['members'] ||= []
    @data['members'] << member_data
    save_data
  end

  private

  def load_data
    @data = File.exist?(@file_path) ? JSON.parse(File.read(@file_path)) : {}
  end

  def save_data
    File.write(@file_path, JSON.pretty_generate(@data))
  end
end
