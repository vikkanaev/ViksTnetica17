json.extract! answer, :id, :body, :user_id
json.sum_score answer.sum_score

json.attachments answer.attachments do |a|
  json.id a.id
  json.file_name a.file.identifier
  json.file_url a.file.url
end

json.comments answer.comments do |c|
  json.id c.id
  json.message c.message
end
