config_file = File.join(Rails.root, 'config', 'firstgiving.yml')
FIRST_GIVING = YAML.load_file( config_file )[Rails.env]