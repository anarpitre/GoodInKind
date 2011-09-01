config_file = File.join(Rails.root, 'config', 'firstgiving.yml')
FIRST_GIVING = YAML.load_file( config_file )[Rails.env]

CARD_ON_FILE_SUPPORTED = true

FIRST_GIVING_TYPEMAP = {
  'visa' => 'VI',
  'master' => 'MC',
  'discover' => 'DI',
  'amercan_express' => 'AX'
}
