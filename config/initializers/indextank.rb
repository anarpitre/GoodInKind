CLIENT = IndexTank::Client.new(API_URL)
if Rails.env == "production"
    INDEX = CLIENT.indexes('production_idx')
else
    INDEX = CLIENT.indexes('idx')
end
