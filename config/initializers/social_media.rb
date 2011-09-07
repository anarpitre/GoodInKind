config_file = File.join(Rails.root, 'config', 'social_media.yml')
SOCIAL_MEDIA = YAML.load_file( config_file )[Rails.env]
FACEBOOK = SOCIAL_MEDIA[:facebook]
#TWITTER = SOCIAL_MEDIA[:twitter]
#LINKED_IN = SOCIAL_MEDIA[:linked_in]


