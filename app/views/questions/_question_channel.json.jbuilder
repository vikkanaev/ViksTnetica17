json.extract! question, :id, :title, :body, :user_id
json.sum_score question.sum_score

json.attachments question.attachments do |a|
  json.id a.id
  json.file_name a.file.identifier
  json.file_url a.file.url
end
