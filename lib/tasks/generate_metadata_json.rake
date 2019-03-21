namespace :gen do
  desc "generate topics.yml to public/v1/topics.json"
  task topics: [:environment] do
    File.open("public/v1/topics.json", "w") do |f|
      f.write(TOPICS.to_json)
    end
  end

end