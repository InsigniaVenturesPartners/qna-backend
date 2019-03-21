# Load the Rails application.
require_relative 'application'

TOPICS = YAML.load_file(Rails.root + 'config/topics.yml').with_indifferent_access

# Initialize the Rails application.
Rails.application.initialize!
