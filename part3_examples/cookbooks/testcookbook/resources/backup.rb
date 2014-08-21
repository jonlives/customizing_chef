actions :compress, :extract

default_action :compress

attribute :name, :kind_of => String, :name_attribute => true
attribute :backup_file, :kind_of => String
attr_accessor :exists