json.extract! draft, :id, :body

question = draft.question

json.author do
  json.partial! 'api/users/user', user: draft.author
end

json.question do
  json.id question.id
  json.body question.body
end

json.time_posted_ago draft.time_posted_ago
