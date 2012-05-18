require 'yaml'
yml = YAML.load_file(File.dirname(__FILE__) + '/../password_expiration.yml')
PASSWD_EXPIRATION_DAYS = yml['password_settings']['expiration_time']
