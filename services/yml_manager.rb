class YmlManager
	# FOLDER_PATH = '/media/patron/A6ED-A40F'.freeze - for linux
  FOLDER_PATH = 'C:/Users/Admin/gizma/temp'.freeze

  def initialize
  	@folder_path = FOLDER_PATH

  	create_default_files_if_not_exits
  end

  def load_all_positions
    load_rutor_positions
    load_youtube_positions
  end

  def load_rutor_positions
  	full_file_path = "#{FOLDER_PATH}/rutor_positions.yml"

  	if File.exist?(full_file_path)
  	  $rutor_positions = YAML.load(File.read(full_file_path))
    end
  end

  def save_rutor_positions
  	full_file_path = "#{FOLDER_PATH}/rutor_positions.yml"

  	File.open(full_file_path, 'w') { |file| file.write($rutor_positions.to_yaml) }
  end

  def load_youtube_positions
  	full_file_path = "#{FOLDER_PATH}/youtube_positions.yml"

  	if File.exist?(full_file_path)

  	  $youtube_positions = YAML.load(File.read(full_file_path))
    end
  end

  def save_youtube_positions
  	full_file_path = "#{FOLDER_PATH}/youtube_positions.yml"

  	File.open(full_file_path, 'w') { |file| file.write($youtube_positions.to_yaml) }
  end

  def youtube_file_exist?
  	full_file_path = "#{FOLDER_PATH}/youtube_positions.yml"

  	File.exist?(full_file_path)
  end

  def rutor_file_exist?
  	full_file_path = "#{FOLDER_PATH}/rutor_positions.yml"

  	File.exist?(full_file_path)
  end

  private

  attr_reader :folder_path, :data

  def create_default_files_if_not_exits

  end
end
