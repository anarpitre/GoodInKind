CLIENT = IndexTank::Client.new(ENV['INDEXTANK_API_URL'] || INDEXTANK_API_URL)
if Rails.env == "production"
    INDEX = CLIENT.indexes('production_idx')
else
    INDEX = CLIENT.indexes('idx')
end
