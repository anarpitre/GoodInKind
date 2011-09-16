config_file = File.join(Rails.root, 'config', 'firstgiving.yml')
FIRST_GIVING = YAML.load_file( config_file )[Rails.env]

CARD_ON_FILE_SUPPORTED = false

CHARITY_SEARCH = "http://graphapi.firstgiving.com/v1/list/organization"

FIRST_GIVING_TYPEMAP = {
  'visa' => 'VI',
  'master' => 'MC',
  'discover' => 'DI',
  'american_express' => 'AX'
}

FIRST_GIVING_CC_RATE = 0 
